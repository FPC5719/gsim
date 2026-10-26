# FIRRTL 7 Elaboration-Time Choices

GSIM supports the FIRRTL 7.0 choice syntax used to specialize module
structure at elaboration time. The constructs are gated by the declared
FIRRTL version and are rejected below 7.0.0.

## Supported Syntax

Choice domains are declared at circuit scope:

```firrtl
FIRRTL version 7.0.0
circuit Top:
  choice_domain Impl width 2:
    choice_case Default = 0
    choice_case Fast = 1
```

Choice parameters are input ports and may be forwarded with `propassign`:

```firrtl
module Wrapper:
  input impl: Choice of Impl
  inst leaf of Leaf
  propassign leaf.impl, impl
```

`choice(Domain, Case)` supplies a literal value. A `paraminstchoice` selects
one internal or external module implementation from its selector:

```firrtl
module Leaf:
  input impl: Choice of Impl
  output value: UInt<8>
  paraminstchoice selected impl of DefaultImpl:
    Fast => FastImpl
  connect value, selected.value
```

Selection happens while GSIM elaborates the graph. Only the selected target is
instantiated; there is no runtime multiplexer and inactive candidates have no
graph-side effects.

`paraminstchoice` declarations may appear inside `when` blocks. The surrounding
condition controls hardware behavior, while the instance target is still
selected structurally during elaboration.

Choice ports are elaboration-only. GSIM removes them from the generated C++
interface, so no `set_impl` or `get_impl` method is emitted. References to a
`paraminstchoice` instance, such as `selected.value`, resolve like ordinary
instance references.

## Top-Level Bindings

A reachable top-level choice input must be fixed at GSIM compile time with a
repeatable command-line option:

```sh
gsim --elab-choice=impl=Fast design.fir
gsim --elab-choice=impl=1 design.fir
```

The value is either a case name or an unsigned encoding that fits the domain
width. Omitting a top-level binding is an error. Unknown ports, duplicate
bindings, unknown cases, and out-of-range encodings are also rejected.

## Validation

GSIM validates domain widths, case names and encodings, selector domains,
alternative families, module existence, and candidate interfaces before graph
construction. Candidate interfaces must match in port names, directions,
types, widths, signedness, aggregate structure, and choice parameters.

The V1 implementation intentionally rejects:

- output choice ports and choice values used by hardware operations;
- runtime choice expressions, arithmetic, memories, and aggregates;
- conditional or general property dataflow;
- missing or duplicate `propassign` assignments;
- targets other than internal modules and extmodules.

These restrictions keep elaboration semantics equivalent to structural
selection rather than runtime hardware selection.
