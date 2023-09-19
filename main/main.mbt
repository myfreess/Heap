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

func test_bheap() {
  let h = @bheap.BHeap::new(1024, 0)
  let b = h.insert(4)
  let b = h.insert(6)
  let b = h.insert(5)
  let x = h.pop().unwrap()
  let y = h.pop().unwrap()
  println("\(x) \(y)")
}

func init {
  test_bheap()
}
