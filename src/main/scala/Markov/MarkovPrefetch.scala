package markov

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}


class MarkovPrefetch(val pcWidth: Int,val addressWidth: Int) extends Module {
  val io = IO(new PrefetchIO(pcWidth,addressWidth))

  val prefetch_valid = RegInit(false.B)
  val prefetch_address = RegInit(0.U(addressWidth.W))
  val ready = RegInit(false.B)
  val inited = RegInit(false.B)

  val lastAddress = RegInit(0.U(addressWidth.W))
  
  val size = 128
  val fifo = Module(new MarkovFifo(size,addressWidth))

  //fifo.io.findAddress:=0.U
  fifo.io.writeAddress:=0.U
  fifo.io.enableWrite:=false.B
  fifo.io.nextAddress:=DontCare

  

//start
  fifo.io.reset:=io.reset
  inited:=Mux(io.reset,true.B,inited)
  var enable = io.enable & !RegNext(io.enable)
  
  fifoFind(io.address)
  var found = fifo.io.found

  prefetch_valid:=Mux(enable,found,prefetch_valid)
  prefetch_address:=Mux(enable,Mux(found,fifo.io.foundNextAddress,0.U),prefetch_address);
  fifoWrite(lastAddress,io.address,Mux(enable,!inited,false.B))
  inited:=Mux(enable,false.B,inited)
  lastAddress:=Mux(enable,io.address,lastAddress)


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