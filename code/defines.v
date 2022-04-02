//pc reg
`define cpu_reset_addr 32'h0
`define rst_enable 1'b0
`define jump_enable 1'b1
`define hold_pc 3'b001

//common regs
`define ZeroWord 32'h0
`define ZeroReg 5'h0
`define WriteEnable 1'b1
`define WriteDisable 1'b0
`define RstEnable 1'b0
`define RstDisable 1'b1

//id inst I type instruction 
`define inst_type_I 7'b0010011

`define inst_addi 3'b000
`define inst_slti 3'b010
`define inst_sltiu 3'b011
`define inst_xori 3'b100
`define inst_ori 3'b110
`define inst_andi 3'b111
`define inst_slli 3'b001
`define inst_sri 3'b101   //srai

//inst L type instruction
`define inst_type_L 7'b0000011

`define inst_lb 3'b000
`define inst_lh 3'b001
`define inst_lw 3'b010
`define inst_lbu 3'b100
`define inst_lhu 3'b101

//inst R
`define inst_type_R 7'b0110011

`define inst_add_sub 3'b000
`define inst_sll 3'b001
`define inst_slt 3'b010
`define inst_sltu 3'b011
`define inst_xor 3'b100
`define inst_sr 3'b101
`define inst_or 3'b110
`define inst_and 3'b111


//inst S
`define inst_type_S 7'b0100011

`define inst_sb 3'b000
`define inst_sh 3'b001
`define inst_sw 3'b010

//inst B
`define inst_type_B 7'b1100011

`define inst_beq 3'b000
`define inst_bne 3'b001
`define inst_blt 3'b100
`define inst_bge 3'b101
`define inst_bltu 3'b110
`define inst_bgeu 3'b111

//inst csr
`define inst_type_csr 7'b1110011

`define inst_csrrw 3'b001
`define inst_csrrs 3'b010
`define inst_csrrc 3'b011
`define inst_csrrwi 3'b101
`define inst_csrrsi 3'b110
`define inst_csrrci 3'b111

//other inst type
`define inst_jal 7'b1101111
`define inst_jalr 7'b1100111

`define inst_lui 7'b0110111
`define inst_auipc 7'b0010111

`define inst_fence 7'b0001111

`define inst_ecall 32'h73
`define inst_ebreak 32'h00100073
