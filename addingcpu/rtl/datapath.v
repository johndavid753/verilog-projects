
// Datapath module for a CPU design.
module datapath(
    input        ir_on_adr,
    input        pc_on_adr,
    input        dbus_on_data,
    input        data_on_dbus,
    input        ld_ir,
    input        ld_ac,
    input        ld_pc,
    input        inc_pc,
    input        clr_pc,
    input        pass,
    input        add,
    input        alu_on_dbus,
    input        clk,
    output [5:0] adr_bus,
    output [1:0] op_code,
    inout  [7:0] data_bus
);

wire [7:0] dbus;
wire [7:0] ir_out;
wire [7:0] a_side;
wire [7:0] alu_out;
wire [5:0] pc_out;

IR  ir (dbus, ld_ir, clk, ir_out);
PC  pc (ir_out[5:0], ld_pc, inc_pc, clr_pc, clk, pc_out);
AC  ac (dbus, ld_ac, clk, a_side);
ALU alu(a_side, {2'b00, ir_out[5:0]}, pass, add, alu_out);

// Tri-state style multiplexing
assign adr_bus  = ir_on_adr   ? ir_out[5:0] : (pc_on_adr ? pc_out : 6'bzzzzzz);
assign dbus     = data_on_dbus ? data_bus :
                  (alu_on_dbus ? alu_out  : 8'bzzzzzzzz);
assign data_bus = dbus_on_data ? dbus     : 8'bzzzzzzzz;

assign op_code = ir_out[7:6];

endmodule
