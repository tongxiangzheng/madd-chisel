package madd

import chisel3._
import chisel3.util._

import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.stage.ChiselStage

/*
*/
object PrefetchVerilog extends App {
  scala.Predef.println((new ChiselStage).emitVerilog(new Prefetch(32, 32)))
}