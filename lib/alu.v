`timescale 1ns/1ps
`define DEBUG
module alu(input      [31:0] a, b,     // operands
           input      [5:0]  alucont,  // control code from decoder
           output reg [31:0] result    // result
           );

  wire [31:0] b2, sum, slt;

`ifdef DEBUG
  initial begin
    $dumpvars(0, a, b, alucont, result);
  end
`endif
  // change sign for substraction
  assign b2 = alucont[5] ? ~b : b;
  // sum operands (if substraction - add one)
  assign sum = a + b2 + alucont[5];
  // check bit 32th bit for sign (comparsion)
  // set if less than 0
  assign slt = sum[31];

  // if any input changes, do:
  always @(*) begin
    case(alucont[4:0])
      5'b00000: result = a & b;
      5'b00001: result = a | b;
      5'b00010: result = sum;
      5'b00011: result = slt;
    endcase
  end
endmodule