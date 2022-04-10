# tinyrisc-improved-version项目进度与注意说明
Tinyrisc's personal implementation version, and more RISC-V instruction sets will be added in the future. Some key points and implementation details that beginners need to pay attention to will also be added in readme.


//2022.3.12<br>
1，写完取指模块，后续将加入静态分支预测等技术，构造标准取指级。<br>
2，熟悉RV32G指令集架构，明晰译码原理。<br>
RV32I的全部指令如下，具体映射与指令格式可见pic文件夹中图片：<br>
![](https://github.com/ZhaoHaowenn/tinyrisc-improved-version/raw/main/picforread/RV32I.png)

//2022.4.2<br>
1，写了部分译码模块（完成I类型指令编码）。<br>
2，更新全局值define中的全部指令的op以及特征常值。<br>

问题：<br>
1，op1_o与op2_o的作用，猜测与ex级输入有关。<br>
2，译码级仅获取指令中所指寄存器的地址，并取回数据，未涉及实际取值操作，判断该操作在寄存器regs中执行。<br>

//2022.4.10<br>
1，完成RV32I中B，S，L类型指令的译码<br>
2，剩余CSR与个别特殊指令译码，将于2022.4.11完成，2022.4.11拟进行执行级的代码编写。<br>
