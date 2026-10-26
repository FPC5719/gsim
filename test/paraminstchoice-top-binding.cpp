#include <cstdio>

#include "ParamInstChoiceTopBinding.h"

int main() {
  SParamInstChoiceTopBinding dut;
  dut.step();
  if (dut.get_value() != 7) return 1;
  std::puts("paraminstchoice top binding: PASS");
  return 0;
}
