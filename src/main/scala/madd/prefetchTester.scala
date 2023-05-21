package madd

import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._
import scala.collection.mutable.Set

class PrefetchTester(dut: Prefetch)
    extends PeekPokeTester(dut) {
      
  val numAccesses = 32
  val testPointNum = 3
  var trace = new Array[Array[(Int, Int)]](3)
  val tracename = Array("pc小 address顺序", "pc大范围交错 address顺序", "address完全随机","pc随机")
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

  for (i<- 0 until 4){
    for (j<- 0 until numAccesses){
      val cache = new Set[int]()
      val pre_cache = new Set[int]()
      val Hits=0
      val preOperator=0
      val access=0
      poke(dut.io.pc, trace(i)(j)._1)
      poke(dut.io.address, trace(i)(j)._2)
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


      if(peek(dut.io.prefetch_valid)){
        val pre_address=peek(dut.io.prefetch_address)
        if(!pre_cache.contains(address)&&!pre_cache.contains(address)){
          preOperator+=1
          pre_cache+=pre_address
        }
      }

      poke(dut.io.pc, 0)
      while(peek(dut.io.ready)==1){
        step(1)
      }
    }
    
    scala.Predef.printf(s"[Tester] 测试集名称: ${tracename(i)} 缓存命中率: ${Hits.toDouble/numAccesses} 预取行动率: ${preOperator.toDouble/numAccesses} 预取有效率 ${access.toDouble/Hits.preOperator} 总收益率 ${access.toDouble/numAccesses}\n");
  }
  def find(cache:ListBuffer[int]):Bool{
    for()
  }
}

object PrefetchTester extends App {
  chisel3.iotesters.Driver(() => new Prefetch(32, 32)) { dut =>
    new PrefetchTester(dut)
  }
}