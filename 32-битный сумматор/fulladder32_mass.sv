`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2025 22:29:06
// Design Name: 
// Module Name: fulladder32_mass
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

//32-битный сумматор, созданный с помощью массива модулей
module fulladder32_mass(
  input  logic [31:0] a_i,
  input  logic [31:0] b_i,
  input  logic       carry_i,
  output logic [31:0] sum_o,
  output logic       carry_o);
  

 logic [32:0] carries;
 assign carries[0]=carry_i;
 assign carry_o=carries[32];
 
 
full_adder adder[31:0](
    .a_i(a_i),
    .b_i(b_i),
    .carry_i(carries[31:0]),
    .carry_o(carries[32:1]),
    .sum_o(sum_o)
);  

endmodule
