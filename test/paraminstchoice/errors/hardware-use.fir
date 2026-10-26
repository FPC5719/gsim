FIRRTL version 7.0.0
circuit HardwareUse:
  choice_domain Impl width 1:
    choice_case Default = 0
  module HardwareUse:
    input impl: Choice of Impl
    output out: UInt<1>
    connect out, impl
