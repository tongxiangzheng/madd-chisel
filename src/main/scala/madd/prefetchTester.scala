package madd

import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._
import scala.collection.mutable.Set

import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.stage.ChiselStage

class PrefetchTester(dut: Prefetch)
    extends PeekPokeTester(dut) {
      
  val numAccesses = 32
  val testPointNum = 5
  var trace = new Array[Array[(Int, Int)]](testPointNum)
  val tracename = Array("pc小 address顺序", "pc大范围交错 address顺序", "address完全随机","pc随机","address 步长变化")
  for (i <- 0 until testPointNum) {
    //(pc,address)
    trace(i) = new Array[(Int, Int)](numAccesses)
    
  }
  for (i <- 0 until numAccesses) {
    trace(0)(i) = ((i*4/numAccesses+1, i * 8 % 1024))
  }
  for (i <- 0 until numAccesses) {
    trace(1)(i) = ((i%16+1, i * 8 % 1024))
  }
  for (i <- 0 until numAccesses) {
    trace(2)(i) = ((i*4/numAccesses+1, scala.util.Random.nextInt(100)))
  }
  for (i <- 0 until numAccesses) {
    trace(3)(i) = ((scala.util.Random.nextInt(100), i * 8 % 1024))
  }
  for (i <- 0 until numAccesses) {
    trace(4)(i) = ((1, i * (i/8+1) % 1024))
  }

  for (i<- 0 until testPointNum){
    val cache:Set[Int] = Set()
    val pre_cache:Set[Int] = Set()
    var Hits=0
    var preOperator=0
    var access=0
    poke(dut.io.pc,0)
    poke(dut.io.reset, 1)
    while(peek(dut.io.inited)==0){
      step(1)
    }
    
    
    for (j<- 0 until numAccesses){
      poke(dut.io.pc, trace(i)(j)._1)
      poke(dut.io.address, trace(i)(j)._2)
      poke(dut.io.enable,1)
      while(peek(dut.io.ready)==0){
        step(1)
      }
      scala.Predef.printf(s"[Tester] pc: ${trace(i)(j)._1} address: ${trace(i)(j)._2} valid: ${peek(dut.io.prefetch_valid)} prefetch_address: ${peek(dut.io.prefetch_address)} \n");
      
      val address=trace(i)(j)._2
      if(pre_cache.contains(address)){
        cache+=address
        pre_cache-=address
        access+=1
      }
      if(cache.contains(address)){
        Hits+=1
      }


      if(peek(dut.io.prefetch_valid)==1){
        val pre_address=peek(dut.io.prefetch_address).toInt
        if((!pre_cache.contains(pre_address)) && (!pre_cache.contains(pre_address))){
          preOperator+=1
          pre_cache+=pre_address
        }
      }
      if((!pre_cache.contains(address)) && (!pre_cache.contains(address))){
        cache+=address
      }
      
      poke(dut.io.enable,0)
      poke(dut.io.pc, 0)
      while(peek(dut.io.ready)==1){
        step(1)
      }
    }
    
    scala.Predef.printf(s"[Tester] 测试集名称: ${tracename(i)}\n")
    scala.Predef.printf(s"缓存命中率: ${Hits.toDouble/numAccesses} 预取行动率: ${preOperator.toDouble/numAccesses} 预取有效率 ${access.toDouble/preOperator} 预取产生的总收益率 ${access.toDouble/numAccesses}\n");
    scala.Predef.printf("-----------------\n");

    poke(dut.io.reset, 0)
    while(peek(dut.io.inited)==1){
      step(1)
    }
  }
}

object PrefetchTester extends App {
  
  chisel3.iotesters.Driver(() => new Prefetch(32, 32)) { dut =>
    new PrefetchTester(dut)
  }
  scala.Predef.printf((new chisel3.stage.ChiselStage).emitVerilog(new Prefetch(32, 32)))
}