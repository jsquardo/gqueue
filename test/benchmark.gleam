import gleam/int
import gleam/io
import gleam/option
import gqueue

@external(erlang, "timer", "tc")
fn timer_tc(f: fn() -> a) -> #(Int, a)

fn build_queue(n: Int) -> gqueue.Queue(Int) {
  build_queue_loop(gqueue.new(), 0, n)
}

fn build_queue_loop(q: gqueue.Queue(Int), i: Int, n: Int) -> gqueue.Queue(Int) {
  case i < n {
    True -> build_queue_loop(gqueue.enqueue(q, i), i + 1, n)
    False -> q
  }
}

fn dequeue_all(q: gqueue.Queue(Int), count: Int) -> Int {
  case gqueue.dequeue(q) {
    option.None -> count
    option.Some(#(_, rest)) -> dequeue_all(rest, count + 1)
  }
}

pub fn main() {
  let n = 200_000
  let q = build_queue(n)
  let #(time, _) = timer_tc(fn() { dequeue_all(q, 0) })
  io.println(
    "Dequeued "
    <> int.to_string(n)
    <> " items in "
    <> int.to_string(time)
    <> "µs",
  )
}
