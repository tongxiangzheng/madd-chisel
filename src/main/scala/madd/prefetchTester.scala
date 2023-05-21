package madd

import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._

class PrefetchTester(dut: Prefetch)
    extends PeekPokeTester(dut) {
      
  val numAccesses = 16
  val testPointNum = 3
  var trace = new Array[Array[(Int, Int)]](3)
  val tracename = Array("顺序", "完全随机", "概率顺序","pc值随机")
  for (i <- 0 until testPointNum) {
    //(pc,address)
    trace(i) = new Array[(Int, Int)](numAccesses)
    
  }
  for (i <- 0 until numAccesses) {
    trace(0)(i) = ((i*4/numAccesses+1, i * 16 % 256))
  }
  for (i <- 0 until numAccesses) {
    trace(1)(i) = ((i*4/numAccesses+1, scala.util.Random.nextInt(100)))
  }
    

  for (i<- 0 until 1){
    for (j<- 0 until numAccesses){
      
      poke(dut.io.pc, trace(i)(j)._1)
      poke(dut.io.address, trace(i)(j)._2)
      step(1)
      
      scala.Predef.printf(s"[Tester] pc: ${trace(i)(j)._1} address: ${trace(i)(j)._2} valid: ${peek(dut.io.prefetch_valid)} prefetch_address: ${peek(dut.io.prefetch_address)} \n");
      
      poke(dut.io.pc, 0)
      step(1)
    }
    
    scala.Predef.printf(s"[Tester] testName: ${tracename(i)}\n");
  }
  
}

object PrefetchTester extends App {
  chisel3.iotesters.Driver(() => new Prefetch(32, 32)) { dut =>
    new PrefetchTester(dut)
  }
}