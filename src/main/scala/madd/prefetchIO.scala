package madd

import chisel3._
import chisel3.util._

class PrefetchIO(val pcWidth: UInt,val addressWidth: UInt) extends Bundle {
    // 输入端口
    val pc = Input(UInt(pcWidth.W))
    val address = Input(UInt(addressWidth.W))
    // 输出端口
    val prefetch_address = Output(UInt(addressWidth.W))
    val prefetch_valid = Output(Bool())

  override def cloneType =
    new PrefetchIO(addressWidth, pcWidth).asInstanceOf[this.type]
}