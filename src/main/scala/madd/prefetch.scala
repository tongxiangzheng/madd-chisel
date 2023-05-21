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
  val size = 64
  var dfn = 0.U(32.W)
  val queueWire = Wire(Vec(size,new ItemData(pcWidth,addressWidth)))
  for (i <- 0 until size) {
	  queueWire(i).pc:=0.U(pcWidth.W)
	  queueWire(i).address:=0.U(addressWidth.W)
	  queueWire(i).stride:=0.S(addressWidth.W+1)
    queueWire(i).timestamp:=0.U(32.W)
  }
  val queueReg = RegInit(queueWire)

  io.prefetch_address:=DontCare
  io.prefetch_valid:=true.B

  def fifoFind(pc: UInt):UInt = {
    var p=size.U
    //var found=false.B
    for(i <- 0 until size){
      val check=(queueReg(i).pc===pc)
      p=Mux(check,i.U,p)
    }
    p
  }
  def fifoWrite(pc:UInt,address:UInt,stride:UInt):Unit = {
    var p=0.U
    var found=false.B
    for(i <- 0 until size){
      val check=(queueReg(i).pc===pc)
      var select=Mux(found,false.B,check)
      found=Mux(select,true.B,found)
      p=Mux(check,i.U,p)
    }
    for(i <- 0 until size){
      val check=(queueReg(i).pc===0.U)
      var select=Mux(found,false.B,check)
      found=Mux(select,true.B,found)
      p=Mux(check,i.U,p)
    }
    for(i <- 0 until size){
      val check=(dfn-queueReg(i).timestamp>dfn-queueReg(p).timestamp)
      var select=Mux(found,false.B,check)
      p=Mux(check,i.U,p)
    }
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