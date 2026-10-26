FIRRTL version 7.0.0
circuit ParamInstChoiceLiteralSelector:
  choice_domain Impl width 2:
    choice_case Default = 0
    choice_case Fast = 1

  module DefaultImpl:
    output value: UInt<8>
    connect value, UInt<8>(4)

  module FastImpl:
    output value: UInt<8>
    connect value, UInt<8>(9)

  public module ParamInstChoiceLiteralSelector:
    output value: UInt<8>
    paraminstchoice selected choice(Impl, Fast) of DefaultImpl:
      Fast => FastImpl
    connect value, selected.value
