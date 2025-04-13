`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2025 19:52:12
// Design Name: 
// Module Name: full_adder4
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

//4-битный сумматор
module full_adder4(
  input  logic [3:0] a_i,
  input  logic [3:0] b_i,
  input  logic       carry_i,
  output logic [3:0] sum_o,
  output logic       carry_o);
  
  logic carry_i_1;
  logic carry_i_2;
  logic carry_i_3;
  
  full_adder adder0(
    .a_i(a_i[0]),
    .b_i(b_i[0]),
    .carry_i(0),
    .carry_o(carry_i_1),
    .sum_o(sum_o[0])
  );
  
  full_adder adder1(
    .a_i(a_i[1]),
    .b_i(b_i[1]),
    .carry_i(carry_i_1),
    .carry_o(carry_i_2),
    .sum_o(sum_o[1])
  );
  
  full_adder adder2(
    .a_i(a_i[2]),
    .b_i(b_i[2]),
    .carry_i(carry_i_2),
    .carry_o(carry_i_3),
    .sum_o(sum_o[2])
  );
  
  full_adder adder3(
    .a_i(a_i[3]),
    .b_i(b_i[3]),
    .carry_i(carry_i_3),
    .carry_o(carry_o),
    .sum_o(sum_o[3])
  );
   
endmodule
