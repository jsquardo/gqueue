# Queuey — Gleam Learning Project

## Purpose
This is a learning project. Johnny is learning Gleam by building a queue library
from scratch. This is not a code dump project — it is a tutoring session that
persists across breaks.

---

## Tutor Rules (always follow these)
- Before writing any code, explain what we're about to do in plain English and why
- Write no more than 10–15 lines at a time
- After each chunk, explain: what Gleam concept did we just use? What should Johnny
  understand before continuing?
- If something could have been written differently, show the tradeoff
- Ask Johnny a question before moving to the next step
- When resuming a session, read this file and summarize where we left off before
  doing anything else

---

## Project: Queuey
A purely functional queue library for Gleam, to be published on hex.pm.

### Phase overview
- [x] Phase 1 — Naive list-backed queue (just make it work) ← COMPLETE
- [ ] Phase 2 — Two-list optimization (discover the O(n) problem, fix it)
- [ ] Phase 3 — Ergonomics (peek, map, filter, fold, to_list, from_list)
- [ ] Phase 4 — Polish and publish to hex.pm

---

## Current status

**Active phase:** Phase 2 — `size` field added, need to write public `size()` function

**Last session:** 2026-03-20

**What we've built so far:**
- Project initialized with `gleam new .`
- `Queue(a)` type defined with `front`, `back`, and `size` fields
- `new()` — returns an empty queue with size: 0
- `enqueue(queue, item)` — prepends item to `back`, increments size
- `dequeue(queue)` — returns `Option(#(a, Queue(a)))`, decrements size, reverses `back` into `front` when `front` is empty
- `is_empty(queue)` — returns `Bool`
- 3 passing tests
- `test/benchmark.gleam` — fixed to use tail-recursive `dequeue_all` with accumulator
- Confirmed amortized O(1) scaling: 100k→1800µs, 200k→3100µs, 1M→26000µs

**Next step:** Write the public `size()` function (Johnny is attempting this independently before next session).

---

## Johnny's understanding

### Solid on
- Libraries vs programs (no `main`, just types and functions)
- `pub` keyword for visibility
- Type parameters (`Queue(a)` — `a` is whatever the caller decides)
- Immutability — functions produce new values, don't modify old ones
- Variable shadowing with `let q =` multiple times
- `Option` — `Some(value)` vs `None`
- Tuples with `#()`
- `case` as pattern matching (not just switch — destructures data simultaneously)
- Spread operator `[item, ..rest]`

### Needs more time / came up in questions
- O(n) vs O(1) intuition — understands the concept but predicting actual time scaling is still developing
- Pattern matching depth — only seen basic examples so far
- Recursion as a replacement for loops — practiced tail recursion with accumulator this session, getting stronger
- Tradeoffs of storing derived state (e.g. size field) — introduced, understood well

### Open questions from last session
(none)

---

## Session log
<!-- Add a new entry at the end of each session -->

### Session template (copy this when updating)
**Date:** YYYY-MM-DD
**Covered:** 
**Concepts introduced:** 
**Johnny seemed solid on:** 
**Needs reinforcement:** 
**Stopped at:** 
**Next step:** 

### Session 1 — 2026-03-19 (part 1)
**Date:** 2026-03-19
**Covered:** Project setup, `Queue(a)` type, `new()`, `enqueue()`, `dequeue()`, 2 passing tests
**Concepts introduced:** Type parameters, immutability, `pub` visibility, `Option`/`Some`/`None`, tuples `#()`, pattern matching with `case`, spread operator `[item, ..rest]`, variable shadowing, libraries vs programs
**Johnny seemed solid on:** All of the above — asked great questions, caught a deliberate trick in a bad test assertion
**Needs reinforcement:** The two-list O(n) tradeoff (will be explored hands-on in Phase 2)
**Stopped at:** `dequeue()` working with 2 passing tests
**Next step:** Add `is_empty`, then move to Phase 2 to discover and fix the O(n) reversal cost

### Session 2 — 2026-03-19 (part 2)
**Date:** 2026-03-19
**Covered:** `is_empty()`, benchmark setup with `@external` Erlang interop, O(n) vs O(1) intuition, measured scaling pain (100k→3600µs, 200k→15000µs, 1M→45000µs), introduced amortized O(1) concept
**Concepts introduced:** `@external` for Erlang interop, recursion as loops, `Bool` return type, amortized O(1)
**Johnny seemed solid on:** `is_empty` (wrote it independently without hints!), `_` as discard placeholder, tuples as return values, the idea that reversal is expensive
**Needs reinforcement:** Predicting time scaling from Big O notation, recursion as a loop pattern
**Stopped at:** Observed benchmark numbers, ready to start Phase 2 rewrite
**Next step:** Phase 2 — rewrite `dequeue` to move items gradually for amortized O(1)

### Session 3 — 2026-03-20 (part 1)
**Date:** 2026-03-20
**Covered:** Fixed benchmark to use tail-recursive `dequeue_all` with accumulator pattern, confirmed amortized O(1) queue behavior with new numbers (100k→1800µs, 200k→3100µs, 1M→26000µs), discussed tradeoff of storing `size` explicitly, began Phase 2 by adding `size` field to `Queue(a)` type
**Concepts introduced:** Tail recursion, accumulator pattern, amortized O(1) confirmed empirically, tradeoffs of storing derived state
**Johnny seemed solid on:** Why non-tail recursion is expensive (stack frames), accumulator pattern walkthrough (correctly traced dequeue_all(3,0)→(2,1)→(1,2)→(0,3)), tradeoff of size field (more to maintain = more bug surface)
**Needs reinforcement:** Predicting exact time scaling from Big O (still developing intuition)
**Stopped at:** About to add `size` field to `Queue(a)` type — haven't typed it yet
**Next step:** Add `size: Int` to `Queue(a)`, update `new()`, `enqueue()`, `dequeue()`, add public `size()` function, fix broken tests

### Session 4 — 2026-03-20 (part 2)
**Date:** 2026-03-20
**Covered:** Added `size: Int` field to `Queue(a)`, used compiler errors as a refactor checklist, updated `new()`, `enqueue()`, `dequeue()` and test file to include size, all 3 tests passing
**Concepts introduced:** Compiler-guided refactoring (letting type errors show you what to fix), maintaining derived state across all constructors
**Johnny seemed solid on:** Using `queue.size + 1` and `queue.size - 1` correctly, understood that both dequeue branches needed the same formula, remembered to save the file 😄
**Needs reinforcement:** Nothing new flagged this session
**Stopped at:** About to write the public `size()` function — Johnny attempting independently before next session
**Next step:** Review Johnny's `size()` attempt, write a test for it, then consider Phase 2 complete and move to Phase 3 ergonomics

---

## How to resume
At the start of each new session, tell Claude Code:

> "Read AGENTS.md to get context on where we left off, then summarize
> what we've done and ask if I'm ready to continue."

At the end of each session, tell Claude Code:

> "Update AGENTS.md — fill in today's session log entry, update the
> current status section, and note anything I struggled with or asked
> about."