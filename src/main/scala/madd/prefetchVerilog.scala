import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.stage.ChiselStage

/*
*/
object PrefetchVerilog extends App {
  /*(new ChiselStage).execute(
  Array("--target", "systemverilog"),
  Seq(ChiselGeneratorAnnotation(() => new Prefetch(32, 32)),
    FirtoolOption("--disable-all-randomization")))*/

  val verilogString = chisel3.getVerilogString(new FirFilter(8, Seq(0.U, 1.U)))
  println(verilogString)
}