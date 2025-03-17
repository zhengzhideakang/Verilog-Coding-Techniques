/*
 * @Author      : Xu Xiaokang
 * @Email      :
 * @Date       : 2025-03-16 19:04:36
 * @LastEditors  : Xu Xiaokang
 * @LastEditTime : 2025-03-17 11:40:00
 * @Filename    :
 * @Description  : 三段式状态机模板——传统case语句
*/

module xxx
(
  input wire clk,
  input wire rstn
);


//++ 三段式状态机-状态定义与转移 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//~ 状态定义
enum logic [2:0] {
  IDLE = 3'd1 << 0, // 空闲态, 'h1
  WORK = 3'd1 << 1, // 工作态, 'h2
  DONE = 3'd1 << 2  // 结束态, 'h4
} state, next;

//~ 初始态与状态转移
always_ff @(posedge clk) begin
  if (~rstn)
    state <= IDLE;
  else
    state <= next;
end
//-- 三段式状态机-状态定义与转移  ------------------------------------------------------------


//++ 三段式状态机-状态判断 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
wire work_begin;
wire work_end;
logic done_end;

//~ 判断跳转到下一个状态的条件
always_comb begin
  next = state;
  unique case (state)
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
always_ff @(posedge clk) begin
  unique case (state)
    IDLE: done_end <= 0;
    WORK: ;
    DONE: done_end <= 1;
    default: done_end <= 1;
  endcase
end
//-- 三段式状态机-输出逻辑 ------------------------------------------------------------


endmodule