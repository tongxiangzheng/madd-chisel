package madd

import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._

class MatrixAddition1Tester(dut: MatrixAddition1)
    extends PeekPokeTester(dut) {
  for (i <- 0 until 3 * 2) {
    poke(dut.io.a(i), i)
    poke(dut.io.b(i), i)
  }

  for (i <- 0 until 3 * 2) {
    scala.Predef.printf(s"[Tester] ${i} out: ${peek(dut.io.out(i))} \n"); 
  }
  step(1)
  for (i <- 0 until 3 * 2) {
    scala.Predef.printf(s"[Tester] ${i} out: ${peek(dut.io.out(i))} \n"); 
  }
}

object MatrixAddition1Tester extends App {
  chisel3.iotesters.Driver(() => new MatrixAddition1(3, 2)) { dut =>
    new MatrixAddition1Tester(dut)
  }
}