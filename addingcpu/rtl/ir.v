
// Instruction Register (IR) module for a CPU design.
module IR(
    input      [7:0] data_in,
    input            load,
    input            clk,
    output reg [7:0] data_out
);
always @(posedge clk)
    if (load)
        data_out <= data_in;
endmodule
