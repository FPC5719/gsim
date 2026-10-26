#include <cstdio>

#include "ParamInstChoiceHierarchy.h"

int main() {
  SParamInstChoiceHierarchy dut;
  dut.step();
  if (dut.get_first() != 1) return 1;
  if (dut.get_second() != 2) return 2;
  std::puts("paraminstchoice hierarchy: PASS");
  return 0;
}
