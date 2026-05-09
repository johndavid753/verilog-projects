
// Controlpath module for a CPU design.
module Controlpath(
    input        reset,
    input        clk,
    input  [1:0] op_code,
    output reg   rd_mem,
    output reg   wr_mem,
    output reg   ir_on_adr,
    output reg   pc_on_adr,
    output reg   dbus_on_data,
    output reg   data_on_dbus,
    output reg   ld_ir,
    output reg   ld_ac,
    output reg   ld_pc,
    output reg   inc_pc,
    output reg   clr_pc,
    output reg   pass,
    output reg   add,
    output reg   alu_on_dbus
);

parameter Reset   = 2'b00,
          Fetch   = 2'b01,
          Decode  = 2'b10,
          Execute = 2'b11;

reg [1:0] present_state, next_state;

always @(posedge clk)
    if (reset)
        present_state <= Reset;
    else
        present_state <= next_state;

always @(*) begin
    rd_mem = 0; wr_mem = 0; ir_on_adr = 0; pc_on_adr = 0;
    dbus_on_data = 0; data_on_dbus = 0; ld_ir = 0; ld_ac = 0;
    ld_pc = 0; inc_pc = 0; clr_pc = 0; pass = 0; add = 0;
    alu_on_dbus = 0;
    next_state = Reset;

    case (present_state)
        Reset: begin
            next_state = reset ? Reset : Fetch;
            clr_pc = 1;
        end

        Fetch: begin
            next_state = Decode;
            pc_on_adr = 1;
            rd_mem = 1;
            data_on_dbus = 1;
            ld_ir = 1;
            inc_pc = 1;
        end

        Decode:
            next_state = Execute;

        Execute: begin
            next_state = Fetch;
            case (op_code)
                2'b00: begin // LOAD
                    ir_on_adr = 1;
                    rd_mem = 1;
                    data_on_dbus = 1;
                    ld_ac = 1;
                end

                2'b01: begin // STORE
                    pass = 1;
                    ir_on_adr = 1;
                    alu_on_dbus = 1;
                    dbus_on_data = 1;
                    wr_mem = 1;
                end

                2'b10: begin // JUMP
                    ld_pc = 1;
                end

                2'b11: begin // ADD immediate
                    add = 1;
                    alu_on_dbus = 1;
                    ld_ac = 1;
                end
            endcase
        end

        default:
            next_state = Reset;
    endcase
end

endmodule
