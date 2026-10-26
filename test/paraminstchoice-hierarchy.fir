FIRRTL version 7.0.0
circuit ParamInstChoiceHierarchy:
  choice_domain Impl width 1:
    choice_case Inner1 = 0
    choice_case Inner2 = 1

  module Inner1:
    output value: UInt<8>
    connect value, UInt<8>(1)

  module Inner2:
    output value: UInt<8>
    connect value, UInt<8>(2)

  module Outer:
    input impl: Choice of Impl
    output value: UInt<8>
    paraminstchoice selected impl of Inner1:
      Inner2 => Inner2
    connect value, selected.value

  public module ParamInstChoiceHierarchy:
    output first: UInt<8>
    output second: UInt<8>
    inst outer1 of Outer
    inst outer2 of Outer
    propassign outer1.impl, choice(Impl, Inner1)
    propassign outer2.impl, choice(Impl, Inner2)
    connect first, outer1.value
    connect second, outer2.value
