module UART_Test;

    reg clk = 0;
    always #1 clk = ~clk;
    
    reg start = 0;
    reg [7:0] data_in = 0;
    wire tx;
    wire busy;

    UART_Tx tx_inst (
        .clk(clk),
        .start(start),
        .data_in(data_in),
        .tx(tx),
        .busy(busy)
    );

    wire [7:0] received_data;
    wire done;

    UART_Rx rx_inst (
        .clk(clk),
        .rx(tx),
        .data_out(received_data),
        .done(done)
    );
initial begin
        $dumpfile("uart_wave.vcd");
        $dumpvars(0, UART_Test);

        $display("Time\tSent\tReceived\tDone");

        #5;
        // --- Send the first byte (41) ---
        data_in = 8'h41;
        start = 1; #2; start = 0;

        // --- CORRECT WAY TO WAIT ---
        // Wait for the busy signal to go low after the start pulse.
        @(posedge clk); // Align to the clock
        while (!done) begin
            @(posedge clk);
        end
        
        #10; // Add a small delay for waveform clarity

        $display("%0t\tSent: %h\tReceived: %h\tDone: %b", $time, 8'h41, received_data, done);
        #2;
        // --- Send the second byte (42) ---
        data_in = 8'h42;
        start = 1; #2; start = 0;

        // --- WAIT AGAIN ---
        @(posedge clk);
        while (!done) begin
            @(posedge clk);
        end
        
        #10;

        $display("%0t\tSent: %h\tReceived: %h\tDone: %b", $time, 8'h42, received_data, done);

        $finish;
    end

endmodule
