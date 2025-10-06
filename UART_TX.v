module UART_Tx (
    input clk,
    input start,
    input [7:0] data_in,
    output reg tx = 1,
    output reg busy = 0
);
    parameter BAUD_TICKS = 10;

    reg [3:0] bit_index = 0;
    reg [9:0] frame = 10'b1111111111;
    reg [3:0] counter = 0;

    always @(posedge clk) begin
        if (start && !busy) begin
            frame <= {1'b1, data_in, 1'b0}; // stop, data, start
            busy <= 1;
            bit_index <= 0;
            counter <= BAUD_TICKS;
         end else if (busy) begin
            if (counter == 0) begin
                tx <= frame[bit_index];
                bit_index <= bit_index + 1;
                counter <= BAUD_TICKS;

                if (bit_index == 9)
                    busy <= 0;
            end else begin
                counter <= counter - 1;
            end
         end else begin
            tx <= 1; // idle
        end
    end
endmodule
