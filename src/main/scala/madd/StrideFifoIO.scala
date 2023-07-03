package madd

import chisel3._
import chisel3.util._

class StrideFifoIO(val pcWidth: Int,val addressWidth: Int) extends Bundle {
    val reset = Input(Bool())

    val findPC = Input(UInt(pcWidth.W))
    val writePC = Input(UInt(pcWidth.W))

    val writeAddress = Input(UInt(addressWidth.W))
    val writeStride = Input(UInt(addressWidth.W))
    val writeReliability = Input(UInt(addressWidth.W))
    val enableWrite = Input(Bool())

    val found = Output(Bool())
    val foundAddress = Output(UInt(addressWidth.W))
    val foundStride = Output(UInt(addressWidth.W))
    val foundReliability = Output(UInt(addressWidth.W))

  override def cloneType =
    new StrideFifoIO(addressWidth, pcWidth).asInstanceOf[this.type]
}