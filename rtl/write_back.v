module write_back(

    input MemToReg,

    input [31:0] alu_result,
    input [31:0] memory_data,

    output [31:0] write_data

);

assign write_data =
        (MemToReg) ?
        memory_data :
        alu_result;

endmodule