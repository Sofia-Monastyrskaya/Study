`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2024 15:30:36
// Design Name: 
// Module Name: spi_converter
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


module spi_converter #(
    parameter integer READ_POLARITY = 0,
    parameter integer WIDTH_DATA = 5,
    parameter integer WIDTH_ADDR = 10,
    
    parameter integer ILA_ENABLE = 0
)(
    input logic sysclk,
    input logic sysrst,
    input logic sclk, //signal
    input logic cs,
    input logic sdi,
    output logic sdo,
    inout logic sdio,
    output logic o_cs,
    output logic o_sclk
    );
    
    assign o_cs = cs;
    assign o_sclk = sclk;
    
    localparam WIDTH_MESS = WIDTH_DATA + WIDTH_ADDR + 1;
    localparam WIDTH_CNT = $clog2(WIDTH_MESS);
    logic [WIDTH_CNT-1:0] cycle_counter;
    logic edge_flag;
    logic cnt_rst;
    
    sclk_counter  #(
        .WIDTH_CNT (WIDTH_CNT)
    )counter(
        .sysclk (sysclk),
        .sysrst (cnt_rst),
        .sclk (sclk),
        .edge_flag (edge_flag),
        .cycle_counter (cycle_counter)
    );
    
    logic r_read_flag;
    
    always_ff @(posedge sysclk) begin
        if (!sysrst) begin
            r_read_flag <= 0;
        end
        else begin
            if (edge_flag == 1 && cycle_counter == 0)  begin
                if (sdi == READ_POLARITY) begin
                    r_read_flag <= 1;      
                end
                else  begin
                    r_read_flag <= 0;
                end
            end
        end
        
    end
    
    //FSM
    enum logic [1:0]
    {
        IDLE = 2'b00,
        ADDR = 2'b01,
        DATA = 2'b10
    } state;
   
    logic tristate;
    localparam out_on = 0;
    localparam out_off = 1;
    
    
    always_ff @(posedge sysclk) begin
        if (!sysrst) begin
            state <= IDLE;
            tristate <= out_on;
            cnt_rst <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                        state <= ADDR;
                        tristate <= out_on;
                        cnt_rst <= 1;
                      end 
                ADDR: if (cycle_counter == WIDTH_ADDR+1) begin
                          state <= DATA;
                          cnt_rst <= 1;
                          tristate <= out_on;
                          if (r_read_flag)begin
                              
                              tristate <= out_off;
                          end
                          else begin
                              tristate <= out_on;
                          end
                      end
                      else begin
                          state <= ADDR;
                          cnt_rst <= 1;
                          tristate <= out_on;
                      end
                DATA: if (cycle_counter == WIDTH_MESS)begin
                          state <= ADDR;
                          tristate <= out_on;
                          cnt_rst <=0;
                          
                      end    
                default: begin 
                            state <= IDLE;
                            tristate <= out_on;
                            cnt_rst <= 1;
                         end
            endcase
        end
    end
  
    logic sdo_buf;
    //tristate buf
    IOBUF IOBUF_spi (
        .O(sdo_buf),   
        .I(sdi),   
        .IO(sdio), 
        .T(tristate)   
    );
   
    assign sdo = tristate ? sdo_buf : 0;
    
   
    if (ILA_ENABLE == 1) begin: ila_on
        spi_converter_ila i (
            .clk (sysclk),
            .probe0 (sysrst),
            .probe1 (cnt_rst),
            .probe2 (cycle_counter),
            .probe3 (r_read_flag),
            .probe4 (tristate),
            .probe5 (state)
            
            );
    end 
    
endmodule
