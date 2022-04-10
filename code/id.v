`include "define.v"
module id(
   input wire rst,
	
	//from pc
	input wire [31:0] inst_i,
	input wire [31:0] inst_addr_i,
	
	//from reg 1 and 2 data
	input wire [31:0] reg1_rdata_i,
	input wire [31:0] reg2_rdata_i,
	
	//from csr reg data
	input wire [31:0] csr_rdata_i,
	
	//jump signal
	input wire ex_jump_flag_i,
	
	//read reg 1 and 2 addr
	output reg [4:0] regr1_addr_o,
	output reg [4:0] regr2_addr_o,
	
	//read csr addr
	output reg [31:0] csrr_addr_o,
	
	//to ex
	output reg [31:0] inst_o,  //instruction content
	output reg [31:0] inst_addr_o,//instruction address
	output reg [31:0] reg1_rdata_o,
	output reg [31:0] reg2_rdata_o,
	
	//to regs
	output reg regw_enable_o,
	output reg [4:0] regw_addr_o,
	
	//to csr
	output reg csrw_enable_o,
	output reg [31:0] csrw_data_o,
	output reg [31:0] csrw_addr_o
	
	output reg[31:0] op1_o,
   output reg[31:0] op2_o,
   output reg[31:0] op1_jump_o,
   output reg[31:0] op2_jump_o,
);
   //corrosponding
   wire [6:0] opcode = inst_i[6:0];
   wire [2:0] funct4 = inst_i[14:12];
   wire [6:0] funct1 = inst_i[31:25];
   wire [4:0] rd = inst_i[11:7];
	wire [4:0] rs1= inst_i[19:15];
	wire [4:0] rs2= inst_i[24:20];
	
	//Combinational logic id circuit
	always @(*) begin
	   inst_o = inst_i;
		inst_addr_o = inst_addr_i;
		
		reg1_rdata_o = reg1_rdata_i;
		reg2_rdata_o = reg2_rdata_i;
		
		csrw_data_o = csr_rdata_i;
		csrw_addr_o = `ZeroWord;
		csrr_addr_o = `ZeroWord;
		csrw_enable_o = `WriteDisable;
		
		op1_o = `ZeroWord;
		op2_o = `ZeroWord;
		op1_jump_o = `ZeroWord;
		op2_jump_o = `ZeroWord;
		
		  case (opcode)
		      `inst_type_I:
				 begin
				    case (funct4)
					   `inst_addi,`inst_slti,`inst_sltiu, `inst_xori, `inst_ori, `inst_andi, `inst_slli ,`inst_sri:
			        
				          regw_enable_o=`WriteEnable;
						    regw_addr_o=rd;
						    reg1_addr_o=rs1;
						    reg2_addr_o=`ZeroReg;
						 
						    op1_o=reg1_rdata_i;  //get rs1 data
						    op2_o = {{20{inst_i[31]}}, inst_i[31:20]}; //get immediate value
		              end		
					     default:begin
					        regw_enable_o=`WriteDisable;
							  regw_addr_o=`ZeroReg;
							  reg1_addr_o=`ZeroReg;
						     reg2_addr_o=`ZeroReg;
					     end
			        endcase
		        end
				  
				  `inst_type_R: //I have some,R have some
				  begin
				      if((funct1==7'b0000000)||(funct1==7'b0100000))
					  begin
					     case(funct4)
						     `inst_add_sub,`inst_sll,`inst_slt,`inst_sltu,`inst_xor,`inst_sr,`inst_or,`inst_and:begin
						     
						     regw_enable_o=`WriteEnable;
							  regw_addr_o=rd;
							  reg1_addr_o=rs1;
							  reg2_addr_o=rs2;
							  
							  op1_o=reg1_rdata_i;
							  op2_o=reg2_rdata_i;
						     end
						  default:begin
						     regw_enable_o=`WriteDisable;
							  regw_addr_o=`ZeroReg;
							  reg1_addr_o=`ZeroReg;
							  reg2_addr_o=`ZeroReg;
						     end
						  endcase
					  end 
				  end
			  
			   `inst_type_L:
				  begin
				     case(funct4)
					     `inst_lb,`inst_lh,`inst_lw,`inst_lbu,`inst_luh:begin
						   
							reg1_addr_o=rs1;
							reg2_addr_o=`ZeroReg;
							regw_enable_o=`WriteEnable;
							regw_addr_o=rd;
							
							op1_o=reg1_rdata_i;
							op2_o={{20{inst_i[31]}}, inst_i[31:20]};
							end
					  default:begin
					     reg1_addr_o=`ZeroReg;
						  reg2_addr_o=`ZeroReg;
						  regw_enable_o=`WriteDisable;
						  regw_addr_o=`ZeroReg;
					     end
					  endcase
				  end
				  
				  `inst_type_S:
				  begin
				     case(funct4)
					     `inst_sb,`inst_sh,`inst_sw:begin
						  
						  reg1_addr_o=rs1;
						  reg2_addr_o=rs2;
						  regW_enable_o=`WriteEnable;
						  regw_addr_o=`ZeroReg;
						  
						  op1_o=reg1_rdata_i;
						  op2_o = {{20{inst_i[31]}}, inst_i[31:25], inst_i[11:7]};
						  end
					  default:begin
					     reg1_addr_o=`ZeroReg;
						  reg2_addr_o=`ZeroReg;
						  regw_enable_o=`WriteDisable;
						  regw_addr_o=`ZeroReg;
					     end
				     endcase
				  end
				  
				  `inst_type_B://change pc value
				  begin
				     case(funct4)
					     `inst_beq,`inst_bne,`inst_blt,`inst_bge,`inst_bltu,`inst_bgeu:begin
						   
							reg1_addr_o=rs1;
							reg2_addr_o=rs2;
							regw_enable_o=`WriteDisable;
							regw_addr_o=`ZeroReg;
							
							op1_o=reg1_rdata_i;
							op2_o=reg2_rdata_i;
							op1_jump_o=inst_addr_i;
							op2_jump_o={{20{inst_i[31]}}, inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0};//??
						  end
					  default:begin
					     reg1_addr_o=`ZeroReg;
						  reg2_addr_o=`ZeroReg;
						  regw_enable_o=`WriteDisable;
						  regw_addr_o=`ZeroReg;
					     end
					  endcase
				  end
			  
			  
			  
			  
	end
	
	
	
	
	
	
	
	

