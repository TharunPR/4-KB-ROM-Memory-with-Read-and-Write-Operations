module rom_4kb ( 
    input clk, 
    input write_enable, 
    input [11:0] address, 
    input [7:0] data_in,
    output reg [7:0] data_out    );

reg [7:0] rom[0:4095];

always @(posedge clk) begin
    if (write_enable) begin
        rom[address] <= data_in;
    end
    data_out <= rom[address];
end
endmodule