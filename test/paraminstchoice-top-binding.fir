FIRRTL version 7.0.0
circuit ParamInstChoiceTopBinding:
  choice_domain Impl width 2:
    choice_case Default = 0
    choice_case Fast = 1

  module DefaultImpl:
    output value: UInt<8>
    connect value, UInt<8>(3)

  module FastImpl:
    output value: UInt<8>
    connect value, UInt<8>(7)

  public module ParamInstChoiceTopBinding:
    input impl: Choice of Impl
    output value: UInt<8>
    paraminstchoice selected impl of DefaultImpl:
      Fast => FastImpl
    connect value, selected.value
