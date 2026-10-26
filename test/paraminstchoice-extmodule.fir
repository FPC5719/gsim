FIRRTL version 7.0.0
circuit ParamInstChoiceExtmodule:
  choice_domain Impl width 2:
    choice_case Default = 0
    choice_case Fast = 1

  extmodule ExternalDefault:
    output out: UInt<8>
    parameter WIDTH = 8

  extmodule ExternalFast:
    output out: UInt<8>
    parameter WIDTH = 16

  module Leaf:
    input impl: Choice of Impl
    output out: UInt<8>
    paraminstchoice selected impl of ExternalDefault:
      Fast => ExternalFast
    connect out, selected.out

  public module ParamInstChoiceExtmodule:
    output out: UInt<8>
    inst leaf of Leaf
    propassign leaf.impl, choice(Impl, Fast)
    connect out, leaf.out
