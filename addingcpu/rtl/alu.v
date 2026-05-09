// ALU (Arithmetic Logic Unit) module for a CPU design.

module ALU(
    input      [7:0] a,
    input      [7:0] b,
    input            pass,
    input            add,
    output reg [7:0] alu_out
);
always @(*) begin
    if (pass)
        alu_out = a;
    else if (add)
        alu_out = a + b;
    else
        alu_out = 8'h00;
end
endmodule
