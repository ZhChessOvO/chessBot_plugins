msg_order={}

KingGame_path = getDiceDir().."\\plugin\\data\\KingGamePlayer.txt"

-- 用于读文件，参数为文件路径
function read_file(path)
    local text = ""
    local file = io.open(path, "r") -- 打开了文件读写路径，以读取的方式
    if (file ~= nil) then -- 如果文件不是空的
        text = file.read(file, "*a") -- 读取内容
        io.close(file) -- 关闭文件
    end 
    return text -- 返回读取的内容
end

-- 用于写文件，参数为路径和需要写入的文本
function write_file(path, text)
	file = io.open(path, "a") -- 以追加的方式
    file.write(file, text) -- 写入内容
    io.close(file) -- 关闭文件
end

-- 用于覆写文件，参数与写文件相同
function overwrite_file(path, text)
	file = io.open(path, "w") -- 以只写的方式，会将原内容清空后写
	file.write(file, text)
	io.close(file)
end


--用于获取整数
function intostring(num)
    if(num==nil)then
        return ""
    end
    return string.format("%.0f",num)
end


--启动游戏
function KingGame(msg)
	if(msg.fromGroup == 0)then --如果在私聊中，发送此回执
	  return "请在群聊中进行游戏哦"
	  end
	local letter = read_file(KingGame_path) -- 读取
	json = require("json")
	local Group = msg.fromGroup --读取群号

	if #letter==0 then -- 如果是空的
		j = {} -- 初始化表“j”
		j.KingGamePlayer = {} -- 初始化数组“j.KingGamePlayer”
	else
		j = json.decode(letter) -- 否则进行解码
	end

	--群游戏记录表初始化
	 j.KingGamePlayer[Group]={} --初始化数组group
	 j.KingGamePlayer[Group]["start"] = 1 --游戏开始
	 j.KingGamePlayer[Group]["player1"] = {} --初始化表player1
	 j.KingGamePlayer[Group]["player2"] = {} --初始化表player2
	 j.KingGamePlayer[Group]["wait"] = {}
	letter_full = json.encode(j) -- 编码
	overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	sendMsg("游戏已经开始。{br}【国王游戏】清除玩家列表重启游戏。{br}【加入国王游戏】加入游戏。{br}【国王游戏开始】指定K。{br}【退出国王游戏】退出游戏。{br}【国王游戏结束】结束游戏。",msg.fromGroup, msg.fromQQ)
	return  
end
msg_order["国王游戏"]="KingGame"

