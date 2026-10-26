#include <cstdio>

#include "ParamInstChoiceLiteralSelector.h"

int main() {
  SParamInstChoiceLiteralSelector dut;
  dut.step();
  if (dut.get_value() != 9) return 1;
  std::puts("paraminstchoice literal selector: PASS");
  return 0;
}
