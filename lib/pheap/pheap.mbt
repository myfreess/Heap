pub enum PHeap[T] {
  Empty
  Node(T, List[PHeap[T]])
}

func merge[T:Compare](h1:PHeap[T], h2:PHeap[T]) -> PHeap[T] {
  match (h1, h2) {
    (Empty, h2) => h2
    (h1, Empty) => h1
    (Node(x, ts1), Node(y, ts2)) =>
      if(x < y){
        Node(x, Cons(Node(y, ts2), ts1))
      } else {
        Node(y, Cons(Node(x, ts1), ts2))
      }
  }
}

pub func insert[T:Compare](self:PHeap[T], x:T) -> PHeap[T] {
  merge(self, Node(x, Nil))
}

func consolidate[T:Compare](ts:List[PHeap[T]]) -> PHeap[T] {
  match ts {
    Nil                    => Empty
    Cons(t, Nil)           => t
    Cons(t1, Cons(t2, ts)) => merge(merge(t1, t2), consolidate(ts))
  }
}

pub func pop[T:Compare](self:PHeap[T]) -> PHeap[T] {
  match self {
    Empty       => abort("cant remove element from Empty PHeap")
    Node(_, ts) => consolidate(ts)
  }
}