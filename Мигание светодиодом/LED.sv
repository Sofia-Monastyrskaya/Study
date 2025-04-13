`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2024 18:28:57
// Design Name: 
// Module Name: LED
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


module LED(
    input logic clk,
    input logic rst,
    output logic [3:0]  pio_led
    );
    
logic [26:0] cnt;
always_ff @(posedge clk)begin
    if(!rst)
        cnt<=0;
    else
        cnt<=cnt+1'd1;
end
    spi_converter_ila i (
        .clk (clk),
        .probe0 (cnt)
    );
assign pio_led = {4{cnt[26]}};
endmodule
