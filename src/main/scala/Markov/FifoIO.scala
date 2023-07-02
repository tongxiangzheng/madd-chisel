package markov

import chisel3._
import chisel3.util._

class FifoIO(val addressWidth: Int) extends Bundle {
    val reset = Input(Bool())

    val findAddress = Input(UInt(addressWidth.W))
    
    val writeAddress = Input(UInt(addressWidth.W))
    val nextAddress = Input(UInt(addressWidth.W))
    //val writeAddress = Input(UInt(addressWidth.W))
    //val writeNextAddress = Input(UInt(addressWidth.W))
    //val writeTransitions = Input(UInt(addressWidth.W))
    val enableWrite = Input(Bool())


    val found = Output(Bool())
    val foundNextAddress = Output(UInt(addressWidth.W))
    val foundTransitions = Output(UInt(addressWidth.W))

  override def cloneType =
    new FifoIO(addressWidth).asInstanceOf[this.type]
}