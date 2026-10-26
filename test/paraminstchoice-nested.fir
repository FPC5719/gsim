FIRRTL version 7.0.0
circuit ParamInstChoiceNested:
  choice_domain Impl width 1:
    choice_case Default = 0
    choice_case Fast = 1

  module DefaultImpl:
    output value: UInt<8>
    connect value, UInt<8>(5)

  module FastImpl:
    output value: UInt<8>
    connect value, UInt<8>(8)

  module ParamInstChoiceNested:
    input enable: UInt<1>
    output value: UInt<8>
    when enable:
      paraminstchoice selected choice(Impl, Fast) of DefaultImpl:
        Fast => FastImpl
    connect value, selected.value
