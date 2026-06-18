`timescale 1ns/1ps

module if_stage_tb;

reg clk;
reg reset;

wire [31:0] pc_out;
wire [31:0] instruction;

if_stage uut(

    .clk(clk),
    .reset(reset),

    .pc_out(pc_out),
    .instruction(instruction)

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

    $monitor(
      "Time=%0t PC=%d Instruction=%h",
      $time,
      pc_out,
      instruction
    );

end

initial begin

    $dumpfile("if_stage.vcd");
    $dumpvars(0, if_stage_tb);
end

endmodule