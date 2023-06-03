package madd

import chisel3._
import chisel3.util._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}


/*class GenTree(val prefetch:Prefetch,val pWidth:UInt,val p:Int,val size:Int,selector:UInt=>UInt=>UInt,checker:UInt=>Bool) extends Module{
  val io = IO(new Bundle{
    val p = Output(UInt(pWidth.W))
    val found = Output(Bool)
  })
  if(size===1){
    val check=checker(p)
    io.found:=check(p)
    io.p:=p;
  }else{
    int halfSize=size/2
    val l=new GenTree(prefetch,pWidth,p,halfSize,selector,checker)
    val r=new GenTree(prefetch,pWidth,p+halfSize,halfSize,selector,checker)
    
    when(l.io.found&r.io.found){
      io.p=selector(l.p,r.p)
    }.otherwise{
      io.p=Mux(l.io.found,l.p,r.p)
    }
  }
}*/
class Fifo(val size: Int,val pcWidth: Int,val addressWidth: Int) extends Module {
	val io = IO(new FifoIO(pcWidth,addressWidth))
  
  val dfn = RegInit(0.U(32.W))
  val ready = RegInit(false.B)
  //val unblock = RegInit(false.B)
  //val enable = RegInit(false.B)
  //val stride = RegInit(0.U(addressWidth.W))
  //val reliability = RegInit(0.U(32.W))
  
  val queueWire = Wire(Vec(size,new ItemData(pcWidth,addressWidth)))
  for (i <- 0 until size) {
	  queueWire(i).pc:=0.U(pcWidth.W)
	  queueWire(i).address:=0.U(addressWidth.W)
	  queueWire(i).stride:=0.U(addressWidth.W)
    queueWire(i).reliability:=0.U(addressWidth.W)
    queueWire(i).timestamp:=0.U(32.W)
    //queueWire(i).haveStride:=false.B
    
  }
  val queueReg = RegInit(queueWire)

//start
  init(io.reset)
  fifoFind(io.pc)
  fifoWrite(io.pc,io.writeAddress,io.writeStride,io.writeReliability,io.enableWrite)



  def init(enable:Bool):Unit={
    for (i <- 0 until size) {
	    queueReg(i).pc:=Mux(enable,0.U,queueReg(i).pc)
	    queueReg(i).address:=Mux(enable,0.U,queueReg(i).pc)
	    queueReg(i).stride:=Mux(enable,0.U,queueReg(i).stride)
      queueReg(i).reliability:=Mux(enable,0.U,queueReg(i).reliability)
      queueReg(i).timestamp:=Mux(enable,0.U,queueReg(i).timestamp)
      //queueReg(i).haveStride:=false.B
    }
    dfn:=Mux(enable,0.U,dfn)
  }
  def fifoFind(pc: UInt):Unit = {
    var p=size.U
    //var found=false.B
    for(i <- 0 until size){
      val check=(queueReg(i).pc===pc)
      p=Mux(check,i.U,p)
      /*chisel3.printf(
        p"find: ${i} queueReg(i).pc ${queueReg(i).pc} check: ${check} p: ${p}\n"
      )*/
    }
    val found = p =/= size.U
    io.found:=found
    io.foundAddress:=Mux(found,queueReg(p).address,0.U)
    io.foundStride:=Mux(found,queueReg(p).stride,0.U)
    io.foundReliability:=Mux(found,queueReg(p).reliability,0.U)
  }
  def fifoWrite(pc:UInt,address:UInt,stride:UInt,reliability:UInt,enable:Bool):Unit = {
    var p=0.U
    var found=false.B
    //是否有该项
    for(i <- 0 until size){
      val check=(queueReg(i).pc===pc)
      /*chisel3.printf(
        p"check1: p: ${p} queueReg(i).pc: ${queueReg(i).pc}\n"
      )*/
      val select=Mux(found,false.B,check)
      found=Mux(select,true.B,found)
      p=Mux(select,i.U,p)
    }

    //是否有空位
    for(i <- 0 until size){
      val check=(queueReg(i).pc===0.U)
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
      p"write: found: ${found} p: ${p}\n"
    )*/
    queueReg(p).pc:=Mux(enable,queueReg(p).pc,pc)
    queueReg(p).address:=Mux(enable,queueReg(p).address,address)
    queueReg(p).stride:=Mux(enable,queueReg(p).stride,stride)
    //queueReg(p).haveStride:=haveStride
    queueReg(p).reliability:=Mux(enable,queueReg(p).reliability,reliability)
    dfn:=Mux(enable,dfn+1.U,dfn)
    queueReg(p).timestamp:=Mux(enable,queueReg(p).timestamp,dfn)
  }
}