 `timescale 1ns / 1ps

module rom_4kb_tb;

// Inputs
reg clk;
reg write_enable;
reg [11:0] address;
reg [7:0] data_in;

// Outputs
wire [7:0] data_out;

// Instantiate the ROM module
rom_4kb uut (
    .clk(clk),
    .write_enable(write_enable),
    .address(address),
    .data_in(data_in),
    .data_out(data_out)
);

// Clock generation
always #5 clk = ~clk;  // Toggle clock every 5 ns

// Test procedure
initial begin
    // Initialize inputs
    clk = 1;
    write_enable = 0;
    address = 0;
    data_in = 0;

    // Write data into memory
    #10 write_enable = 1; address = 12'd0; data_in = 8'hA5;  // Write 0xA5 at address 0
    #10 write_enable = 1; address = 12'd1; data_in = 8'h5A;  // Write 0x5A at address 1
    #10 write_enable = 1; address = 12'd2; data_in = 8'hFF;  // Write 0xFF at address 2
    #10 write_enable = 1; address = 12'd3; data_in = 8'h00;  // Write 0x00 at address 3

    // Disable write and start reading from memory
    #10 write_enable = 0; address = 12'd0;
    #10 address = 12'd1;
    #10 address = 12'd2;
    #10 address = 12'd3;

    // Stop the simulation
    #10 $stop;
end

// Monitor the values for verification
initial begin
    $monitor("Time = %0t | Write Enable = %b | Address = %h | Data In = %h | Data Out = %h", 
             $time, write_enable, address, data_in, data_out);
end
endmodule
