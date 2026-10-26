FIRRTL version 7.0.0
circuit MissingPropAssign:
  choice_domain Impl width 1:
    choice_case Default = 0
  module Leaf:
    input impl: Choice of Impl
  module MissingPropAssign:
    inst leaf of Leaf
