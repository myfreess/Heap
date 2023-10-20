pub struct BHeap[T] {
  mut data:Array[T]
  mut count:Int
  min_value:T
}

pub func capacity[T](self:BHeap[T]) -> Int {
  // moonbit的array不可动态调整长度
  self.data.length()
}

pub func residualVolume[T](self:BHeap[T]) -> Int {
  self.capacity() - self.count
}

func parent(i:Int) -> Int {
  // i as array index
  // parent(0) == 0
  // parent(1) == 0
  // parent(2) == 0
  ((i + 1) / 2) - 1
}

func left(i:Int) -> Int {
  2 * i + 1
}

func right(i:Int) -> Int {
  2 * i + 2
}

func exchange[T](self:Array[T], x:Int, y:Int) {
  let tmp = self[x]
  self[x] = self[y]
  self[y] = tmp
}

func heapify[T:Compare](self:BHeap[T], index:Int) {
  // 大根堆
  let n = self.count
  var i = index
  var s = i
  while true {
    let l = left(i)
    let r = right(i)
    if l < n && self.data[l] > self.data[s] {
      s = l
    }
    if r < n && self.data[r] > self.data[s] {
      s = r
    }
    if s != i {
      self.data.exchange(s,i)
      i = s
    } else {
      break
    }
  }
}

func build_heap[T:Compare](self:BHeap[T]){
  if(self.count == 0){
    return
  }
  let n = self.count / 2 - 1
  var i = n
  while i > -1 {
    self.heapify(i)
    i = i - 1
  }
}

pub func BHeap::new[T:Compare](capacity:Int, minValue:T) -> BHeap[T] {
  { data: Array::make(capacity, minValue), count: 0, min_value: minValue}
}

pub func BHeap::from_array[T:Compare](arr:Array[T], minValue:T) -> BHeap[T] {
  let h = { data: arr, count: arr.length(), min_value: minValue}
  h.build_heap()
  return h
}

pub func max[T:Compare](self:BHeap[T]) -> Option[T] {
  if(self.count > 0) {
    Some(self.data[0])
  } else {
    None
  }
}

pub func pop[T:Compare](self:BHeap[T]) -> Option[T] {
  if(self.count == 0){
    return None
  }
  let x = self.data[0]
  let n = self.count - 1
  self.data.exchange(0, n)
  self.count = self.count - 1
  if(self.count > 0){
    self.heapify(0)
  }
  return Some(x)
}

func heap_fix[T:Compare](self:BHeap[T], i:Int) {
  var i = i
  while i > 0 && self.data[i] > self.data[parent(i)] {
    self.data.exchange(i, parent(i))
    i = parent(i)
  }
}

func copy_from[T](self:Array[T], src:Array[T]) {
  // assert self.length() >= src.length()
  // src不应该是self的alias
  var i = 0
  while i < src.length() {
    self[i] = src[i]
    i = i + 1
  }
}

pub func insert[T:Compare](self:BHeap[T], x:T) {
  if(self.residualVolume() > 0){
    self.data[self.count] = x
    self.count = self.count + 1
    self.heap_fix(self.count - 1)
  } else {
    let n = self.capacity() * 2
    if (n == 0){
      self.data = Array::make(20, self.min_value)
      self.insert(x)
    } else {
      let arr = Array::make(n, self.min_value)
      arr.copy_from(self.data)
      self.data = arr
      self.insert(x)
    }
  }
}

