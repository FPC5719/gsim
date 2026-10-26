FIRRTL version 7.0.0
circuit NestedPropAssign:
  choice_domain Impl width 1:
    choice_case Default = 0
  module Leaf:
    input impl: Choice of Impl
  module NestedPropAssign:
    input impl: Choice of Impl
    inst leaf of Leaf
    when UInt<1>(1):
      propassign leaf.impl, impl
