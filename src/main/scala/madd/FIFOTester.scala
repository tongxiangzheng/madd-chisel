package madd

import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._

class FIFOTester(dut: FIFO)
    extends PeekPokeTester(dut) {

  poke(dut.io.enIn,true.B)
  step(1)
  expect(dut.io.find, true.B)

  poke(dut.io.enIn,false.B)
  step(1)
  expect(dut.io.find, false.B)
  
  
}

object FIFOTester extends App {
  chisel3.iotesters.Driver(() => new FIFO(32, 32)) { dut =>
    new FIFOTester(dut)
  }
}