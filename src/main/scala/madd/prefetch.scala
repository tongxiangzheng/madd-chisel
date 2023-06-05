package madd

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

class ItemData(val pcWidth: Int,val addressWidth: Int) extends Bundle {
  val pc = UInt(pcWidth.W)
  val address = UInt(addressWidth.W)
  val timestamp = UInt(32.W)
	val stride = UInt(addressWidth.W)
  //val haveStride = Bool()
  val reliability = UInt(32.W)
}

class Prefetch(val pcWidth: Int,val addressWidth: Int) extends Module {
  val io = IO(new PrefetchIO(pcWidth,addressWidth))
  
  val dfn = RegInit(0.U(32.W))
  val lastPC_ = RegInit(0.U(pcWidth.W))
  val prefetch_valid = RegInit(false.B)
  val prefetch_address = RegInit(0.U(addressWidth.W))
  val ready = RegInit(false.B)
  val inited = RegInit(false.B)
  
  val size = 8
  val fifo = Module(new Fifo(size,pcWidth,addressWidth))
  fifo.io.findPC:=0.U
  fifo.io.enableWrite:=false.B
  fifo.io.writePC:=DontCare
  fifo.io.writeAddress:=DontCare
  fifo.io.writeStride:=DontCare
  fifo.io.writeReliability:=DontCare

  
  def calcReliability(stride:UInt,reliability:UInt,newStride:UInt):UInt={
    //实现替换策略
    //返回可信度，为0表示替换为newStride
    val same=(stride===newStride)
    val ans=Mux(same,reliability+1.U,reliability>>1)
    ans
  }
  

//start
  fifo.io.reset:=io.reset
  //unblock:=
  var enable = io.enable & !RegNext(io.enable)
  //unblock:=Mux(io.enable,false.B,true.B)
  //lastPC:=io.pc
  
  //val stride = RegInit(0.U(addressWidth.W))
  //val newStride = RegInit(0.U(addressWidth.W))
  //val reliability = RegInit(0.U(32.W))
  //val prereliability = RegInit(0.U(32.W))
  //val replace = RegInit(false.B)
  //chisel3.printf(p"0 pc: ${queueReg(0).pc} address: ${queueReg(0).address} stride: ${queueReg(0).stride} reliability: ${queueReg(0).reliability} \n");
  //chisel3.printf(p"io.enable: ${io.enable} unblock: ${unblock} \n");
  
  //chisel3.printf(p"enable: ${enable} replace: ${replace} reliability: ${reliability} stride: ${stride} newStride: ${newStride} prereliability: ${prereliability}\n");
  
  when(enable){
    enable=false.B
    fifoFind(io.pc)
    var found = fifo.io.found

    when(found){
      val newStride=io.address-fifo.io.foundAddress
      //prereliability:=queueReg(p).reliability
      val reliability=calcReliability(fifo.io.foundStride,fifo.io.foundReliability,newStride)
      val replace=(reliability===0.U)
      
      val stride=Mux(replace,newStride,fifo.io.foundStride)
      val w_reliability=Mux(replace,1.U,reliability)
      val valid=w_reliability>1.U
      prefetch_valid:=valid
      prefetch_address:=Mux(valid,io.address+stride,0.U)
      fifoWrite(io.pc,io.address,stride,w_reliability)
    }.otherwise{
      fifoWrite(io.pc,io.address,0.U,0.U)
      prefetch_address:=0.U
      prefetch_valid:=false.B
    }
    /*chisel3.printf(
      p"write: p: ${p} pc: ${io.pc} reliability: ${reliability}\n"
    )*/
  }

  ready:=io.enable
  io.ready:=RegNext(ready)
  io.prefetch_valid:=prefetch_valid
  io.prefetch_address:=prefetch_address
  
  def fifoFind(pc: UInt):Unit = {
    fifo.io.findPC:=pc
    fifo.io.enableWrite:=false.B
  }
  def fifoWrite(pc:UInt,address:UInt,stride:UInt,reliability:UInt):Unit = {
    fifo.io.writePC:=pc
    fifo.io.enableWrite:=true.B
    fifo.io.writeAddress:=address
    fifo.io.writeStride:=stride
    fifo.io.writeReliability:=reliability
  }
}
object Prefetch extends App {
  println((new ChiselStage).execute(
    Array("-X", "verilog", "-td", "source/"),
    Seq(
      ChiselGeneratorAnnotation(() => new Prefetch(32,32))
    )
  ))
  /*println(
    chisel3.stage.ChiselStage.emitSystemVerilog(
      new Prefetch(32, 32),
      Array("-disable-all-randomization", "-strip-debug-info")
    )
  )*/
}