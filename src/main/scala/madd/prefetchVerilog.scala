package madd

import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.stage.ChiselStage

/*
*/
object PrefetchVerilog extends App {
  (new ChiselStage).execute(
  Array("--target", "systemverilog"),
  Seq(ChiselGeneratorAnnotation(() => new Prefetch(32, 32)),
    FirtoolOption("--disable-all-randomization")))

  /*val verilogString = chisel3.getVerilogString(new Prefetch(32, 32))
  println(verilogString)*/
}