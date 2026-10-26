#include <cstdio>

#include "ParamInstChoiceNested.h"

int main() {
  SParamInstChoiceNested dut;
  dut.set_enable(1);
  dut.step();
  if (dut.get_value() != 8) return 1;
  dut.set_enable(0);
  dut.step();
  if (dut.get_value() != 8) return 2;
  std::puts("paraminstchoice nested: PASS");
  return 0;
}
