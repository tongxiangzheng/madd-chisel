package madd

import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._

class PrefetchTester(dut: Prefetch)
    extends PeekPokeTester(dut) {
  poke(dut.io.pc, 3)
  poke(dut.io.address, 123.U)
  step(1)
  expect(dut.io.prefetch_valid, false.B)
  //expect(dut.io.prefetch_address, 100.U)

  poke(dut.io.pc, 3)
  poke(dut.io.address, 206.U)
  step(1)
  expect(dut.io.prefetch_valid, true.B)
  expect(dut.io.prefetch_address, 100.U)
  
}

object PrefetchTester extends App {
  chisel3.iotesters.Driver(() => new Prefetch(32, 32)) { dut =>
    new PrefetchTester(dut)
  }
}