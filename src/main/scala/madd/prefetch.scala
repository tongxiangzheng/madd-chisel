package madd

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

class Prefetch(val pcWidth: UInt,val addressWidth: UInt) extends Module {
  val io = IO(new PrefetchIO(pcWidth,addressWidth))
  
}

object Prefetch extends App {
  (new ChiselStage).execute(
    Array("-X", "verilog", "-td", "source/"),
    Seq(
      ChiselGeneratorAnnotation(() => new Prefetch(32, 32))
    )
  )
}