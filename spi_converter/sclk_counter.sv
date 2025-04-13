`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2024 16:26:43
// Design Name: 
// Module Name: sclk_counter
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

//risingedge-detector
module sclk_counter #(
    parameter integer WIDTH_CNT = 4, 
    parameter integer ILA_ENABLE = 0
)(
    input logic sysclk,
    input logic sclk, //signal
    input logic sysrst,
    output logic edge_flag,
    output logic [WIDTH_CNT - 1:0] cycle_counter
    );
    
logic sclk_dly;
logic edge_detector;
always_ff @(posedge sysclk) begin
    sclk_dly <= sclk;
end
assign edge_detector = sclk & ~sclk_dly;

//counter
logic [WIDTH_CNT - 1:0] cnt;
always_ff @(posedge sysclk)begin
    if(!sysrst)begin
        cnt<=0;
    end
    else begin
        if(edge_detector) begin
            cnt<=cnt+1'd1;
        end
    end
end

if (ILA_ENABLE == 1) begin: ila_on
    spi_converter_ila i (
            .clk (clk),
            .probe0 (edge_detector),
            .probe1 (cnt)
        );
end 
    
assign edge_flag = edge_detector;
assign cycle_counter = cnt;

endmodule
