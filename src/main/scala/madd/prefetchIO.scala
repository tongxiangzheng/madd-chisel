package madd

import chisel3._
import chisel3.util._

class PrefetchIO(val pcWidth: UInt,val addressWidth: UInt) extends Bundle {
    // 输入端口
    val pc = Input(UInt(pcWidth))
    val address = Input(UInt(addressWidth))
    // 输出端口
    val prefetch_address = Output(UInt(addressWidth))
    val prefetch_valid = Output(Bool())

  override def cloneType =
    new PrefetchIO(addressWidth, pcWidth).asInstanceOf[this.type]
}