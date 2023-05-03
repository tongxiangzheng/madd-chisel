package cache

import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._
import scala.collection.mutable.ListBuffer

class Cache1Tester(dut: Cache1) extends PeekPokeTester(dut) {
    // TODO: (writeEnable, address, data) -> (threadId, pc, writeEnable, address, writeData)
    var trace = new ListBuffer[(Boolean, Int, Int)]()

    val numAccesses = 1024

    for (i <- 0 until numAccesses) {
      trace += ((i % 2 == 0, i * 16 % 256, (i + 1))) // TODO: generate your data here as you like
    }
    
    // initialize the valid and ready bits to false
    poke(dut.io.request.valid, false)
    poke(dut.io.response.ready, false)

    // process the lines in the trace
    for (i <- 0 until numAccesses) {
      // wait until the request is ready
      while (peek(dut.io.request.ready) == BigInt(0)) {
        step(1)
      }

      // feed the request
      poke(dut.io.request.valid, true)
      poke(dut.io.request.bits.address, trace(i)._2)
      poke(dut.io.request.bits.writeEnable, trace(i)._1)

      // feed the write data if write is enabled
      if (trace(i)._1) {
        poke(dut.io.request.bits.writeData, trace(i)._3)
      }

      step(1)

      // mark the request as valid and response as ready
      poke(dut.io.request.valid, false)
      poke(dut.io.response.ready, true)

      // wait until the response is valid
      while (peek(dut.io.response.valid) == BigInt(0)) {
        step(1)
      }
      
      // TODO: you can print or expect (validate) the response here

      step(1)

      // mark the response as not ready again
      poke(dut.io.response.ready, false)
    }

    val numHits = peek(dut.io.numHits)
    val numCycles = peek(dut.io.numCycles)

    scala.Predef.printf(s"[Tester] numAccesses: ${numAccesses}, numHits: ${numHits}, hitRatio: ${numHits.toDouble / numAccesses}, numCycles: ${numCycles}\n");
}

object Cache1Tester extends App {
  chisel3.iotesters.Driver(() => new Cache1(), "treadle") { dut =>
    new Cache1Tester(dut)
  }
}