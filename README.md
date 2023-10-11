#### 配对堆和数组实现的二叉堆

配对堆是小根堆，二叉堆是大根堆

#### 配对堆

```
enum PHeap[T] {
  Empty
  Node(T, List[PHeap[T]])
}

fn insert[T:Compare](self:PHeap[T], x:T) -> PHeap[T]

fn pop[T:Compare](self:PHeap[T]) -> Option[PHeap[T]]

fn min[T:Compare](self:PHeap[T]) -> Option[T]
```

#### 二叉堆

```
struct BHeap[T] {
  mut data:Array[T]
  mut count:Int
}

fn capacity[T](self:BHeap[T]) -> Int

fn residualVolume[T](self:BHeap[T]) -> Int

fn BHeap::new[T:Compare](capacity:Int, minValue:T) -> BHeap[T]

fn BHeap::from_array[T:Compare](arr:Array[T], minValue:T) -> BHeap[T]

fn max[T:Compare](self:BHeap[T]) -> Option[T]

fn pop[T:Compare](self:BHeap[T]) -> Option[T]

fn insert[T:Compare](self:BHeap[T], x:T)
```