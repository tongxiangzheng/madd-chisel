class GenTree(val prefetch:Prefetch,val pWidth:UInt,val p:Int,val size:Int,selector:UInt=>UInt=>UInt,checker:UInt=>Bool) extends Module{
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
}
class Fifo(val size){
	
  
  val dfn = RegInit(0.U(32.W))
  val ready = RegInit(false.B)
  val inited = RegInit(false.B)
  //val unblock = RegInit(false.B)
  //val enable = RegInit(false.B)
  //val stride = RegInit(0.U(addressWidth.W))
  //val reliability = RegInit(0.U(32.W))
  
  val queueWire = Wire(Vec(size,new ItemData(pcWidth,addressWidth)))
}