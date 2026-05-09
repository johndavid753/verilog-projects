# Adding CPU

A simple 8-bit educational CPU based on the Von Neumann architecture. This project demonstrates the separation of datapath and control unit using Verilog HDL.

## Features

- 8-bit data bus
- 6-bit address bus (64 memory locations)
- Accumulator-based architecture
- Finite State Machine controller
- Four instructions:
  - `00aaaaaa` - LOAD address
  - `01aaaaaa` - STORE address
  - `10aaaaaa` - JUMP address
  - `11iiiiii` - ADD immediate

## Architecture

### Datapath Components

- **IR (Instruction Register)**: Stores the current 8-bit instruction.
- **PC (Program Counter)**: Holds the next instruction address.
- **AC (Accumulator)**: Stores operand and result data.
- **ALU**: Supports PASS and ADD operations.

### Control Unit

FSM with four states:

1. Reset
2. Fetch
3. Decode
4. Execute

## Instruction Set

| Opcode | Mnemonic | Description |
|------:|----------|-------------|
| 00 | LOAD addr | Load memory[addr] into AC |
| 01 | STORE addr | Store AC into memory[addr] |
| 10 | JUMP addr | Load addr into PC |
| 11 | ADD imm | AC = AC + imm |

## Example Program

The included `instructions.mem` executes:

1. LOAD memory[10] (value = 1)
2. ADD 5 → AC = 6
3. STORE to memory[11]
4. JUMP to address 6
5. ADD 2 → AC = 8
6. STORE to memory[12]

Expected results:

- `memory[11] = 6`
- `memory[12] = 8`

## Directory Structure

```text
addingcpu/
├── rtl/
│   ├── ir.v
│   ├── pc.v
│   ├── ac.v
│   ├── alu.v
│   ├── datapath.v
│   ├── controlpath.v
│   └── addingcpu.v
├── tb/
│   └── addingcpu_tb.v
├── instructions.mem
└── README.md
```

## How to Simulate

### Using Icarus Verilog

```bash
iverilog -o addingcpu_sim rtl/*.v tb/addingcpu_tb.v
vvp addingcpu_sim
```

### Using ModelSim or Vivado

Add all RTL files, the testbench, and `instructions.mem` to the simulation project and run the testbench.

## Educational Objectives

This project is ideal for learning:

- Basic CPU architecture
- Von Neumann model
- Datapath and control separation
- Finite State Machines
- Tri-state buses
- Memory interfacing

## Author

Generated from the project report provided by the user and organized into a reusable GitHub-ready project structure.
