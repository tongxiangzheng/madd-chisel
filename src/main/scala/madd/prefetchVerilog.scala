package madd

import chisel3._
import chisel3.util._
import chisel3.tester._
import chisel3.tester.RawTester.test

import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.stage.ChiselStage

/*
*/
object PrefetchVerilog extends App {
  /*(new ChiselStage).execute(
  Array("--target", "systemverilog"),
  Seq(ChiselGeneratorAnnotation(() => new Prefetch(32, 32)),
    FirtoolOption("--disable-all-randomization")))*/

  /*val verilogString = chisel3.getVerilogString(new Prefetch(32, 32))
  println(verilogString)*/

  println(getVerilog(new Prefetch(32, 32)))
}