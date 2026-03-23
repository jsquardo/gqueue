import gleam/list
import gleam/option.{type Option, None, Some}

pub type Queue(a) {
  Queue(front: List(a), back: List(a), size: Int)
}

pub fn new() -> Queue(a) {
  Queue(front: [], back: [], size: 0)
}

pub fn enqueue(queue: Queue(a), item: a) -> Queue(a) {
  Queue(front: queue.front, back: [item, ..queue.back], size: queue.size + 1)
}

pub fn dequeue(queue: Queue(a)) -> Option(#(a, Queue(a))) {
  case queue.front {
    [first, ..rest] ->
      Some(#(first, Queue(front: rest, back: queue.back, size: queue.size - 1)))
    [] ->
      case list.reverse(queue.back) {
        [] -> None
        [first, ..rest] ->
          Some(#(first, Queue(front: rest, back: [], size: queue.size - 1)))
      }
  }
}

pub fn is_empty(q: Queue(a)) -> Bool {
  q.front == [] && q.back == []
}

pub fn size(q: Queue(a)) -> Int {
  q.size
}
