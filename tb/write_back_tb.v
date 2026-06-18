`timescale 1ns/1ps

module write_back_tb;

reg MemToReg;

reg [31:0] alu_result;
reg [31:0] memory_data;

wire [31:0] write_data;

write_back uut(

    .MemToReg(MemToReg),

    .alu_result(alu_result),
    .memory_data(memory_data),

    .write_data(write_data)

);

initial begin

    //--------------------------------
    // ADD instruction
    //--------------------------------

    MemToReg = 0;

    alu_result = 30;
    memory_data = 55;

    #10;

    //--------------------------------
    // LW instruction
    //--------------------------------

    MemToReg = 1;

    #10;

    $finish;

end

initial begin

    $monitor(
    "Time=%0t MemToReg=%b ALU=%d MEM=%d WriteData=%d",
    $time,
    MemToReg,
    alu_result,
    memory_data,
    write_data
    );

end

initial begin

    $dumpfile("write_back.vcd");
    $dumpvars(0,write_back_tb);

end

endmodule