--加入游戏
function KingGameJoin(msg)
	if(msg.fromGroup == 0)then --如果在私聊中，发送此回执
	  return 
	  end
	local letter = read_file(KingGame_path) -- 读取
	json = require("json")
	local Group = msg.fromGroup --读取群号
	j = json.decode(letter) 
	if (j.KingGamePlayer[Group]["start"] == nil )then 
	return "游戏未开始。"
	end
	if (j.KingGamePlayer[Group]["start"] == 1 )then 
	 QQ = msg.fromQQ
	 num = #j.KingGamePlayer[Group]["player1"] --已有玩家总数
	 --检查玩家是否已经加入
	 for i=1, num do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["player1"][num].qq == QQ )then
	 return "您已经在游戏中。"
	 end
     end  
	 --保存新玩家
	 num = num + 1
	 j.KingGamePlayer[Group]["player1"][num] = {} -- 初始化所在数组索引的表
	 j.KingGamePlayer[Group]["player1"][num].name = getUserConf(msg.fromQQ,"nick","")--保存名字
	 j.KingGamePlayer[Group]["player1"][num].qq = msg.fromQQ --保存qq
	letter_full = json.encode(j) -- 编码
	overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	sendMsg(getUserConf(msg.fromQQ,"nick","").."加入游戏，当前有【"..intostring(num).."】名玩家。{br}所有玩家加入后，发送【国王游戏开始】指定K。",msg.fromGroup, msg.fromQQ)
	return
	end

	if (j.KingGamePlayer[Group]["start"] == 2 )then 
	 QQ = msg.fromQQ
	 num = #j.KingGamePlayer[Group]["player2"] --已有玩家总数
	 --检查玩家是否已经加入
	 for i=1, num do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["player2"][num].qq == QQ )then
	 return "您已经在游戏中。"
	 end
     end  
	 wait = #j.KingGamePlayer[Group]["wait"] --排队玩家数
	 for i=1, wait do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["wait"][wait].qq == QQ )then
	 return "您已经在排队中。"
	 end
     end  
	 --保存新玩家
	 wait = wait + 1
	 j.KingGamePlayer[Group]["wait"][wait] = {} -- 初始化所在数组索引的表
	 j.KingGamePlayer[Group]["wait"][wait].name = getUserConf(msg.fromQQ,"nick","")--保存名字
	 j.KingGamePlayer[Group]["wait"][wait].qq = msg.fromQQ --保存qq
	letter_full = json.encode(j) -- 编码
	overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	sendMsg(getUserConf(msg.fromQQ,"nick","").."加入游戏，当前有【"..intostring(wait).."】名玩家在等待中。{br}当发送【再来一局】时，排队玩家将加入游戏。",msg.fromGroup, msg.fromQQ)
	return
	end
	
	if (j.KingGamePlayer[Group]["start"] == 3 )then 
	 QQ = msg.fromQQ
	 num = #j.KingGamePlayer[Group]["player2"] --已有玩家总数
	 --检查玩家是否已经加入
	 for i=1, num do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["player2"][num].qq == QQ )then
	 return "您已经在游戏中。"
	 end
     end  
	 wait = #j.KingGamePlayer[Group]["wait"] --排队玩家数
	 for i=1, wait do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["wait"][wait].qq == QQ )then
	 return "您已经在排队中。"
	 end
     end  
	 --保存新玩家
	 wait = wait + 1
	 j.KingGamePlayer[Group]["wait"][wait] = {} -- 初始化所在数组索引的表
	 j.KingGamePlayer[Group]["wait"][wait].name = getUserConf(msg.fromQQ,"nick","")--保存名字
	 j.KingGamePlayer[Group]["wait"][wait].qq = msg.fromQQ --保存qq
	letter_full = json.encode(j) -- 编码
	overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	sendMsg(getUserConf(msg.fromQQ,"nick","").."加入游戏，当前有【"..intostring(num).."】名玩家在等待中。{br}当发送【再来一局】时，排队玩家将加入游戏。",msg.fromGroup, msg.fromQQ)
	return
	end
	
	if (j.KingGamePlayer[Group]["start"] == 4 )then 
	 QQ = msg.fromQQ
	 num = #j.KingGamePlayer[Group]["player1"] --已有玩家总数
	 --检查玩家是否已经加入
	 for i=1, num do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["player1"][num].qq == QQ )then
	 return "您已经在游戏中。"
	 end
     end  
	 wait = #j.KingGamePlayer[Group]["wait"] --排队玩家数
	 for i=1, wait do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["wait"][wait].qq == QQ )then
	 return "您已经在排队中。"
	 end
     end  
	 --保存新玩家
	 wait = wait + 1
	 j.KingGamePlayer[Group]["wait"][wait] = {} -- 初始化所在数组索引的表
	 j.KingGamePlayer[Group]["wait"][wait].name = getUserConf(msg.fromQQ,"nick","")--保存名字
	 j.KingGamePlayer[Group]["wait"][wait].qq = msg.fromQQ --保存qq
	letter_full = json.encode(j) -- 编码
	overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	sendMsg(getUserConf(msg.fromQQ,"nick","").."加入游戏，当前有【"..intostring(num).."】名玩家在等待中。{br}当发送【再来一局】时，排队玩家将加入游戏。",msg.fromGroup, msg.fromQQ)
	return
	end
	
	if (j.KingGamePlayer[Group]["start"] == 5 )then 
	 QQ = msg.fromQQ
	 num = #j.KingGamePlayer[Group]["player1"] --已有玩家总数
	 --检查玩家是否已经加入
	 for i=1, num do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["player1"][num].qq == QQ )then
	 return "您已经在游戏中。"
	 end
     end  
	 wait = #j.KingGamePlayer[Group]["wait"] --排队玩家数
	 for i=1, wait do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["wait"][wait].qq == QQ )then
	 return "您已经在排队中。"
	 end
     end  
	 --保存新玩家
	 wait = wait + 1
	 j.KingGamePlayer[Group]["wait"][wait] = {} -- 初始化所在数组索引的表
	 j.KingGamePlayer[Group]["wait"][wait].name = getUserConf(msg.fromQQ,"nick","")--保存名字
	 j.KingGamePlayer[Group]["wait"][wait].qq = msg.fromQQ --保存qq
	letter_full = json.encode(j) -- 编码
	overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	sendMsg(getUserConf(msg.fromQQ,"nick","").."加入游戏，当前有【"..intostring(num).."】名玩家在等待中。{br}当发送【再来一局】时，排队玩家将加入游戏。",msg.fromGroup, msg.fromQQ)
	return
	end
