package madd

import chisel3._
import chisel3.util._

class prefetchIO(M: Int, N: Int) extends Bundle {
  val a = Input(Vec(M * N, SInt(32.W)))
  val b = Input(Vec(M * N, SInt(32.W)))

  val out = Output(Vec(M * N, SInt(32.W)))

  override def cloneType =
    new prefetchIO(M, N).asInstanceOf[this.type]
}