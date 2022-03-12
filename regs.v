`include "defines.v"
module regs(
   input wire clk,
	input wire rst,
	
	//from ex
	input wire exw_enable, //ex write enable
	input wire [4:0] exw_addr,
	input wire [31:0] exw_data,
	
	//from jtag
	input wire jtagw_enable,
	input wire [4:0] jtagw_addr,
	input wire [31:0] jtagw_data,
	
	//to id
	input wire [4:0] idr1_addr,
	input wire [4:0] idr2_addr,
	
	//to id
	output reg [31:0] idr1_data,
	output reg [31:0] idr2_data,
	
	//to jtag
	output reg [31:0] jtagr_data
);
   reg[31:0] regs[0:31]; //define 32 regs which have 32 bits
	
	//read reg 1st
	always @(*) begin     //why * ????
	   if(idr1_addr==`ZeroReg)
		begin
		idr1_data =`ZeroWord;
		end
		
		else if(idr1_addr==exw_addr && exw_enable==`WriteEnable)
		begin
		idr1_data=exw_data;
		end
		
		else begin
		idr1_data=regs[idr1_addr];
		end	
	end

	//read reg 2st
	always @(*) begin
	   if(idr2_addr==`ZeroReg)
		begin
		idr2_data=`ZeroWord;
		end
	
	   else if(idr2_addr==exw_addr && exw_enable==`WriteEnable)
		begin
		idr2_data=exw_data;
		end
		
		else begin
		idr2_data=regs[idr2_addr];
		end
	end
	
	//write reg
	always @ (posedge clk) begin
	   if (rst==`RstDisable) 
		begin
		   if( (exw_enable==`WriteEnable) && (exw_addr != 5'h0) )
			   begin
			   regs[exw_addr] <= exw_data;
			   end
			else if( (jtagw_enable==`WriteEnable) && (jtagw_addr != 5'h0) )
			   begin
				regs[jtagw_addr] <= jtagr_data;
			   end
		end
	end
	
	//jtag read
	always @ (*) begin
	   if (jtagw_addr == `ZeroReg)
		   begin
			jtagr_data = `ZeroWord;
			end
	   else begin
		jtagr_data=regs[jtagw_addr];
		end
	end
endmodule











