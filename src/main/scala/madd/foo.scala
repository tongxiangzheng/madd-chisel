import chisel3._
import chisel3.stage.ChiselStage

class Foo extends Module {
  val io = IO(new Bundle {
    val in = Input(Bool())
    val out = Output(Bool())
  })

  io.out := ~io.in
}

println((new ChiselStage).emitVerilog(new Foo))