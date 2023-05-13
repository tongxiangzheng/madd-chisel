package madd

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

class ItemData(val pcWidth: UInt,val addressWidth: UInt) extends Bundle {
    val pc = UInt(32)
    val address = UInt(32)
	val stride = SInt(33) //SInt 记得大小加一
}

class FIFO(val size: UInt,val pcWidth: UInt,val addressWidth: UInt) extends Module {
  val io = IO(new PrefetchIO(pcWidth,addressWidth))
  /*val queueWire = Wire(Vec(size,new ItemData(pcWidth,addressWidth)))
  for (i <- 0 until size) {
	queueWire(i).pc=0.U(pcWidth)
	queueWire(i).address=0.U(addressWidth)
	queueWire(i).stride=0.S(addressWidth+1)
  }*/

  io.find:=io.enIn
  
}

object FIFO extends App {
  (new ChiselStage).execute(
    Array("-X", "verilog", "-td", "source/"),
    Seq(
      ChiselGeneratorAnnotation(() => new FIFO(64 ,32, 32))
    )
  )
}