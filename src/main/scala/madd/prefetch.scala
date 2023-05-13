package madd

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

class ItemData(val pcWidth: Int,val addressWidth: Int) extends Bundle {
    val pc = UInt(pcWidth.W)
    val address = UInt(addressWidth.W)
	val stride = SInt(addressWidth.W+1) //SInt 记得大小加一
}

class Prefetch(val pcWidth: Int,val addressWidth: Int) extends Module {
  val io = IO(new PrefetchIO(pcWidth,addressWidth))
  val size = 64
  val queueWire = Wire(Vec(size,new ItemData(pcWidth,addressWidth)))
  for (i <- 0 until size) {
	  queueWire(i).pc:=0.U(pcWidth.W)
	  queueWire(i).address:=0.U(addressWidth.W)
	  queueWire(i).stride:=0.S(addressWidth.W+1)
  }
  val queueReg = RegInit(queueWire)

  io.prefetch_address=DontCare
  io.prefetch_valid=true.B
}

object Prefetch extends App {
  (new ChiselStage).execute(
    Array("-X", "verilog", "-td", "source/"),
    Seq(
      ChiselGeneratorAnnotation(() => new Prefetch(32, 32))
    )
  )
}