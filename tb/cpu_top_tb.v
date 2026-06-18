`timescale 1ns/1ps

module cpu_top_tb;

reg clk;
reg reset;

cpu_top uut(

    .clk(clk),
    .reset(reset)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    reset = 1;

    #10;
    reset = 0;

    #50;

    $finish;

end

initial begin

    $dumpfile("cpu_top.vcd");
    $dumpvars(0,cpu_top_tb);

end

endmodule