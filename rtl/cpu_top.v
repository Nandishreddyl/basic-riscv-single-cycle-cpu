module cpu_top(

    input clk,
    input reset

);

    // PC -> Instruction Memory

    wire [31:0] pc_out;
    wire [31:0] instruction;

    // Decoder Outputs

    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] funct7;

    // Control Unit Outputs

    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire Branch;
    wire [2:0] ALUControl;

    // Register File Outputs

    wire [31:0] read_data1;
    wire [31:0] read_data2;

    // ALU Output

    wire [31:0] alu_result;
    wire zero;

    // Write Back

    wire [31:0] write_data;

    //--------------------------------
    // Program Counter
    //--------------------------------

    pc pc_inst(
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out)
    );

    //--------------------------------
    // Instruction Memory
    //--------------------------------

    instruction_memory imem_inst(
        .address(pc_out),
        .instruction(instruction)
    );

    //--------------------------------
    // Instruction Decoder
    //--------------------------------

    instruction_decoder decoder_inst(
        .instruction(instruction),

        .opcode(opcode),
        .rd(rd),
        .funct3(funct3),
        .rs1(rs1),
        .rs2(rs2),
        .funct7(funct7)
    );

    //--------------------------------
    // Control Unit
    //--------------------------------

    control_unit cu_inst(

        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),

        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),

        .ALUControl(ALUControl)

    );

    //--------------------------------
    // Register File
    //--------------------------------

    register_file rf_inst(

        .clk(clk),

        .we(RegWrite),

        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),

        .write_data(write_data),

        .read_data1(read_data1),
        .read_data2(read_data2)

    );

    //--------------------------------
    // ALU
    //--------------------------------

    alu alu_inst(

        .A(read_data1),
        .B(read_data2),

        .ALUControl(ALUControl),

        .Result(alu_result),
        .Zero(zero)

    );

    //--------------------------------
    // Write Back
    //--------------------------------

    write_back wb_inst(

        .MemToReg(1'b0),

        .alu_result(alu_result),
        .memory_data(32'b0),

        .write_data(write_data)

    );

endmodule