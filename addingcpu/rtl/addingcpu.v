
// Top-level module for a simple CPU design that adds two numbers.
module addingcpu(
    input        reset,
    input        clk,
    output [5:0] adr_bus,
    output       rd_mem,
    output       wr_mem,
    inout  [7:0] data_bus
);

wire ir_on_adr, pc_on_adr, dbus_on_data, data_on_dbus;
wire ld_ir, ld_ac, ld_pc, inc_pc, clr_pc;
wire pass, add, alu_on_dbus;
wire [1:0] op_code;

Controlpath Cu(
    reset, clk, op_code,
    rd_mem, wr_mem,
    ir_on_adr, pc_on_adr,
    dbus_on_data, data_on_dbus,
    ld_ir, ld_ac, ld_pc,
    inc_pc, clr_pc,
    pass, add, alu_on_dbus
);

datapath dp(
    ir_on_adr, pc_on_adr,
    dbus_on_data, data_on_dbus,
    ld_ir, ld_ac, ld_pc,
    inc_pc, clr_pc,
    pass, add, alu_on_dbus,
    clk, adr_bus, op_code, data_bus
);

endmodule
