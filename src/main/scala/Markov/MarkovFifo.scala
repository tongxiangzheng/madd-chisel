package markov

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}


class MarkovItemData(val addressWidth: Int) extends Bundle {
  val address = UInt(addressWidth.W)
  val nextAddress = UInt(addressWidth.W)
	val transitions = UInt(32.W)
  val timestamp = UInt(32.W)
  val used = Bool()
}
class MarkovFifo(val size: Int,val addressWidth: Int) extends Module {
	val io = IO(new MarkovFifoIO(addressWidth))
  
  val dfn = RegInit(0.U(32.W))
  val ready = RegInit(false.B)
  //val unblock = RegInit(false.B)
  //val enable = RegInit(false.B)
  //val stride = RegInit(0.U(addressWidth.W))
  //val reliability = RegInit(0.U(32.W))
  
  val queueWire = Wire(Vec(size,new MarkovItemData(addressWidth)))
  for (i <- 0 until size) {
	  queueWire(i).address:=0.U(addressWidth.W)
	  queueWire(i).nextAddress:=0.U(addressWidth.W)
	  queueWire(i).transitions:=0.U(32.W)
    queueWire(i).timestamp:=0.U(32.W)
    queueWire(i).used:=false.B
    
  }
  val queueReg = RegInit(queueWire)

//start
  init(io.reset)
  fifoFind(io.findAddress)
  fifoWrite(io.writeAddress,io.nextAddress,io.enableWrite)



  def init(enable:Bool):Unit={
    for (i <- 0 until size) {
	    queueReg(i).address:=Mux(enable,0.U(addressWidth.W),queueReg(i).address)
	    queueReg(i).nextAddress:=Mux(enable,0.U(addressWidth.W),queueReg(i).nextAddress)
	    queueReg(i).transitions:=Mux(enable,0.U(32.W),queueReg(i).transitions)
      queueReg(i).timestamp:=Mux(enable,0.U(32.W),queueReg(i).timestamp)
      queueReg(i).used:=Mux(enable,false.B,queueReg(i).used)
    }
    dfn:=Mux(enable,0.U,dfn)
  }
  def fifoFind(address: UInt):Unit = {
    var p=size.U
    var found=false.B
    for(i <- 0 until size){
      val check=(queueReg(i).used & queueReg(i).address===address)
      val select=Mux(found,queueReg(i).transitions>queueReg(p).transitions,check)
      p=Mux(select,i.U,p)
      found=Mux(select,true.B,found)
      /*chisel3.printf(
        p"find: ${i} queueReg(i).pc: ${queueReg(i).pc} check: ${check} p: ${p}\n"
      )*/
    }
    /*chisel3.printf(
      p"find: found: ${found} p: ${p} address: ${address},${queueReg(p).address} nextAddress: ${queueReg(p).nextAddress} transitions: ${queueReg(p).transitions}\n"
    )*/
    io.found:=found
    io.foundNextAddress:=Mux(found,queueReg(p).nextAddress,0.U)
    io.foundTransitions:=Mux(found,queueReg(p).transitions,0.U)
  }
  def fifoWrite(address:UInt,nextAddress:UInt,enable:Bool):Unit = {
    var p=0.U
    var found=false.B
    var inc=false.B //true表示是对已有的块自增，false表示替换了其他块

    //是否有该项
    for(i <- 0 until size){
      val check=(queueReg(i).address===address)&&(queueReg(i).nextAddress===nextAddress)
      /*chisel3.printf(
        p"check1: p: ${p} queueReg(i).pc: ${queueReg(i).pc}\n"
      )*/
      val select=Mux(found,false.B,check)
      found=Mux(select,true.B,found)
      p=Mux(select,i.U,p)
      inc=Mux(select,true.B,inc)
    }

    //是否有空位
    for(i <- 0 until size){
      val check=(queueReg(i).used===false.B)
      /*chisel3.printf(
        p"check2: p: ${p} queueReg(i).pc: ${queueReg(i).pc}\n"
      )*/
      val select=Mux(found,false.B,check)
      found=Mux(select,true.B,found)
      p=Mux(select,i.U,p)
    }
    //替换最老的
    for(i <- 0 until size){
      val check=(dfn-queueReg(i).timestamp>dfn-queueReg(p).timestamp)
      /*chisel3.printf(
        p"check3: p: ${p} dfn: ${dfn} timestamp: ${queueReg(i).timestamp} cmp_timestamp:${queueReg(p).timestamp}\n"
      )*/
      val select=Mux(found,false.B,check)
      p=Mux(select,i.U,p)
    }
    /*chisel3.printf(
      p"write: found: ${found} p: ${p} enable: ${enable} inc: ${inc} queueReg(p).address ${queueReg(p).address} queueReg(p).nextAddress ${queueReg(p).nextAddress} queueReg(p).transitions: ${queueReg(p).transitions}\n"
    )*/
    
	  queueReg(p).address:=Mux(enable,address,queueReg(p).address)
	  queueReg(p).nextAddress:=Mux(enable,nextAddress,queueReg(p).nextAddress)
	  queueReg(p).transitions:=Mux(enable,Mux(inc,queueReg(p).transitions+1.U,1.U), queueReg(p).transitions)
    val nextDfn=dfn+1.U
    dfn:=Mux(enable,nextDfn,dfn)
    queueReg(p).timestamp:=Mux(enable,nextDfn,queueReg(p).timestamp)
    queueReg(p).used:=Mux(enable,true.B,queueReg(p).used)

  }
}