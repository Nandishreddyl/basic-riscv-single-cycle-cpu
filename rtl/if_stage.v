module if_stage(

    input clk,
    input reset,

    output [31:0] pc_out,
    output [31:0] instruction

);

pc pc_inst(
    .clk(clk),
    .reset(reset),
    .pc_out(pc_out)
);

instruction_memory imem_inst(
    .address(pc_out),
    .instruction(instruction)
);

endmodule