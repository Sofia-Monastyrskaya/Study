`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2025 14:32:07
// Design Name: 
// Module Name: full_adder
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

//1-битный сумматор
module full_adder(
input logic a_i,
input logic b_i,
input logic carry_i,//������� �������
output sum_o,//�����
output carry_o//�������� �������
    );
    logic AxorB;
    logic AxorBxorCarry;
    assign AxorB = a_i^b_i;
    assign AxorBxorCarry = (a_i^b_i)^carry_i;
    
    assign sum_o = AxorBxorCarry;
    
    logic AandB;
    logic AandCarry;
    assign AandB = a_i&b_i;
    assign AandCarry = a_i&carry_i;
    
    logic AandBorAandCarry;
    assign AandBorAandCarry = AandB|AandCarry;
    
    logic BandCarry;
    assign BandCarry = b_i&carry_i;
    
    assign carry_o = AandBorAandCarry|BandCarry;
 
endmodule
