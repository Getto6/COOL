# COOL
项目简介：
本项目为使用COOL语言实现队列数据结构。队列是一种先进先出（FIFO）的线性数据结构，本实现采用链表作为内部存储结构。
通过QueueNode和Queue两个主要类的协同工作，成功实现了队列的基本操作，包括入队、出队、查看队首元素、检查队列是否为空、打印队列内所有元素的功能。
Main类用于测试队列功能的完整性和正确性。

如何运行COOL代码：
1.打开Linux虚拟机
2.在终端命令窗口输入指令“sudo apt install vim”下载vim
3.在终端命令窗口输入指令“vim coolwork.cl”来创建一个.cl文件
4.键盘点击“i”即可开始输入，将本项目的代码直接粘贴到文件中，键盘点击“esc”退出编辑模式，再在键盘输入“:wq”即可保存.cl文件
5.在终端命令窗口输入指令“coolc coolwork.cl”编译该.cl文件，同时会生成一个coolwork.s文件
6.在终端命令窗口输入“spim coolwork.s”即可运行代码，最终得出运行结果，运行结果最后一行出现“COOL program successfully executed”代表代码成功运行。
