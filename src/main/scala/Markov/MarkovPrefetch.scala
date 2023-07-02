package markov

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}


class MarkovPrefetch(val pcWidth: Int,val addressWidth: Int) extends Module {
  val io = IO(new PrefetchIO(pcWidth,addressWidth))

  val prefetch_valid = RegInit(false.B)
  val prefetch_address = RegInit(0.U(addressWidth.W))
  val ready = RegInit(false.B)

  val lastAddress = RegInit(0.U(addressWidth.W))
  
  val size = 8
  val fifo = Module(new Fifo(size,addressWidth))

  fifo.io.findAddress:=0.U
  fifo.io.enableWrite:=false.B
  fifo.io.nextAddress:=DontCare

  

//start
  fifo.io.reset:=io.reset
  var enable = io.enable & !RegNext(io.enable)
  //unblock:=Mux(io.enable,false.B,true.B)
  
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
    fifoFind(io.address)
    var found = fifo.io.found

    prefetch_valid:=found
    prefetch_address:=Mux(found,fifo.io.nextAddress,0.U)
    fifoWrite(lastAddress,io.address,found)
    
    lastAddress:=io.address
    /*chisel3.printf(
      p"write: p: ${p} pc: ${io.pc} reliability: ${reliability}\n"
    )*/
  }

  ready:=io.enable
  io.ready:=RegNext(ready)
  io.prefetch_valid:=prefetch_valid
  io.prefetch_address:=prefetch_address
  
  def fifoFind(address: UInt):Unit = {
    fifo.io.findAddress:=address
  }
  def fifoWrite(address:UInt,nextAddress:UInt,enable:UInt):Unit = {
    fifo.io.writeAddress:=address
    fifo.io.nextAddress:=nextAddress
    fifo.io.enableWrite:=enable
  }
}
object MarkovPrefetch extends App {
  println((new ChiselStage).execute(
    Array("-X", "verilog", "-td", "source/"),
    Seq(
      ChiselGeneratorAnnotation(() => new MarkovPrefetch(32,32))
    )
  ))
  /*println(
    chisel3.stage.ChiselStage.emitSystemVerilog(
      new Prefetch(32, 32),
      Array("-disable-all-randomization", "-strip-debug-info")
    )
  )*/
}