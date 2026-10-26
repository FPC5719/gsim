FIRRTL version 7.0.0
circuit InterfaceMismatch:
  choice_domain Impl width 1:
    choice_case Default = 0
    choice_case Fast = 1
  module DefaultImpl:
    output out: UInt<8>
  module FastImpl:
    output out: UInt<16>
  module InterfaceMismatch:
    input impl: Choice of Impl
    paraminstchoice selected impl of DefaultImpl:
      Fast => FastImpl
