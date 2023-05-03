package madd

import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._

class PrefetchTester(dut: prefetch)
    extends PeekPokeTester(dut) {
  for (i <- 0 until 3 * 2) {
    poke(dut.io.a(i), i)
    poke(dut.io.b(i), i)
  }
  step(1)
  for (i <- 0 until 3 * 2) {
    print(peek(dut.io.out(i)).toString+' ')
    expect(dut.io.out(i), i * 2)
  }
}

object PrefetchTester extends App {
  chisel3.iotesters.Driver(() => new prefetch(3, 2)) { dut =>
    new prefetchTester(dut)
  }
}