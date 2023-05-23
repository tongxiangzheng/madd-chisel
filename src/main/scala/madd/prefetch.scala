package madd

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

class ItemData(val pcWidth: Int,val addressWidth: Int) extends Bundle {
  val pc = UInt(pcWidth.W)
  val address = UInt(addressWidth.W)
  val timestamp = UInt(32.W)
	val stride = UInt(addressWidth.W)
  //val haveStride = Bool()
  val reliability = UInt(32.W)
}

class Prefetch(val pcWidth: Int,val addressWidth: Int) extends Module {
  val io = IO(new PrefetchIO(pcWidth,addressWidth))
  val size = 8
  val dfn = RegInit(0.U(32.W))
  val lastPC_ = RegInit(0.U(pcWidth.W))
  val prefetch_valid = RegInit(false.B)
  val prefetch_address = RegInit(0.U(addressWidth.W))
  val ready = RegInit(false.B)
  val inited = RegInit(false.B)
  //val unblock = RegInit(false.B)
  //val enable = RegInit(false.B)
  //val stride = RegInit(0.U(addressWidth.W))
  //val reliability = RegInit(0.U(32.W))
  
  val queueWire = Wire(Vec(size,new ItemData(pcWidth,addressWidth)))
  for (i <- 0 until size) {
	  queueWire(i).pc:=0.U(pcWidth.W)
	  queueWire(i).address:=0.U(addressWidth.W)
	  queueWire(i).stride:=0.U(addressWidth.W)
    queueWire(i).reliability:=0.U(addressWidth.W)
    queueWire(i).timestamp:=0.U(32.W)
    //queueWire(i).haveStride:=false.B
    
  }
  val queueReg = RegInit(queueWire)



  def init():Unit={
    for (i <- 0 until size) {
	    queueReg(i).pc:=0.U
	    queueReg(i).address:=0.U
	    queueReg(i).stride:=0.U
      queueReg(i).reliability:=0.U
      queueReg(i).timestamp:=0.U
      //queueReg(i).haveStride:=false.B
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
  def fifoWrite(pc:UInt,address:UInt,stride:UInt,reliability:UInt):Unit = {
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
    //queueReg(p).haveStride:=haveStride
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
  when(io.reset){
    when(!RegNext(io.reset)){
      init()
      inited:=true.B
    }
  }.otherwise{
    inited:=false.B
  }
  io.inited:=inited
  //unblock:=
  var enable = io.enable & !RegNext(io.enable)
  //unblock:=Mux(io.enable,false.B,true.B)
  //lastPC:=io.pc
  
  //val stride = RegInit(0.U(addressWidth.W))
  //val newStride = RegInit(0.U(addressWidth.W))
  //val reliability = RegInit(0.U(32.W))
  //val prereliability = RegInit(0.U(32.W))
  //val replace = RegInit(false.B)
  //chisel3.printf(p"0 pc: ${queueReg(0).pc} address: ${queueReg(0).address} stride: ${queueReg(0).stride} reliability: ${queueReg(0).reliability} \n");
  //chisel3.printf(p"io.enable: ${io.enable} unblock: ${unblock} \n");
  
  //chisel3.printf(p"enable: ${enable} replace: ${replace} reliability: ${reliability} stride: ${stride} newStride: ${newStride} prereliability: ${prereliability}\n");
  when(enable){
    enable=false.B
    var p=fifoFind(io.pc)
    var found = (p=/=size.U)

    when(found){
      val newStride=io.address-queueReg(p).address
      //prereliability:=queueReg(p).reliability
      val reliability=calcReliability(queueReg(p).stride,queueReg(p).reliability,newStride)
      val replace=(reliability===0.U)
      
      val stride=Mux(replace,newStride,queueReg(p).stride)
      val w_reliability=Mux(replace,1.U,reliability)
      val valid=w_reliability>1.U
      prefetch_valid:=valid
      prefetch_address:=Mux(valid,io.address+stride,0.U)
      fifoWrite(io.pc,io.address,stride,w_reliability)
    }.otherwise{
      fifoWrite(io.pc,io.address,0.U,0.U)
      prefetch_address:=0.U
      prefetch_valid:=false.B
    }
    /*chisel3.printf(
      p"write: p: ${p} pc: ${io.pc} reliability: ${reliability}\n"
    )*/
  }

  ready:=io.enable
  io.ready:=RegNext(ready)
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

(new ChiselStage).emitVerilog(new Prefetch(32, 32))