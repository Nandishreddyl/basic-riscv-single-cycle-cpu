`timescale 1ns/1ps

module data_memory_tb;

reg clk;

reg MemRead;
reg MemWrite;

reg [31:0] address;
reg [31:0] write_data;

wire [31:0] read_data;

data_memory uut(

    .clk(clk),

    .MemRead(MemRead),
    .MemWrite(MemWrite),

    .address(address),
    .write_data(write_data),

    .read_data(read_data)

);

always #5 clk = ~clk;

initial begin

    clk = 0;

    MemRead = 0;
    MemWrite = 0;

    //--------------------------------
    // Store 55 at address 10
    //--------------------------------

    #10;

    MemWrite = 1;
    address = 10;
    write_data = 55;

    #10;

    MemWrite = 0;

    //--------------------------------
    // Read from address 10
    //--------------------------------

    MemRead = 1;
    address = 10;

    #10;

    //--------------------------------
    // Store 100 at address 20
    //--------------------------------

    MemRead = 0;

    MemWrite = 1;
    address = 20;
    write_data = 100;

    #10;

    MemWrite = 0;

    //--------------------------------
    // Read from address 20
    //--------------------------------

    MemRead = 1;
    address = 20;

    #10;

    $finish;

end

initial begin

    $monitor(
    "Time=%0t Addr=%d MemRead=%b MemWrite=%b WriteData=%d ReadData=%d",
    $time,
    address,
    MemRead,
    MemWrite,
    write_data,
    read_data
    );

end

initial begin

    $dumpfile("data_memory.vcd");
    $dumpvars(0,data_memory_tb);
end

endmodule