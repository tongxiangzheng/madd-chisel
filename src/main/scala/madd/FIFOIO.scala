package madd

import chisel3._
import chisel3.util._

class FIFOIO(val pcWidth: UInt, val addressWidth: UInt) extends Bundle {
    // 输入端口
    val enIn = Input(Bool())
    val pcIn = Input(UInt(pcWidth))
	val enWrite = Input(Bool())
	val addressIn = Input(UInt(addressWidth))
    val strideIn = Output(SInt(addressWidth+1.U))
	
    // 输出端口
    val addressOut = Output(UInt(addressWidth))
    val strideOut = Output(SInt(addressWidth+1.U))
	val find = Output(Bool())

  override def cloneType =
    new FIFOIO(pcWidth, addressWidth).asInstanceOf[this.type]
}