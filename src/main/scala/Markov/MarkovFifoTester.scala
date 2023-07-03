package markov

import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._
import scala.collection.mutable.Set

import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.stage.ChiselStage

class FifoTester(dut: MarkovFifo)
    extends PeekPokeTester(dut) {
      
  poke(dut.io.writeAddress,0)
  poke(dut.io.reset,1)
  poke(dut.io.enableWrite,0)
  step(1)
  poke(dut.io.reset,0)



  scala.Predef.printf(s"insert (4,7)\n")
  
  poke(dut.io.writeAddress,4)
  poke(dut.io.nextAddress,7)
  poke(dut.io.enableWrite,1)
  step(1)
  poke(dut.io.enableWrite,0)
  

  scala.Predef.printf(s"find 4\n")
  poke(dut.io.findAddress,4)
  step(1)//scala.Predef.printf(s"[Tester] found: ${peek(dut.io.found)} foundNextAddress: ${peek(dut.io.foundNextAddress)} foundTransitions: ${peek(dut.io.foundTransitions)}\n");
  expect(dut.io.found,1)
  expect(dut.io.foundNextAddress,7)
  expect(dut.io.foundTransitions,1)


  scala.Predef.printf(s"find 3\n")
  
  poke(dut.io.findAddress,3)
  step(1)
  expect(dut.io.found,0)
  


  
  scala.Predef.printf(s"insert (4,7)\n")
  poke(dut.io.writeAddress,4)
  poke(dut.io.nextAddress,7)
  poke(dut.io.enableWrite,1)
  step(1)
  poke(dut.io.enableWrite,0)
  
  
  scala.Predef.printf(s"find 4\n")
  poke(dut.io.findAddress,4)
  step(1)
  expect(dut.io.found,1)
  expect(dut.io.foundNextAddress,7)
  expect(dut.io.foundTransitions,2)

  
}

object FifoTester extends App {
  
  chisel3.iotesters.Driver(() => new MarkovFifo(8,32)) { dut =>
    new FifoTester(dut)
  }
}