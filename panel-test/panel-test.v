`default_nettype none

`include "../include/led-simple.v"

module top (
        input         CLK,
        input         BTN_N,
        output [15:0] LED_PANEL,
        input         BTN1,
        input         BTN2,
        input         BTN3);

    led_main main (
        .CLK(CLK),
        .resetn_btn(BTN_N),
        .LED_PANEL(LED_PANEL),
        .BUTTONS({BTN3, BTN2, BTN1}));

endmodule

module painter(
        input        clk,
        input        reset,
        input [12:0] frame,
        input  [7:0] subframe,
        input  [5:0] x,
        input  [5:0] y,
        output [2:0] rgb,
        input  [2:0] buttons);

    wire [12:0] xx = {~3'd0, x} - frame[8:0];
    wire red = 320 <= xx && xx < 448;
    wire grn = 160 <= xx && xx < 288;
    wire blu =   0 <= xx && xx < 128;

    //            BLUE GREEN RED
    assign rgb = {blu, grn, red};

endmodule // painter
