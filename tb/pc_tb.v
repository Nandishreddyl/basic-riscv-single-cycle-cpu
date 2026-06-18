`timescale 1ns/1ps

module pc_tb;

reg clk;
reg reset;

wire [31:0] pc_out;

pc uut (
    .clk(clk),
    .reset(reset),
    .pc_out(pc_out)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;

    #10;
    reset = 0;

    #100;

    $finish;
end

initial
begin
    $monitor("Time=%0t Reset=%b PC=%d",
             $time, reset, pc_out);
end

initial
begin
    $dumpfile("pc.vcd");
    $dumpvars(0, pc_tb);
end

endmodule