end
msg_order["加入国王游戏"]="KingGameJoin"

--游戏退出
function KingGameExit(msg)
	if(msg.fromGroup == 0)then --如果在私聊中，发送此回执
	  return 
	  end
	local letter = read_file(KingGame_path) -- 读取
	json = require("json")
	local Group = msg.fromGroup --读取群号
	j = json.decode(letter) 
	if (j.KingGamePlayer[Group]["start"] == nil )then 
	return "游戏未开始。"
	end

	QQ = msg.fromQQ
	wait =  #j.KingGamePlayer[Group]["wait"]
	for i=1, wait do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["wait"][i].qq == QQ )then
	 --清除玩家
	 table.remove(j.KingGamePlayer[Group]["wait"],i)--删除
	 letter_full = json.encode(j) -- 编码
	 overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	 return "{nick}退出等待。"
	 end
     end  

	if(j.KingGamePlayer[Group]["start"] == 1)then
	num = #j.KingGamePlayer[Group]["player1"] --已有玩家总数
	for i=1, num do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["player1"][i].qq == QQ )then
	 --清除玩家
	 table.remove(j.KingGamePlayer[Group]["player1"],i)--删除
	 letter_full = json.encode(j) -- 编码
	 overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	 num=num - 1
	 return "{nick}退出游戏，当前有【"..num.."】位玩家。"
	 end
     end  
	 end

	if(j.KingGamePlayer[Group]["start"] == 4)then
	num = #j.KingGamePlayer[Group]["player1"] --已有玩家总数
	for i=1, num do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["player1"][i].qq == QQ )then
	 --清除玩家
	 table.remove(j.KingGamePlayer[Group]["player1"],i)--删除
	 letter_full = json.encode(j) -- 编码
	 overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	 num=num - 1
	 return "{nick}退出游戏，当前有【"..num.."】位玩家。"
	 end
     end  
	 end

	 if(j.KingGamePlayer[Group]["start"] == 5)then
	 num = #j.KingGamePlayer[Group]["player1"] --已有玩家总数
	for i=1, num do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["player1"][i].qq == QQ )then
	 --清除玩家
	 table.remove(j.KingGamePlayer[Group]["player1"],i)--删除
	 letter_full = json.encode(j) -- 编码
	 overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	 num=num - 1
	 return "{nick}退出游戏，当前有【"..num.."】位玩家。"
	 end
     end  
	 end

	 if(j.KingGamePlayer[Group]["start"] == 2)then
	 num = #j.KingGamePlayer[Group]["player2"] --已有玩家总数
	for i=1, num do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["player2"][i].qq == QQ )then
	 --清除玩家
	 table.remove(j.KingGamePlayer[Group]["player2"],i)--删除
	 letter_full = json.encode(j) -- 编码
	 overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	 num=num - 1
	 return "{nick}退出游戏，当前有【"..num.."】位玩家。"
	 end
     end  
	 end

	if(j.KingGamePlayer[Group]["start"] == 3)then
	num = #j.KingGamePlayer[Group]["player2"] --已有玩家总数
	for i=1, num do	--表示i初始值为1，每次循环+1，大于num时停止循环，相当于执行num次
     if (j.KingGamePlayer[Group]["player2"][i].qq == QQ )then
	 --清除玩家
	 table.remove(j.KingGamePlayer[Group]["player2"],i)--删除
	 letter_full = json.encode(j) -- 编码
	 overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	 num=num - 1
	 return "{nick}退出游戏，当前有【"..num.."】位玩家。"
	 end
     end  
	 end

	 return "您尚未加入游戏。"

end
msg_order["退出国王游戏"]="KingGameExit"

