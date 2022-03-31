# AHB2APB

version : 1.0

description : 实现基本功能

---

## 端口描述

|端口名称|属性|所属协议|备注
|--|--|--|--
|hclk|input 1-bit|AHB(AMBA 5)| AHB 所属系统时钟
|hreset_n|input 1-bit|AHB(AMBA 5)| AHB 所属系统复位 低电平有效
|haddr|input *HADDR_SYS_WIDTH*|AHB(AMBA 5)| AHB 地址总线 32位
|hwdata|input *AHB_DATA_WIDTH*|AHB(AMBA 5)| AHB 写数据总线
|hrdata|output *AHB_DATA_WIDTH*|AHB(AMBA 5)| AHB 读数据总线
|hready|input 1-bit|AHB(AMBA 5)| AHB ready signal 
|hsel|input 1-bit|AHB(AMBA 5)| AHB slave select signal 
|htrans|input *HTRANS_WIDTH*|AHB(AMBA 5)| AHB 传输状态类型
|hwrite|input 1-bit|AHB(AMBA 5)| AHB 读写方向
|hsize|input *HSIZE_WIDTH*|AHB(AMBA 5)| AHB 传输尺寸
|hburst|input *HBURST_WIDTH*|AHB(AMBA 5)| AHB 突发传输类型
|hresp|output 1-bit|AHB(AMBA 5)| AHB response
|hreadyout|output 1-bit|AHB(AMBA 5)| AHB ready output
|penable|output 1-bit|APB(AMBA 5)| APB enable
|paddr|output *PADDR_WIDTH*|APB(AMBA 5)| APB 地址总线 32位
|pwrite|output 1-bit|APB(AMBA 5)| APB 读写方向
|pwdata|output *APB_DATA_WIDTH*|APB(AMBA 5)| APB 写数据总线 32位
|psel_x|output 1-bit|APB(AMBA 5)| APB 从设备选择
|prdata_x|input *APB_DATA_WIDTH*|APB(AMBA 5)| APB 从设备读数据总线 32位
|pready_x|input 1-bit|APB(AMBA 5)| APB 从设备 ready signal
|pslverr_x|input 1-bit|APB(AMBA 5)| APB 从设备错误信号

注：x 表示不同的从设备

注：没有列出且必须要实现的端口按照 AMBA5 协议栈采用默认值

## 设计指标

- 不支持大小端格式的转换。即不变动数据总线上的数据。
  
- 不支持 WSTRB。

- 同步桥设计，时钟来源于 AHB 总线

- 仅支持32位地址总线，32位数据总线
  
- 支持12个从设备
  
## 仿真测试

执行命令 `bash ./sim/vsim_rtl_bash.sh <task_name> <other_parameters>` 

举例说明：

- 执行一次默认设置的写传输任务
  
  `bash ./sim/vsim_rtl_bash.sh one_write_defalut` 

- 执行一次默认设置的读传输任务
 
  `bash ./sim/vsim_rtl_bash.sh one_read_defalut` 

- 执行多次写传输任务，指定任务数量、APB 从设备的索引、APB 从设备响应最大延时

  `bash ./sim/vsim_rtl_bash.sh write 20 5 3`

  *注：该参数表示执行20次写任务，指定 APB 从设备的索引为5(范围0-11)，APB 从设备最大响应延时为3个时钟周期*

- 执行多次读传输任务，指定任务数量、APB 从设备的索引、APB 从设备响应最大延时

  `bash ./sim/vsim_rtl_bash.sh read 15 3 4`

  *注：该参数表示执行15次写任务，指定 APB 从设备的索引为3(范围0-11)，APB 从设备最大响应延时为4个时钟周期*

- 执行随机传输任务（随机 APB 从设备，随机读写方向），指定任务数量、APB 从设备响应最大延时

  `bash ./sim/vsim_rtl_bash.sh random 30 5`

  *注：该参数表示执行30次任务，APB 从设备最大响应延时为5个时钟周期*


 