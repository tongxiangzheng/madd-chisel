import chisel3.stage.ChiselGeneratorAnnotation
import circt.stage.{ChiselStage, FirtoolOption}

/*(new ChiselStage).execute(
  Array("--target", "systemverilog"),
  Seq(ChiselGeneratorAnnotation(() => new Prefetch(32, 32)),
    FirtoolOption("--disable-all-randomization"))
)*/
val verilogString = chisel3.getVerilogString(new Prefetch(32, 32))
println(verilogString)