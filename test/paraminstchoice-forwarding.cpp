#include <cstdio>

#include "ParamInstChoiceForwarding.h"

int main() {
  SParamInstChoiceForwarding dut;
  dut.step();
  if (dut.get_first() != 11) return 1;
  if (dut.get_second() != 22) return 2;
  std::puts("paraminstchoice forwarding: PASS");
  return 0;
}