--游戏开始
function KingGameStart(msg)
	if(msg.fromGroup == 0)then --如果在私聊中，发送此回执
	  return 
	  end
	local letter = read_file(KingGame_path) -- 读取
	json = require("json")
	local Group = msg.fromGroup --读取群号
	j = json.decode(letter) 
	if (j.KingGamePlayer[Group]["start"] == nil )then 
	return "游戏未开始。"
	end

	if (j.KingGamePlayer[Group]["start"] > 1)then --游戏进程判定
	return "游戏已经在进行中。"
	end

	if (j.KingGamePlayer[Group]["start"] == 1)then --游戏进程判定
	 length = #j.KingGamePlayer[Group]["player1"]
	 if(length < 3)then 
	 return "人数太少，等待新玩家加入。"
	 end
	 j.KingGamePlayer[Group]["start"] = 2
	 --生成随机数，记录为K
	 ram = ranint(1, length)
	 j.KingGamePlayer[Group]["K"] = ram
	 --在playe2里生成随机列表
	 i = 1
	 while(length > 0) do	--条件为真则继续循环，相当于执行cnt_dice次
     ram = ranint(1,length)--生成随机数
	 j.KingGamePlayer[Group]["player2"][i] = j.KingGamePlayer[Group]["player1"][ram]
	 table.remove(j.KingGamePlayer[Group]["player1"],ram)--删除
	 length = #j.KingGamePlayer[Group]["player1"]
	 i = i + 1
     end  
	 sleepTime(600)
	 letter_full = json.encode(j) -- 编码
	 overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	 num = j.KingGamePlayer[Group]["K"]
	 KingQQ = j.KingGamePlayer[Group]["player2"][num].qq
	 length =# j.KingGamePlayer[Group]["player2"]
	 sendMsg("当前有【"..intostring(length).."】名玩家在游戏中。{br}本局游戏的K是[CQ:at,id="..KingQQ.."]。{br}请K在命令结束后发送【编号列表】显示参与玩家编号。{br}忘了谁是K可发送【谁是K】查询。",msg.fromGroup, msg.fromQQ)
	 return
	end
end
msg_order["国王游戏开始"]="KingGameStart"

--K揭示
function KingGameKing(msg)
	if(msg.fromGroup == 0)then --如果在私聊中，发送此回执
	  return 
	  end
	local letter = read_file(KingGame_path) -- 读取
	json = require("json")
	local Group = msg.fromGroup --读取群号
	j = json.decode(letter) 
	if (j.KingGamePlayer[Group]["start"] == nil )then 
	return "游戏未开始。"
	end

	if ( j.KingGamePlayer[Group]["start"] == 2)then --游戏进程判定
	 num = j.KingGamePlayer[Group]["K"]
	 KingQQ = j.KingGamePlayer[Group]["player2"][num].qq
	 length =# j.KingGamePlayer[Group]["player2"]
	 sendMsg("当前有【"..intostring(length).."】名玩家在游戏中。{br}本局游戏的K是[CQ:at,id="..KingQQ.."]。{br}请K在命令结束后发送【编号列表】显示参与玩家编号。{br}忘了谁是K可发送【谁是K】查询。",msg.fromGroup, msg.fromQQ)
	 end

	if ( j.KingGamePlayer[Group]["start"] == 4)then --游戏进程判定
	 num = j.KingGamePlayer[Group]["K"]
	 KingQQ = j.KingGamePlayer[Group]["player1"][num].qq
	 length =# j.KingGamePlayer[Group]["player1"]
	 sendMsg("当前有【"..intostring(length).."】名玩家在游戏中。{br}本局游戏的K是[CQ:at,id="..KingQQ.."]。{br}请K在命令结束后发送【编号列表】显示参与玩家编号。{br}忘了谁是K可发送【谁是K】查询。",msg.fromGroup, msg.fromQQ)
	 end
end
msg_order["谁是K"]="KingGameKing"

