--以下为自定义部分

draw_msg="来张壁纸"
--自定义抽卡指令

draw_state="壁纸状态"

draw_everyday_max=500
--每日最大抽卡次数

msg_everyday_max="阿伟，你今天已经看了500张壁纸了，休息一下好不好！"
--超过最大抽卡次数回复

master_qq="2561360151"
--设置masterqq

kj_kind=2
--框架，先驱为1，Mirai为2

--以上为自定义部分
msg_order={}
function arknights_draw_main(msg)
  if(msg.fromMsg==draw_msg)then
    if(getUserToday(msg.fromQQ, "today_draw_max", 0)<=draw_everyday_max)then
      if(kj_kind==1)then
         kj_pic="[pic="
      else
         kj_pic="[CQ:image,url="
      end
      setUserToday(msg.fromQQ, "today_draw_max", getUserToday(msg.fromQQ, "today_draw_max", 0)+1)
      return kj_pic.."https://iw233.cn/API/Random.php?type=image]" --此处缺一个能用的api
    else
      return msg_everyday_max
    end
  else
   return ""
  end
end
function arknights_draw_state(msg)
   if(msg.fromQQ==master_qq)then
      return "管理员权限："..master_qq.."\n版本：v1.0".."\n每日最大色图次数："..draw_everyday_max.."\n签到指令：暂无\n寻访指令："..draw_msg
   else
      return "你不是寻访管理员"
   end
end

function arknights_draw_master(msg)
   if(msg.fromQQ==master_qq)then
      local user_qq=string.sub(msg.fromMsg,7,-1)
      setUserToday(user_qq, "today_draw_max", 0)
      return "成功重置了[CQ:at,qq="..user_qq.."]("..user_qq..")今日的使用次数"
   else
      return ""
   end
end
msg_order[draw_msg]="arknights_draw_main"
msg_order["壁纸重置"]="arknights_draw_master"
msg_order[draw_state]="arknights_draw_state"