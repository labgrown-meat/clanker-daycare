---
description: Rules for writing and changing tests.
applyTo: "**"
---
# Testing standards

- Mock only at I/O boundaries: network, filesystem, clock, processes, hardware. Use
  real implementations for everything else.
- Assert exact values. Do not use `contains`, `is_ok`, or truthiness checks when the
  exact result is known.
- Cover negative cases: invalid input, error paths, and boundaries.
- One behavior per test; name the test after the behavior.
- A bug fix includes a test that fails without the fix.
- Do not write tests that restate the implementation, check constants, or test
  language or framework behavior.
- Follow the target repo's existing test layout and helpers.
