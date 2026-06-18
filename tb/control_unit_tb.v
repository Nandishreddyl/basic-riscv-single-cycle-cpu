`timescale 1ns/1ps

module control_unit_tb;

reg [6:0] opcode;
reg [2:0] funct3;
reg [6:0] funct7;

wire RegWrite;
wire MemRead;
wire MemWrite;
wire Branch;
wire [2:0] ALUControl;

control_unit uut(

    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),

    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .ALUControl(ALUControl)

);

initial begin

    // ADD
    opcode = 7'b0110011;
    funct3 = 3'b000;
    funct7 = 7'b0000000;

    #10;

    // SUB
    funct7 = 7'b0100000;

    #10;

    // LW
    opcode = 7'b0000011;

    #10;

    // SW
    opcode = 7'b0100011;

    #10;

    // BEQ
    opcode = 7'b1100011;

    #10;

    $finish;

end

initial begin

    $monitor(
    "opcode=%b RegWrite=%b MemRead=%b MemWrite=%b Branch=%b ALUCtrl=%b",
    opcode,
    RegWrite,
    MemRead,
    MemWrite,
    Branch,
    ALUControl
    );

end
initial begin

    $dumpfile("control_unit.vcd");

    $dumpvars(0, control_unit_tb);

end
endmodule