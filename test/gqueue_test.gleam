import gleam/option.{None, Some}
import gleeunit
import gqueue

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn enqueue_dequeue_test() {
  let q = gqueue.new()
  let q = gqueue.enqueue(q, 1)
  let q = gqueue.enqueue(q, 2)
  let q = gqueue.enqueue(q, 3)
  assert gqueue.dequeue(q)
    == Some(#(1, gqueue.Queue(front: [2, 3], back: [], size: 2)))
}

pub fn empty_dequeue_test() {
  let q = gqueue.new()
  assert gqueue.dequeue(q) == None
}

pub fn is_empty_test() {
  let q = gqueue.new()
  assert gqueue.is_empty(q) == True
  let q = gqueue.enqueue(q, 1)
  assert gqueue.is_empty(q) == False
}

pub fn size_test() {
  let q = gqueue.new()
  assert gqueue.size(q) == 0
  let q = gqueue.enqueue(q, 1)
  let q = gqueue.enqueue(q, 2)
  let q = gqueue.enqueue(q, 3)
  assert gqueue.size(q) == 3
}

pub fn peek_test() {
  let q = gqueue.new()
  assert gqueue.peek(q) == None
  let q = gqueue.enqueue(q, 1)
  let q = gqueue.enqueue(q, 2)
  assert gqueue.peek(q) == Some(1)
  // ensure the size is still 2 after peek
  assert gqueue.size(q) == 2
}

pub fn to_list_test() {
  let q = gqueue.new()
  let q = gqueue.enqueue(q, 1)
  let q = gqueue.enqueue(q, 2)
  let q = gqueue.enqueue(q, 3)
  assert gqueue.to_list(q) == [1, 2, 3]
}

pub fn from_list_test() {
  let q = gqueue.from_list([1, 2, 3])
  assert gqueue.to_list(q) == [1, 2, 3]
}

pub fn map_test() {
  let q = gqueue.new()
  let q = gqueue.enqueue(q, 1)
  let q = gqueue.enqueue(q, 2)
  let q = gqueue.enqueue(q, 3)
  let q_mapped = gqueue.map(q, fn(x) { x + 1 })
  assert gqueue.to_list(q_mapped) == [2, 3, 4]
}

pub fn filter_test() {
  let q = gqueue.new()
  let q = gqueue.enqueue(q, 1)
  let q = gqueue.enqueue(q, 2)
  let q = gqueue.enqueue(q, 3)
  let q = gqueue.enqueue(q, 4)
  let q = gqueue.enqueue(q, 5)
  let q_filtered = gqueue.filter(q, fn(x) { x > 3 })
  assert gqueue.to_list(q_filtered) == [4, 5]
}

pub fn fold_test() {
  let q = gqueue.new()
  let q = gqueue.enqueue(q, 1)
  let q = gqueue.enqueue(q, 2)
  let q = gqueue.enqueue(q, 3)
  let sum = gqueue.fold(q, 0, fn(acc, x) { acc + x })
  assert sum == 6
}
