package madd

import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._
import scala.collection.mutable.Set

import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.stage.ChiselStage

class StrideFifoTester(dut: StrideFifo)
    extends PeekPokeTester(dut) {
      
  poke(dut.io.reset,1)
  poke(dut.io.enableWrite,0)
  step(1)
  poke(dut.io.reset,false)

  poke(dut.io.findPC,3)
  step(1)
  expect(dut.io.found,0)

  poke(dut.io.writePC,3)
  poke(dut.io.writeAddress,4)
  poke(dut.io.writeStride,5)
  poke(dut.io.writeReliability,6)
  poke(dut.io.enableWrite,1)
  step(1)
  poke(dut.io.enableWrite,0)
  
  poke(dut.io.findPC,3)
  step(1)
  expect(dut.io.found,1)
  poke(dut.io.foundAddress,4)
  poke(dut.io.foundStride,5)
  poke(dut.io.foundReliability,6)
}

object StrideFifoTester extends App {
  
  chisel3.iotesters.Driver(() => new StrideFifo(8,32, 32)) { dut =>
    new StrideFifoTester(dut)
  }
}