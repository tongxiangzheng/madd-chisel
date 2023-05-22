package madd

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

class FIFO(val size: Int,val pcWidth: Int,val addressWidth: Int) extends Module {
  val io = IO(new FIFOIO(pcWidth,addressWidth))
  /*val queueWire = Wire(Vec(size,new ItemData(pcWidth,addressWidth)))
  for (i <- 0 until size) {
	queueWire(i).pc:=0.U(pcWidth.W)
	queueWire(i).address:=0.U(addressWidth.W)
	queueWire(i).stride:=0.S(addressWidth.W+1)
  }
  val queueReg = RegInit(queueWire)
  */
  io.find:=io.enIn
  io.addressOut:=DontCare
  io.strideOut:=DontCare
  
}

object FIFO extends App {
  (new ChiselStage).execute(
    Array("-X", "verilog", "-td", "source/"),
    Seq(
      ChiselGeneratorAnnotation(() => new FIFO(64,32, 32))
    )
  )
}