--人员编号列表展示
function KingGameList(msg)
	if(msg.fromGroup == 0)then --如果在私聊中，发送此回执
	  return 
	  end
	local letter = read_file(KingGame_path) -- 读取
	json = require("json")
	local Group = msg.fromGroup --读取群号
	j = json.decode(letter) 
	if (j.KingGamePlayer[Group]["start"] == nil )then 
	return "游戏未开始。"
	end

	if (j.KingGamePlayer[Group]["start"] == 2)then --游戏进程判定
	  num = j.KingGamePlayer[Group]["K"]
	  KingQQ = j.KingGamePlayer[Group]["player2"][num].qq --获取Kqq号
	 if(msg.fromQQ == KingQQ)then
	  j.KingGamePlayer[Group]["start"] = 3
	  local i = 1
	  local length =  #j.KingGamePlayer[Group]["player2"]
	  local text = ""
	  repeat--循环输出列表
	  text = text..intostring(i)..".【"..j.KingGamePlayer[Group]["player2"][i].name.."】{br}"
	  i=i+1
	  until(i>length)--条件为真则跳出循环
   	  letter_full = json.encode(j) -- 编码
	  overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	  return text.."{br}现在起，任何人发送【编号列表】都能查编号。{br}想保持当前玩家再来一局，请发送【再来一局】。"
	 else
	 return "请由K发送【编号列表】指令。"
	 end
	end

	if (j.KingGamePlayer[Group]["start"] == 3)then --游戏进程判定
	  local i = 1
	  local length =  #j.KingGamePlayer[Group]["player2"]
	  local text = ""
	  repeat--循环输出列表
	  text = text..intostring(i)..".【"..j.KingGamePlayer[Group]["player2"][i].name.."】{br}"
	  i=i+1
	  until(i>length)--条件为真则跳出循环
   	  letter_full = json.encode(j) -- 编码
	  overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	  return text.."{br}发送【编号列表】查询本局编号。{br}想保持当前玩家再来一局，请发送【再来一局】。"
	end
	
	if (j.KingGamePlayer[Group]["start"] == 4)then --游戏进程判定
	  num = j.KingGamePlayer[Group]["K"]
	  KingQQ = j.KingGamePlayer[Group]["player1"][num].qq --获取Kqq号
	 if(msg.fromQQ == KingQQ)then
	  j.KingGamePlayer[Group]["start"] = 5
	  local i = 1
	  local length =  #j.KingGamePlayer[Group]["player1"]
	  local text = ""
	  repeat--循环输出列表
	  text = text..intostring(i)..".【"..j.KingGamePlayer[Group]["player1"][i].name.."】{br}"
	  i=i+1
	  until(i>length)--条件为真则跳出循环
   	  letter_full = json.encode(j) -- 编码
	  overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	  return text.."{br}现在起，任何人发送【编号列表】都能查编号。{br}想保持当前玩家再来一局，请发送【再来一局】。"
	 else
	 return "请由K发送【编号列表】指令。"
	 end
	end

	if (j.KingGamePlayer[Group]["start"] == 5)then --游戏进程判定
	  local i = 1
	  local length =  #j.KingGamePlayer[Group]["player1"]
	  local text = ""
	  repeat--循环输出列表
	  text = text..intostring(i)..".【"..j.KingGamePlayer[Group]["player1"][i].name.."】{br}"
	  i=i+1
	  until(i>length)--条件为真则跳出循环
   	  letter_full = json.encode(j) -- 编码
	  overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	  return text.."{br}发送【编号列表】查询本局编号。{br}想保持当前玩家再来一局，请发送【再来一局】。"
	end
end
msg_order["编号列表"]="KingGameList"

