module control_unit(

    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,

    output reg [2:0] ALUControl

);

always @(*)
begin

    RegWrite = 0;
    MemRead  = 0;
    MemWrite = 0;
    Branch   = 0;
    ALUControl = 3'b000;

    case(opcode)

        // R-Type
        7'b0110011:
        begin

            RegWrite = 1;

            case({funct7,funct3})

                10'b0000000_000:
                    ALUControl = 3'b000; // ADD

                10'b0100000_000:
                    ALUControl = 3'b001; // SUB

                default:
                    ALUControl = 3'b000;

            endcase

        end

        // LW
        7'b0000011:
        begin
            RegWrite = 1;
            MemRead  = 1;
            ALUControl = 3'b000;
        end

        // SW
        7'b0100011:
        begin
            MemWrite = 1;
            ALUControl = 3'b000;
        end

        // BEQ
        7'b1100011:
        begin
            Branch = 1;
            ALUControl = 3'b001;
        end

    endcase

end

endmodule