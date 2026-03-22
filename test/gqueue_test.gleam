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
