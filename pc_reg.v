`include "defines.v"
module pc_reg(  //pc寄存器
   input wire clk,
	input wire rst,
	input wire jump_flag,   //跳转标志
	input wire[31:0] jump_addr,   //跳转地址32位
	input wire[2:0] hold_flag,   //暂停标志3位  
	input wire jtag_reset_flag,  //复位标志
	
	output reg[31:0] pc_o  //pc寄存器值
);

   always @(posedge clk) begin
	   if( (rst==`rst_enable) || (jtag_reset_flag==1'b1))
		   begin
		   pc_o=`cpu_reset_addr;
			end
		else if(jump_flag==`jump_enable)
		   begin
			pc_o=jump_addr;
			end
	   else if(hold_flag >=`hold_pc)
		   begin
			pc_o=pc_o;
			end
		else 
		   begin
			pc_o=pc_o+4'h4;
			end
	end
	
endmodule
