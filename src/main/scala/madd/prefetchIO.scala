package madd

import chisel3._
import chisel3.util._

class PrefetchIO(val pcWidth: Int,val addressWidth: Int) extends Bundle {
    // 输入端口
    val pc = Input(UInt(pcWidth.W))
    val address = Input(UInt(addressWidth.W))
    var reset = Input(Bool())
    // 输出端口
    val prefetch_address = Output(UInt(addressWidth.W))
    val prefetch_valid = Output(Bool())
    val ready = Output(Bool())
    val inited = Output(Bool())
  override def cloneType =
    new PrefetchIO(addressWidth, pcWidth).asInstanceOf[this.type]
}