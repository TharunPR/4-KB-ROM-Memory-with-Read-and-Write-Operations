# 4KB ROM Memory with Read and Write Operation using Verilog HDL and Testbench Verification

**Aim:** <br>
<br>
&emsp;&emsp;To design and simulate a 4KB ROM memory with read and write operations using Verilog HDL and verify the functionality through a testbench in the Vivado 2023.1 simulation environment.<br>
<br>
**Apparatus Required:** <br>
<br>
&emsp;&emsp;Vivado 2023.1 or equivalent Verilog simulation tool.<br>
&emsp;&emsp;Computer system with a suitable operating system.<br>
<br>
**Procedure:** <br>
<br>
&emsp;**Launch Vivado 2023.1:** <br>
<br>
&emsp;&emsp;Open Vivado and create a new project.<br>
<br>
&emsp;**Design the Verilog Code for ROM:** <br>
<br>
&emsp;&emsp;Write the Verilog code for a 4KB ROM memory with read and write capabilities.<br>
<br>
&emsp;**Create the Testbench:** <br>
<br>
&emsp;&emsp;Write a testbench to simulate both the read and write operations, verifying that the data is correctly written to and read from the memory.<br>
<br>
&emsp;**Add the Verilog Files:** <br>
<br>
&emsp;&emsp;Add the ROM Verilog module and the testbench file to the project.<br>
<br>
&emsp;**Run Simulation:** <br>
<br>
&emsp;&emsp;Run the behavioral simulation in Vivado and check the memory's read and write operations.<br>
<br> 
&emsp;**Observe the Waveforms:** <br>
<br>
&emsp;&emsp;Analyze the waveform to verify that the memory read and write operations work as expected.<br>
<br>
&emsp;**Save and Document Results:** <br>
<br>
&emsp;&emsp;Capture the waveform and include the simulation results in the final report.<br>
<br>
**Verilog Code for 4KB ROM Memory with Read and Write Operations:** <br>
<br>
&emsp;&emsp;In this design, we will implement a 4KB ROM. Since ROM is typically read-only, we will simulate the behavior as if it's writable, but in actual hardware, ROM is typically pre-programmed.<br>
&emsp;&emsp;4KB = 4096 Bytes = 4096 x 8 bits <br>
&emsp;&emsp;The address width for 4KB memory is 12 bits (2^12 = 4096).<br>
```

module rom_memory (
    input wire clk,
    input wire write_enable,   // Signal to enable write operation
    input wire [11:0] address, // 12-bit address for 4KB memory
    input wire [7:0] data_in,  // Data to write into ROM
    output reg [7:0] data_out  // Data read from ROM
);
    reg [7:0] rom[0:4095];
    always @(posedge clk) begin
        if (write_enable) begin
            rom[address] <= data_in;
        end
        data_out <= rom[address];
    end
endmodule

```

**Testbench for 4KB ROM Memory:** 
```

`timescale 1ns / 1ps
module rom_memory_tb;
    reg clk;
    reg write_enable;
    reg [11:0] address;
    reg [7:0] data_in;
    wire [7:0] data_out;
    rom_memory uut (
        .clk(clk),
        .write_enable(write_enable),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );
    always #5 clk = ~clk;  // Toggle clock every 5 ns
    initial begin
        clk = 0;
        write_enable = 0;
        address = 0;
        data_in = 0;
        #10 write_enable = 1; address = 12'd0; data_in = 8'hA5;  // Write 0xA5 at address 0
        #10 write_enable = 1; address = 12'd1; data_in = 8'h5A;  // Write 0x5A at address 1
        #10 write_enable = 1; address = 12'd2; data_in = 8'hFF;  // Write 0xFF at address 2
        #10 write_enable = 1; address = 12'd3; data_in = 8'h00;  // Write 0x00 at address 3
        #10 write_enable = 0; address = 12'd0;
        #10 address = 12'd1;
        #10 address = 12'd2;
        #10 address = 12'd3;
        #10 $stop;
    end
    initial begin
        $monitor("Time = %0t | Write Enable = %b | Address = %h | Data In = %h | Data Out = %h", 
                 $time, write_enable, address, data_in, data_out);
    end
endmodule

```
**Output Waveform:** 

![Screenshot 2024-11-15 110844](https://github.com/user-attachments/assets/eddce12c-a62f-4a3e-92f9-cc13c0e77dd2)

<br>

**Conclusion:** <br>
<br>
&emsp;&emsp;In this experiment, a 4KB ROM memory with read and write operations was designed and successfully simulated using Verilog HDL. The testbench verified both the write and read functionalities by simulating the memory operations and observing the output waveforms. The experiment demonstrates how to implement memory operations in Verilog, effectively modeling both the reading and writing processes for ROM.
