FIRRTL version 7.0.0
circuit ProbeCandidate:
  choice_domain Impl width 1:
    choice_case Default = 0
    choice_case Alternate = 1
  module DefaultImpl:
    output out: Probe<UInt<8>>
  module AlternateImpl:
    output out: Probe<UInt<8>>
  module ProbeCandidate:
    input impl: Choice of Impl
    paraminstchoice selected impl of DefaultImpl:
      Alternate => AlternateImpl
