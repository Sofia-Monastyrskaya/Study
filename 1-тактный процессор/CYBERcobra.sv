`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2025 00:03:26
// Design Name: 
// Module Name: CYBERcobra
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

//модуль 1-тактного процессора CYBERcobra 3000 Pro 2.1 (прототип МИЭТ)
module CYBERcobra (
  input  logic         clk_i,
  input  logic         rst_i,
  input  logic [15:0]  sw_i,
  output logic [31:0]  out_o
);

//для памяти инструкций
logic [31:0] RA, RD;

//для регистрового файла
logic [31:0] RD1,RD2;

//для pc
logic [31:0] next_pc;

//счетчик
program_counter pc(
    .clk(clk_i),
    .rst(rst_i),
    .pc(RA),
    .next_pc(next_pc)
);

//память инструкций
instr_mem imem(
    .read_addr_i(RA),
    .read_data_o(RD)
);

logic WE;
assign WE = ~(RD[31]|RD[30]);

logic [5:0] se_1 = RD[5:0];//сигнал, с которым конкатенируем, чтобы знакорасширить
logic [13:0] se_2 = RD[13:0];//сигнал, с которым конкатенируем, чтобы знакорасширить
logic [21:0] se_3 = RD[21:0];//сигнал, с которым конкатенируем, чтобы знакорасширить

//знакорасширения
logic [31:0] SE1,SE2,SE3;
assign SE1 = {{27{RD[31]}},se_1,2'b00};
assign SE2 = {{16{sw_i[15]}},se_2,2'b00};
assign SE3 = {{11{RD[31]}},se_3,2'b00};

logic [4:0] WA =  RD[4:0];
logic [31:0] WD;
logic s0;
logic [31:0]result;//также для АЛУ
logic [1:0] s1 = RD[29:28];

//мультиплексор 4 в 1
always_comb begin
    case (s1)
        2'b00: WD = SE1;
        2'b01: WD = result;
        2'b10: WD = SE2;
        2'b11: WD = 32'd0;
    endcase
end

//логическое И
logic flag;
logic flagandRD30;
assign flagandRD30 = flag & RD[30];

//логическое ИЛИ
logic flagandRD30iliRD31;
assign flagandRD30iliRD31 = flagandRD30 | RD[31];

//знакорасширение
logic [9:0]RD_out1;
logic [12:5] RD_out_12_5;
assign RD_out1 = {RD_out_12_5[12:5],2'b00};

//мультиплексор 2 в 1
assign next_pc = flagandRD30iliRD31 ? SE3 : 32'd4;

//егистровый файл
register_file regfile(
    .clk_i(clk_i),
    .write_enable_i(WE),
    .read_addr1_i(RD[22:18]),
    .read_addr2_i(RD[17:13]),
    .read_data1_o(RD1),
    .read_data2_o(RD2),
    .write_addr_i(WA),
    .write_data_i(WD)
);

//АЛУ
alu alu(
    .a_i(RD1),
    .b_i(RD2),
    .alu_op_i(RD[27:23]),
    .result_o(result),
    .flag_o(flag)
);

assign out_o = RD1;

endmodule
