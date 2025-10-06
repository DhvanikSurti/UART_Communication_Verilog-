module UART_Rx (
    input clk,
    input rx,
    output reg [7:0] data_out,
    output reg done = 0
);
    parameter BAUD_TICKS = 10;

    reg [3:0] bit_index = 0;
    reg [7:0] buffer;
    reg [3:0] counter = 0;
    reg [1:0] state = 0;

    always @(posedge clk) begin
        done <= 0;
        case (state)
            0: if (!rx) begin
                counter <= BAUD_TICKS / 2;
                state <= 1;
            end

            1: if (counter == 0) begin
                bit_index <= 0;
                counter <= BAUD_TICKS;
                state <= 2;
            end else counter <= counter - 1;

            2: if (counter == 0) begin
                buffer[bit_index] <= rx;
                bit_index <= bit_index + 1;
                counter <= BAUD_TICKS;
                if (bit_index == 7)
                    state <= 3;
            end else counter <= counter - 1;

            3: if (counter == 0) begin
                data_out <= buffer;
                done <= 1;
                state <= 0;
            end else counter <= counter - 1;
        endcase
    end
endmodule
