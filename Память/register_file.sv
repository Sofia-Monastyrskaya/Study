`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2025 15:00:54
// Design Name: 
// Module Name: register_file
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

//регистровый файл
module register_file(
  input  logic        clk_i,
  input  logic        write_enable_i,
  
  
  input  logic [ 4:0] write_addr_i,
  input  logic [ 4:0] read_addr1_i,
  input  logic [ 4:0] read_addr2_i,

  input  logic [31:0] write_data_i,
  output logic [31:0] read_data1_o,
  output logic [31:0] read_data2_o);
  
  logic [31:0] RAM [0:31];
  
  assign read_data1_o =(read_addr1_i==5'd0)?32'd0:RAM[read_addr1_i]; 
  assign read_data2_o =(read_addr2_i==5'd0)?32'd0:RAM[read_addr2_i]; 
  
  always_ff @(posedge clk_i) begin
    if(write_enable_i)begin
        RAM[write_addr_i] <= write_data_i;
    end
  end
  
endmodule
