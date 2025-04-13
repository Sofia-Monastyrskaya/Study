`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2025 20:24:32
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input logic clk, rst,
    input logic [31:0] next_pc,
    output logic [31:0] pc
    );
    
    always_ff@(posedge clk) begin
        if(rst) begin
            pc<=32'b0;
        end
        else begin
            pc<=next_pc+4;
        end
    end
    
endmodule
