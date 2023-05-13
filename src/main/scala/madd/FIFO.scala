package madd

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

class ItemData(val pcWidth: UInt,val addressWidth: UInt) extends Bundle {
    val pc = UInt(pcWidth.W)
    val address = UInt(addressWidth.W)
	val stride = SInt(addressWidth.W+1.W) //SInt 记得大小加一
}

class FIFO(val size: UInt,val pcWidth: UInt,val addressWidth: UInt) extends Module {
  val io = IO(new PrefetchIO(pcWidth,addressWidth))
  val queueWire = Wire(Vec(size,new ItemData(pcWidth,addressWidth)))
  for (i <- 0 until size) {
	queueWire(i).pc=0.U(pcWidth.W)
	queueWire(i).address=0.U(addressWidth.W)
	queueWire(i).stride=0.S(addressWidth.W+1)
  }
  io.find:=io.enIn
  
}

object FIFO extends App {
  (new ChiselStage).execute(
    Array("-X", "verilog", "-td", "source/"),
    Seq(
      ChiselGeneratorAnnotation(() => new FIFO(64,32, 32))
    )
  )
}