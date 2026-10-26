# GSIM: A Fast RTL Simulator for Large-Scale Designs

GSIM accepts chirrtl, and compiles it to C++

## Prerequisites

+ Install [GMP](https://gmplib.org/), [clang 19(+)](https://clang.llvm.org/).

## Quike Start

+ GSIM provides 4 RISC-V cores ready for simulation: [ysyx3](https://ysyx.oscc.cc/), [Rocket](https://github.com/chipsalliance/rocket-chip), [BOOM](https://github.com/riscv-boom/riscv-boom), [XiangShan](https://github.com/OpenXiangShan/XiangShan).

+ To try GSIM, using
    ```
    $ make init
    $ make run dutName=core
    ```
+ Set core to `ysyx3`, `rocket`, `small-boom`, `large-boom`, `minimal-xiangshan` or `default-xiangshan`

## Usage

+ Run `make build-gsim` to build GSIM
+ Build a static binary locally with `make STATIC=1 build-gsim` (CI artifacts are built statically).
+ Run `build/gsim/gsim $(chirrtl-file)` to compile chirrtl to C++
+ Refer to `build/gsim/gsim --help` for more information
+ See [C++ harness example](https://github.com/jaypiper/simulator/blob/master/emu/emu.cpp) to know how it interacts with the emitted C++ code.

### FIRRTL 7 choice parameters

GSIM supports FIRRTL 7 choice domains, choice input ports, `propassign`,
`choice(Domain, Case)`, and `paraminstchoice`. Selection is resolved during
graph elaboration, so only the selected internal or external module is
instantiated and choice ports do not appear in generated C++ interfaces.
Unbound top-level choices are fixed with repeatable options such as
`--elab-choice=impl=Fast` or `--elab-choice=impl=1`. See
[the FIRRTL 7 choice support note](docs/firrtl-7-choices.md) for syntax,
validation rules, and V1 limitations.

## Debug logs & dumps

+ By default `gsim` runs quietly (`LogLevel=0`, dump disabled). Enable lightweight stage logs with `--log-level=1` (prints pass begin/end). Use `--log-level=2` for verbose constant-analysis traces; expect a lot more stderr.
+ Graph dumps: `--dump` turns on both DOT and JSON dumps for every stage; `--dump-json` / `--dump-dot` turn on a single format. Combine with `--dump-stages=a,b,c` to limit which stages emit (e.g., `AfterSplitNodes,ConstantAnalysis`). Set `--dir=tmp-out/gsim-dumps` to choose the output directory.
+ Extra debugging artifacts: `--dump-assign-tree` includes assignTree structure in JSON dumps; `--dump-const-status` writes `<name>_<stage>_ConstStatus.json` with per-node constant-analysis status.
+ Example: `build/gsim/gsim --dir tmp-out/gsim-dumps --dump --dump-stages=AfterSplitNodes,ConstantAnalysis --dump-assign-tree --log-level=1 ready-to-run/TestHarness-rocket.fir`


## Papers and Presentations
### GSIM: Accelerating RTL Simulation for Large-Scale Design
Lu Chen, Dingyi Zhao, Zihao Yu, Ninghui Sun, Yungang Bao

Design Automation Conference (DAC), 2025

[Paper PDF](https://github.com/jaypiper/simulator/blob/master/docs/dac-gsim.pdf) | [Slides](https://github.com/jaypiper/simulator/blob/master/docs/2025-6-26-dac.pdf) | [Chinese Slides](https://github.com/jaypiper/simulator/blob/master/docs/2025-4-9.pdf)
