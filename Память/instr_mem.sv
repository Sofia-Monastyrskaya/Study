`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2025 14:53:40
// Design Name: 
// Module Name: instr_mem
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

//память инструкций
module instr_mem

import memory_pkg:: INSTR_MEM_SIZE_BYTES;
import memory_pkg:: INSTR_MEM_SIZE_WORDS;

(
    input logic [31:0] read_addr_i,
    output logic [31:0] read_data_o
);
    
    logic [31:0] ROM [0:31];
    
    initial begin
        $readmemh("program.mem", ROM);
    end
    
    assign read_data_o = ROM[read_addr_i[$clog2(INSTR_MEM_SIZE_BYTES)-1:2]];
    
endmodule
