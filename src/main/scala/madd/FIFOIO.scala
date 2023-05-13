package madd

import chisel3._
import chisel3.util._

class FIFOIO(val pcWidth: Int, val addressWidth: Int) extends Bundle {
    // 输入端口
    val enIn = Input(Bool())
    val pcIn = Input(UInt(pcWidth.W))
	val enWrite = Input(Bool())
	val addressIn = Input(UInt(addressWidth.W))
    val strideIn = Input(SInt(addressWidth.W+1))
	
    // 输出端口
    val addressOut = Output(UInt(addressWidth.W))
    val strideOut = Output(SInt(addressWidth.W+1))
	val find = Output(Bool())
	
  override def cloneType =
    new FIFOIO(pcWidth, addressWidth).asInstanceOf[this.type]
}