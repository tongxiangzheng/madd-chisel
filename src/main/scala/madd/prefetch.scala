package madd

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

class ItemData(val pcWidth: Int,val addressWidth: Int) extends Bundle {
  val pc = UInt(pcWidth.W)
  val address = UInt(addressWidth.W)
	val stride = SInt(addressWidth.W+1) //SInt 记得大小加一
  val timestamp = UInt(32.W)
}

class Prefetch(val pcWidth: Int,val addressWidth: Int) extends Module {
  val io = IO(new PrefetchIO(pcWidth,addressWidth))
  val size = 8
  val dfn = RegInit(0.U(32.W))
  val lastPC = RegInit(0.U(pcWidth.W))

  val queueWire = Wire(Vec(size,new ItemData(pcWidth,addressWidth)))
  for (i <- 0 until size) {
	  queueWire(i).pc:=0.U(pcWidth.W)
	  queueWire(i).address:=0.U(addressWidth.W)
	  queueWire(i).stride:=0.S(addressWidth.W+1)
    queueWire(i).timestamp:=0.U(32.W)
  }
  val queueReg = RegInit(queueWire)

  var enable = io.pc =/= lastPC
  enable = Mux(io.pc===0.U,false.B,enable)
  lastPC:=io.pc

  var p=fifoFind(io.pc)
  when(p===size.U){
    io.prefetch_valid:=Mux(enable,false.B,io.prefetch_valid)
    io.prefetch_address:=Mux(enable,DontCare,io.prefetch_valid)
  }.otherwise{
    io.prefetch_valid:=Mux(enable,true.B,io.prefetch_valid)
    io.prefetch_address:=Mux(enable,queueReg(p).address,io.prefetch_address)
  }
  /*chisel3.printf(
    p"main: p: ${p} pc: ${io.pc} prefetch_valid: ${io.prefetch_valid} prefetch_address: ${io.prefetch_address}\n"
  )*/
  fifoWrite(io.pc,io.address,10.S,enable)


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
  def fifoWrite(pc:UInt,address:UInt,stride:SInt,enable:Bool):Unit = {
    var p=0.U
    var found=Mux(enable,false.B,true.B)
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
    dfn:=dfn+1.U
    queueReg(p).timestamp:=dfn
  }
}

object Prefetch extends App {
  (new ChiselStage).execute(
    Array("-X", "verilog", "-td", "source/"),
    Seq(
      ChiselGeneratorAnnotation(() => new Prefetch(32, 32))
    )
  )
}