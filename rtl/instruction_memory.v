module instruction_memory(

    input [31:0] address,

    output [31:0] instruction

);

reg [31:0] memory [0:15];

initial
begin

    memory[0] = 32'h002082B3; // ADD x5,x1,x2
    memory[1] = 32'h40208333; // SUB x6,x1,x2

end

assign instruction = memory[address[31:2]];

endmodule