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

pub fn peek(queue: Queue(a)) -> Option(a) {
  case queue.front {
    [first, ..] -> Some(first)
    [] ->
      case list.reverse(queue.back) {
        [] -> None
        [first, ..] -> Some(first)
      }
  }
}

pub fn to_list(queue: Queue(a)) -> List(a) {
  list.append(queue.front, list.reverse(queue.back))
}

pub fn from_list(items: List(a)) -> Queue(a) {
  from_list_loop(items, new())
}

fn from_list_loop(items: List(a), queue: Queue(a)) -> Queue(a) {
  case items {
    [] -> queue
    [first, ..rest] -> from_list_loop(rest, enqueue(queue, first))
  }
}

pub fn map(queue: Queue(a), f: fn(a) -> b) -> Queue(b) {
  let items = to_list(queue)
  let mapped_items = list.map(items, f)
  from_list(mapped_items)
}

pub fn filter(queue: Queue(a), f: fn(a) -> Bool) -> Queue(a) {
  let items = to_list(queue)
  let filtered_items = list.filter(items, f)
  from_list(filtered_items)
}

pub fn fold(queue: Queue(a), initial: b, f: fn(b, a) -> b) -> b {
  let items = to_list(queue)
  list.fold(items, initial, f)
}
