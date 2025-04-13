`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2025 13:29:29
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//арифметико-логическое устройство (АЛУ)
module alu(
  input  logic [31:0]  a_i,
  input  logic [31:0]  b_i,
  input  logic [3:0]   alu_op_i,
  output logic         flag_o,
  output logic [31:0]  result_o);
  
  import alu_opcodes_pkg::*;
  
  
  logic [31:0] add_result;
  logic add_carry;
  
  fulladder32_mass adder(
    .a_i(a_i),
    .b_i(b_i),
    .carry_i(1'b0),
    .carry_o(add_carry),
    .sum_o(add_result)
  );
  
  always_comb begin
    case(alu_op_i[3:0])
        
        ALU_ADD:begin
        result_o = add_result;
        flag_o =1;
        end
        ALU_SUB: begin
        result_o = a_i-b_i;
        flag_o =1;
        end
        ALU_XOR:begin
        result_o = a_i^b_i;
        flag_o =1;
        end
        ALU_OR: begin
        result_o = a_i|b_i;
        flag_o =1;
        end
        ALU_AND: begin
        result_o = a_i&b_i;
        flag_o =1;
        end
        ALU_SRA:begin
        result_o = a_i>>>b_i;
        flag_o =1;
        end
        ALU_SRL:begin
        result_o = a_i>>b_i;
        flag_o =1;
        end
        ALU_SLL:begin
        result_o = a_i<<b_i;
        flag_o =1;
        end
        ALU_SLTS:begin
        result_o = ($signed(a_i)<$signed(b_i))?1:0;//�������� ���������
        flag_o =1;
        end
        ALU_SLTU:begin
        result_o = (a_i<b_i)?1:0;//����������� ���������
        flag_o =1;
        end
        ALU_EQ:begin
        flag_o =(a_i==b_i)?1:0;
        result_o=1;
        end
        ALU_NE:begin 
        flag_o =(a_i!=b_i)?1:0;
        result_o=1;
        end
        ALU_LTS:begin
        flag_o =($signed(a_i)<$signed(b_i))?1:0;//�������� ���������
        result_o=1;
        end
        ALU_LTU:begin
        flag_o =(a_i<b_i)?1:0;//����������� ���������
        result_o=1;
        end
        ALU_GES:begin
        flag_o = ($signed(a_i)>=$signed(b_i))?1:0;//�������� ���������
        result_o=1;
        end
        ALU_GEU:begin
        flag_o = (a_i>=b_i)?1:0;//����������� ���������
        result_o=1;
        end
        default: begin
        result_o = 0;
        flag_o = 0;
        end
    endcase
  end
endmodule
