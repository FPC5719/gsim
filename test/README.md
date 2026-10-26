# Test Inputs

- Any `*.fir` file in this directory is auto-discovered by `make fir-tests` and by the GitHub CI `fir-regression` job.
- A same-name `*.cpp` file is compiled with the generated model and run under
  AddressSanitizer and UndefinedBehaviorSanitizer.
- A same-name `*.flags` file supplies extra GSIM command-line options for that
  test case.
- array-narrowing.fir: Checks element-width truncation on two-dimensional
  register row connects, plus unsigned and signed whole-array narrowing and
  extension across native C++ storage widths.
- array-widening.fir: Checks signed and unsigned widening of vectors rebuilt
  from scalar members, including mixed constant/runtime elements.
- dshr-overshift.fir: Checks FIRRTL-defined dynamic right shifts at and beyond
  the operand width for both unsigned and signed values.
- dynamic-vector-index.fir: Checks in-bounds reads plus deterministic,
  memory-safe out-of-bounds reads and writes through dynamic vector indices.
- input-narrowing.fir: Checks input normalization after used-width optimization,
  including comparisons and signed extension from narrowed ports.
- cat-eq-constant.fir: Checks constant slicing in the
  `cat(lhs, rhs) == constant` optimization.
- repro-usefulreset.fir: Minimized FIR reproducer for GSIM issue #106, used to guard against ConstantAnalysis hangs and OOM regressions.
- signed-node-shr.fir: Checks constant propagation of a signed right shift
  whose operand is a node reference.
- signed-sub-wrap.fir: Checks signed subtraction across overflow boundaries,
  including truncated comparisons and full-width/shifted results.
- signed-rem-overflow.fir: Checks signed remainder for MIN/-1 and ordinary
  positive/negative operands, including constant divisors and narrowed results.
- signed-constant-slice.fir: Checks node splitting of shifts, bit selections,
  and padding applied to negative signed constants.
- signed-runtime-slice.fir: Checks that a full-width signed bit selection becomes
  unsigned without host sign-extension bits when concatenated with other bits.
- paraminstchoice-hierarchy.fir: Checks per-instance specialization of a shared
  module with different elaboration-time choice actuals.
- paraminstchoice-forwarding.fir: Checks choice forwarding through two wrapper
  modules before the parameterized instance choice.
- paraminstchoice-extmodule.fir: Checks that only the selected external
  candidate is emitted and receives its parameter list.
- paraminstchoice-literal-selector.fir: Checks folding of a literal
  `choice(Domain, Case)` selector.
- paraminstchoice-nested.fir: Checks structural selection of a
  `paraminstchoice` declared inside a `when` block.
- paraminstchoice-top-binding.fir: Checks a top-level choice supplied through
  the per-test `paraminstchoice-top-binding.flags` file.

Negative coverage for diagnostics and version gating is under
`test/paraminstchoice/errors/`.
