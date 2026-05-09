`timescale 1ns/1ps

module testbench;

reg reset = 1'b1;
reg clk   = 1'b0;

wire [5:0] adr_bus;
wire       rd_mem, wr_mem;
wire [7:0] data_bus;

reg [7:0] memory [0:63];
reg [7:0] mem_data = 8'h00;
reg       control  = 1'b0;

// Device Under Test
addingcpu UUT (
    .reset(reset),
    .clk(clk),
    .adr_bus(adr_bus),
    .rd_mem(rd_mem),
    .wr_mem(wr_mem),
    .data_bus(data_bus)
);

// Clock generation
always #10 clk = ~clk;

// Load program and release reset
initial begin
    $readmemh("instructions.mem", memory);
    #25 reset = 1'b0;

    // Run long enough for the sample program
    #400;

    $display("Memory[11] = %0d (expected 6)", memory[11]);
    $display("Memory[12] = %0d (expected 8)", memory[12]);

    $finish;
end

// Simple memory model
always @(posedge clk) begin : Memory_Read_Write
    control = 1'b0;
    #1;
    if (rd_mem) begin
        mem_data = memory[adr_bus];
        control  = 1'b1;
    end
    if (wr_mem) begin
        #3 memory[adr_bus] = data_bus;
    end
end

// Drive data bus during memory reads
assign data_bus = control ? mem_data : 8'hZZ;

endmodule
