func unwrap[T](self:Option[T]) -> T {
  match self {
    None => abort("found None")
    Some(v) => v
  }
}

func test_pheap() {
  let h = @pheap.PHeap::Empty.insert(4).insert(0).insert(1)
  let x = h.pop().unwrap().min().unwrap()
  println("\(x)")
}

func test_bheap(){
  let h2 = @bheap.BHeap::from_array([3, 5, 9], 0)
  h2.insert(5)
  h2.insert(6)
  h2.insert(7)
  let x = h2.pop().unwrap()
  println("\(x)")
}

func init {
  test_bheap()
}
