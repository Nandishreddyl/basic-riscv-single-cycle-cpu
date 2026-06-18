module data_memory(

    input clk,

    input MemRead,
    input MemWrite,

    input [31:0] address,
    input [31:0] write_data,

    output reg [31:0] read_data

);

reg [31:0] memory [0:255];

integer i;

initial begin

    for(i=0; i<256; i=i+1)
        memory[i] = 0;

end

// Write Operation
always @(posedge clk)
begin

    if(MemWrite)
        memory[address] <= write_data;

end

// Read Operation
always @(*)
begin

    if(MemRead)
        read_data = memory[address];
    else
        read_data = 32'b0;

end

endmodule