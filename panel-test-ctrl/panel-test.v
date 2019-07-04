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

    // Bit legend
    // 0: all on
    // 1: even column on
    // 2: odd column on
    // 3: even row on
    // 4: odd column on
    // 5: even column & row on
    // 6: odd column & row on
    // 7: off
    reg [7:0] red = 8'b1000_0000;
    reg [7:0] grn = 8'b1000_0000;
    reg [7:0] blu = 8'b1000_0000;

    wire red_strobe;
    button_debouncer db1(
        .clk(clk),
        .button_pin(buttons[0]),
        .rising_edge(red_strobe));

    wire grn_strobe;
    button_debouncer db2(
        .clk(clk),
        .button_pin(buttons[1]),
        .rising_edge(grn_strobe));

    wire blu_strobe;
    button_debouncer db3(
        .clk(clk),
        .button_pin(buttons[2]),
        .rising_edge(blu_strobe));

    always @(posedge clk) begin
        if (reset) begin
            red <= 8'b1000_0000;
            grn <= 8'b1000_0000;
            blu <= 8'b1000_0000;
        end else begin
            if (red_strobe) begin
                red[7:1] <= red[6:0];
                red[0] <= red[7];
            end
            if (grn_strobe) begin
                grn[7:1] <= grn[6:0];
                grn[0] <= grn[7];
            end
            if (blu_strobe) begin
                blu[7:1] <= blu[6:0];
                blu[0] <= blu[7];
            end
        end
    end


    assign rgb[0] =  red[0] ||
                    (red[1] &&  x[0]) ||
                    (red[2] && ~x[0]) ||
                    (red[3] &&  y[0]) ||
                    (red[4] && ~y[0]) ||
                    (red[5] &&  x[0] &&  y[0]) ||
                    (red[6] && ~x[0] && ~y[0]);
    assign rgb[1] =  grn[0] ||
                    (grn[1] &&  x[0]) ||
                    (grn[2] && ~x[0]) ||
                    (grn[3] &&  y[0]) ||
                    (grn[4] && ~y[0]) ||
                    (grn[5] &&  x[0] &&  y[0]) ||
                    (grn[6] && ~x[0] && ~y[0]);
    assign rgb[2] =  blu[0] ||
                    (blu[1] &&  x[0]) ||
                    (blu[2] && ~x[0]) ||
                    (blu[3] &&  y[0]) ||
                    (blu[4] && ~y[0]) ||
                    (blu[5] &&  x[0] &&  y[0]) ||
                    (blu[6] && ~x[0] && ~y[0]);
    //            BLUE GREEN RED
    //assign rgb = {blu[0], grn[0], red[0]};

endmodule // painter
