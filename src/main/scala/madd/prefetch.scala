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
  //val stride = RegInit(0.U(addressWidth.W))
  //val reliability = RegInit(0.U(32.W))
  
  val queueWire = Wire(Vec(size,new ItemData(pcWidth,addressWidth)))
  for (i <- 0 until size) {
	  queueWire(i).pc:=0.U(pcWidth.W)
	  queueWire(i).address:=0.U(addressWidth.W)
	  queueWire(i).stride:=0.S(addressWidth.W+1)
    queueWire(i).timestamp:=0.U(32.W)
    queueWire(i).haveStride:=false.B
  }
  val queueReg = RegInit(queueWire)




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
    //返回可信度，为0表示替换为newStride
    val same=(stride===newstride)
    var ans=reliability+1.U
    var solve=same;
    ans=Mux(solve,ans,reliability>>1)
  }
  
  
//start

  var enable = io.pc =/= lastPC
  enable = Mux(io.pc===0.U,false.B,enable)
  lastPC:=io.pc
  when(enable){
    var p=fifoFind(io.pc)
    var found = (p=/=size.U)
    prefetch_valid:=found
    var stride=0.U
    var reliability=0.U
    when(found){
      var newStride=io.address-queueReg(p).address

      reliability=calcReliability(queueReg(p).stride,queueReg(p).reliability,newStride)
      val replace=(reliability===0.U)
      stride=Mux(replace,newStride,queueReg(p).stride)
      prefetch_address:=io.address+stride
    }.otherwise{
      prefetch_address:=0.U
    }
    /*chisel3.printf(
      p"main: p: ${p} pc: ${io.pc} prefetch_valid: ${io.prefetch_valid} prefetch_address: ${io.prefetch_address}\n"
    )*/
    fifoWrite(io.pc,io.address,stride,reliability,found)
  }
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