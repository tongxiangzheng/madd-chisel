package madd

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

class ItemData(val pcWidth: Int,val addressWidth: Int) extends Bundle {
  val pc = UInt(pcWidth.W)
  val address = UInt(addressWidth.W)
  val timestamp = UInt(32.W)
	val stride = UInt(addressWidth.W)
  val haveStride = Bool()
  val reliability = UInt(32.W)
}

class Prefetch(val pcWidth: Int,val addressWidth: Int) extends Module {
  val io = IO(new PrefetchIO(pcWidth,addressWidth))
  val size = 8
  val dfn = RegInit(0.U(32.W))
  val lastPC = RegInit(0.U(pcWidth.W))
  val prefetch_valid = RegInit(false.B)
  val prefetch_address = RegInit(0.U(addressWidth.W))
  val ready = RegInit(false.B)
  val inited = RegInit(false.B)
  val unblock = RegInit(false.B)
  
  //val stride = RegInit(0.U(addressWidth.W))
  //val reliability = RegInit(0.U(32.W))
  
  val queueWire = Wire(Vec(size,new ItemData(pcWidth,addressWidth)))
  for (i <- 0 until size) {
	  queueWire(i).pc:=0.U(pcWidth.W)
	  queueWire(i).address:=0.U(addressWidth.W)
	  queueWire(i).stride:=0.U(addressWidth.W)
    queueWire(i).reliability:=0.U(addressWidth.W)
    queueWire(i).timestamp:=0.U(32.W)
    queueWire(i).haveStride:=false.B
    
  }
  val queueReg = RegInit(queueWire)



  def init():Unit={
    for (i <- 0 until size) {
	    queueReg(i).pc:=0.U
	    queueReg(i).address:=0.U
	    queueReg(i).stride:=0.U
      queueReg(i).reliability:=0.U
      queueReg(i).timestamp:=0.U
      queueReg(i).haveStride:=false.B
    }
    dfn:=0.U
  }
  def fifoFind(pc: UInt):UInt = {
    var p=size.U
    //var found=false.B
    for(i <- 0 until size){
      val check=(queueReg(i).pc===pc)
      p=Mux(check,i.U,p)
      /*chisel3.printf(
        p"find: ${i} queueReg(i).pc ${queueReg(i).pc} check: ${check} p: ${p}\n"
      )*/
    }
    p
  }
  def fifoWrite(pc:UInt,address:UInt,stride:UInt,reliability:UInt,haveStride:Bool):Unit = {
    var p=0.U
    var found=false.B
    //是否有该项
    for(i <- 0 until size){
      val check=(queueReg(i).pc===pc)
      /*chisel3.printf(
        p"check1: p: ${p} queueReg(i).pc: ${queueReg(i).pc}\n"
      )*/
      val select=Mux(found,false.B,check)
      found=Mux(select,true.B,found)
      p=Mux(select,i.U,p)
    }
    //是否有空位
    for(i <- 0 until size){
      val check=(queueReg(i).pc===0.U)
      /*chisel3.printf(
        p"check2: p: ${p} queueReg(i).pc: ${queueReg(i).pc}\n"
      )*/
      val select=Mux(found,false.B,check)
      found=Mux(select,true.B,found)
      p=Mux(select,i.U,p)
    }
    //替换最老的
    for(i <- 0 until size){
      val check=(dfn-queueReg(i).timestamp>dfn-queueReg(p).timestamp)
      /*chisel3.printf(
        p"check3: p: ${p} dfn: ${dfn} timestamp: ${queueReg(i).timestamp} cmp_timestamp:${queueReg(p).timestamp}\n"
      )*/
      val select=Mux(found,false.B,check)
      p=Mux(select,i.U,p)
    }
    /*chisel3.printf(
      p"write: found: ${found} p: ${p}\n"
    )*/
    queueReg(p).pc:=pc
    queueReg(p).address:=address
    queueReg(p).stride:=stride
    queueReg(p).haveStride:=haveStride
    queueReg(p).reliability:=reliability
    dfn:=dfn+1.U
    queueReg(p).timestamp:=dfn
  }
  def calcReliability(stride:UInt,reliability:UInt,newStride:UInt):UInt={
    //实现替换策略
    //返回可信度，为0表示替换为newStride
    val same=(stride===newStride)
    val ans=Mux(same,reliability+1.U,reliability>>1)
    ans
  }
  

//start
  when(io.reset===true.B){
    when(inited===false.B){
      init()
      inited:=true.B
    }
  }.otherwise{
    inited:=false.B
  }
  io.inited:=inited

  val change = io.pc =/= lastPC
  val enable = Mux(io.enable&&unblock,change,false.B)
  unblock=Mux(io.enable,false.B,true.B)
  lastPC:=io.pc
  
  val stride = RegInit(0.U(addressWidth.W))
  val newStride = RegInit(0.U(addressWidth.W))
  val reliability = RegInit(0.U(32.W))
  val prereliability = RegInit(0.U(32.W))
  val replace = RegInit(false.B)
  chisel3.printf(p"0 pc: ${queueReg(0).pc} stride: ${queueReg(0).stride} reliability: ${queueReg(0).reliability} \n");
  chisel3.printf(p"1 pc: ${queueReg(1).pc} stride: ${queueReg(1).stride} reliability: ${queueReg(1).reliability} \n");
  
  chisel3.printf(p"enable: ${enable} replace: ${replace} reliability: ${reliability} stride: ${stride} newStride: ${newStride} prereliability: ${prereliability}\n");
  when(enable){
    var p=fifoFind(io.pc)
    var found = (p=/=size.U)
    prefetch_valid:=found
    //var stride=0.U(32.W)
    //var reliability=0.U(32.W)
    when(found){
      newStride:=io.address-queueReg(p).address
      prereliability:=queueReg(p).reliability
      reliability:=calcReliability(queueReg(p).stride,queueReg(p).reliability,newStride)
      replace:=(reliability===0.U)
      
      stride:=Mux(replace,newStride,queueReg(p).stride)
      prefetch_address:=io.address+stride
      ready:=true.B
    }.otherwise{
      prefetch_address:=0.U
      reliability:=0.U
      stride:=0.U
    }
    fifoWrite(io.pc,io.address,stride,reliability,found)
    /*chisel3.printf(
      p"write: p: ${p} pc: ${io.pc} reliability: ${reliability}\n"
    )*/
  }

  ready:=io.enable
  io.ready:=ready
  io.prefetch_valid:=prefetch_valid
  io.prefetch_address:=prefetch_address
  
}

object Prefetch extends App {
  (new ChiselStage).execute(
    Array("-X", "verilog", "-td", "source/"),
    Seq(
      ChiselGeneratorAnnotation(() => new Prefetch(32, 32))
    )
  )
}