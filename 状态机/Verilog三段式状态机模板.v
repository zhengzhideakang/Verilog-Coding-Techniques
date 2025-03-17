/*
 * @Author       : Xu Xiaokang
 * @Email        :
 * @Date         : 2025-03-16 19:04:36
 * @LastEditors  : Xu Xiaokang
 * @LastEditTime : 2025-03-16 22:39:33
 * @Filename     :
 * @Description  : 三段式状态机模板——传统case语句
*/

module xxx
(
  input wire clk,
  input wire rstn
);


//++ 三段式状态机-状态定义与转移 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//~ 状态定义
localparam IDLE = 3'd1 << 0; // 空闲态, 'h1
localparam WORK = 3'd1 << 1; // 工作态, 'h2
localparam DONE = 3'd1 << 2; // 结束态, 'h4

reg [2:0] state, next;
//~ 初始态与状态转移
always @(posedge clk) begin
  if (~rstn)
    state <= IDLE;
  else
    state <= next;
end
//-- 三段式状态机-状态定义与转移  ------------------------------------------------------------


//++ 三段式状态机-状态判断 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
wire work_begin;
wire work_end;
reg  done_end;

//~ 判断跳转到下一个状态的条件
always @(*) begin
  next = state;
  case (state)
    IDLE: if (work_begin)
            next = WORK;
    WORK: if (work_end)
            next = DONE;
    DONE: if (done_end)
            next = IDLE;
    default: next = IDLE;
  endcase
end
//-- 三段式状态机-状态转移 ------------------------------------------------------------


//++ 三段式状态机-输出逻辑 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
always @(posedge clk) begin
  case (state)
    IDLE: done_end <= 0;
    WORK: ;
    DONE: done_end <= 1;
    default: done_end <= 1;
  endcase
end
//-- 三段式状态机-输出逻辑 ------------------------------------------------------------


endmodule