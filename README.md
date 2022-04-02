# tinyrisc-improved-version
Tinyrisc's personal implementation version, and more RISC-V instruction sets will be added in the future. Some key points and implementation details that beginners need to pay attention to will also be added in readme.


//2022.3.12
1，写完取指模块，后续将加入静态分支预测等技术，构造标准取指级。
2，熟悉RV32G指令集架构，明晰译码原理。

//2022.4.2
1，写了部分译码模块（完成I类型指令编码）。
2，更新全局值define中的全部指令的op以及特征常值。

问题：
1，op1_o与op2_o的作用，猜测与ex级输入有关
2，译码级仅获取指令中所指寄存器的地址，并取回数据，未涉及实际取值操作，判断该操作在寄存器regs中执行。