--再来一局，默认参与玩家不变
function KingGameReset(msg)
	if(msg.fromGroup == 0)then --如果在私聊中，发送此回执
	  return 
	  end
	local letter = read_file(KingGame_path) -- 读取
	json = require("json")
	local Group = msg.fromGroup --读取群号
	j = json.decode(letter) 
	if (j.KingGamePlayer[Group]["start"] == nil )then 
	return "游戏未开始。"
	end

	if (j.KingGamePlayer[Group]["start"] == 5)then --游戏进程判定
	 wait = #j.KingGamePlayer[Group]["wait"] --排队玩家加入列表
	 num = #j.KingGamePlayer[Group]["player1"] +1
	 for i=1,wait do
	 j.KingGamePlayer[Group]["player1"][num]=j.KingGamePlayer[Group]["wait"][1]
	 table.remove(j.KingGamePlayer[Group]["wait"],1)--删除
	 num= num+1
	 end
	  letter_full = json.encode(j) -- 编码
	  overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	 length =  #j.KingGamePlayer[Group]["player1"] 
	 if(length < 3)then 
	 return "人数太少，等待新玩家加入。"
	 end
	 j.KingGamePlayer[Group]["start"] = 2
	 --生成随机数，记录为K
	 ram = ranint(1, length)
	 j.KingGamePlayer[Group]["K"] = ram
	 --在playe2里生成随机列表
	 i = 1
	 while(length > 0) do	--条件为真则继续循环，相当于执行cnt_dice次
     ram = ranint(1,length)--生成随机数
	 j.KingGamePlayer[Group]["player2"][i] = j.KingGamePlayer[Group]["player1"][ram]
	 table.remove(j.KingGamePlayer[Group]["player1"],ram)--删除
	 length = #j.KingGamePlayer[Group]["player1"]
	 i = i + 1
     end  
	 sleepTime(600)
	 letter_full = json.encode(j) -- 编码
	 overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	 num = j.KingGamePlayer[Group]["K"]
	 KingQQ = j.KingGamePlayer[Group]["player2"][num].qq
	 length =# j.KingGamePlayer[Group]["player2"]
	 sendMsg("当前有【"..intostring(length).."】名玩家在游戏中。{br}本局游戏的K是[CQ:at,id="..KingQQ.."]。{br}请K在命令结束后发送【编号列表】显示参与玩家编号。{br}忘了谁是K可发送【谁是K】查询。",msg.fromGroup, msg.fromQQ)
	 return
	end
	
	if (j.KingGamePlayer[Group]["start"] == 3)then --游戏进程判定
	 wait = #j.KingGamePlayer[Group]["wait"] --排队玩家数
	 num = #j.KingGamePlayer[Group]["player2"] +1
	 for i=1,wait do
	 j.KingGamePlayer[Group]["player2"][num]=j.KingGamePlayer[Group]["wait"][1]
	 table.remove(j.KingGamePlayer[Group]["wait"],1)--删除
	 num= num+1
	 end
	  letter_full = json.encode(j) -- 编码
	  overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	 length =  #j.KingGamePlayer[Group]["player2"] 
	 if(length < 3)then 
	 return "人数太少，等待新玩家加入。"
	 end	 
	 j.KingGamePlayer[Group]["start"] = 4
	 --生成随机数，记录为K
	 ram = ranint(1, length)
	 j.KingGamePlayer[Group]["K"] = ram
	 --在playe2里生成随机列表
	 i = 1
	 while(length > 0) do	--条件为真则继续循环，相当于执行cnt_dice次
     ram = ranint(1,length)--生成随机数
	 j.KingGamePlayer[Group]["player1"][i] = j.KingGamePlayer[Group]["player2"][ram]
	 table.remove(j.KingGamePlayer[Group]["player2"],ram)--删除
	 length = #j.KingGamePlayer[Group]["player2"]
	 i = i + 1
     end  
	 sleepTime(600)
	 letter_full = json.encode(j) -- 编码
	 overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	 num = j.KingGamePlayer[Group]["K"]
	 KingQQ = j.KingGamePlayer[Group]["player1"][num].qq
	 length =# j.KingGamePlayer[Group]["player1"]
	 sendMsg("当前有【"..intostring(length).."】名玩家在游戏中。{br}本局游戏的K是[CQ:at,id="..KingQQ.."]。{br}请K在命令结束后发送【编号列表】显示参与玩家编号。{br}忘了谁是K可发送【谁是K】查询。",msg.fromGroup, msg.fromQQ)
	 return
	end

end
msg_order["再来一局"]="KingGameReset"

--游戏结束
function KingGameEnd(msg)
	if(msg.fromGroup == 0)then --如果在私聊中，发送此回执
	  return 
	  end
	local letter = read_file(KingGame_path) -- 读取
	json = require("json")
	local Group = msg.fromGroup --读取群号
	j = json.decode(letter) 
	if (j.KingGamePlayer[Group]["start"] == nil )then 
	return "开始都没开始，结束什么。"
	end

	 j.KingGamePlayer[Group]={}
	 letter_full = json.encode(j) -- 编码
	 overwrite_file(KingGame_path,letter_full) -- 覆写文件，由于JSON有特定格式因此无法使用追加写入
	 return "本群游戏已结束。"
end
msg_order["国王游戏结束"]="KingGameEnd"
