--一个石头剪刀布脚本 写这个是因为懒得.deck（
--作者 ChessZH
--版本 v1.0
--更新日期 20211012
msg_order = {}
--备忘录：1是剪刀2是石头3是布
self_win = "\n嘿嘿，是{self}赢啦~"
self_lose = "\n什什什..什么？！{self}竟然输了..."
self_fair = "\n是平局呢~再来一局吧！"



function sci(msg)
local self_choice = ranint(1, 3)
  if(self_choice == 1)then
      return "{self}出剪刀！"..self_fair
  elseif(self_choice == 2)then
      return "{self}出石头！"..self_win
  elseif(self_choice == 3)then
      return "{self}出布！"..self_lose
 end
end

msg_order["我出剪刀"] = "sci"



function rock(msg)
local self_choice = ranint(1, 3)
  if(self_choice == 1)then
      return "{self}出剪刀！"..self_lose
  elseif(self_choice == 2)then
      return "{self}出石头！"..self_fair
  elseif(self_choice == 3)then
      return "{self}出布！"..self_win
 end
end

msg_order["我出石头"] = "rock"



function pie(msg)
local self_choice = ranint(1, 3)
  if(self_choice == 1)then
      return "{self}出剪刀！"..self_win
  elseif(self_choice == 2)then
      return "{self}出石头！"..self_lose
  elseif(self_choice == 3)then
      return "{self}出布！"..self_fair
 end
end

msg_order["我出布"] = "pie"  



function rspInfo(msg)
  return "来石头剪刀布吧~\n发送 我出石头/剪刀/布 来和{self}比划比划吧~"
end
  
msg_order["玩石头剪刀布"] = "rspInfo"