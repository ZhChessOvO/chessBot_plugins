--[[ 
{\_/}     原插件：(Oliva系)漂流瓶2.0
(-ω-)     重写&mirai适配 by 兔兔(QQ:1142145792)
/ >❤     依据个人喜好，合并了扔瓶子与书写留言的步骤，原插件是让用户分两段发送的。
		  如果可以，请务必略读代码后进行使用。
		  默认取消了“捡起后删除漂流瓶”这一步骤，若需要可调整参数。
		  请先在plugin文件夹内新建bottle文件夹，并往里添加Dbottle_letter.txt空文本文档。
		  由于编码缘故，脚本不识别中文路径，请尽可能将骰子路径更改为仅含英文或数字。
		  v1.2更新日志：换了个小兔子颜文字。阅后即焚模式现在可以在自定义部分修改了。新增三项功能的每日次数上限。新增重置次数功能。其中，“跳进海里”一项并不影响查询数量的功能。
]]
msg_order = {}

--[[
可以获得的效果：
用户：扔漂流瓶凉拌海蜇皮
骰娘：（返回文本、在文件里记下某群某人的凉拌海蜇皮）
骰娘（到达上限时）：（返回不可再继续扔漂流瓶的内容）
用户：扔漂流瓶 （后面没有跟任何内容）
骰娘：（返回默认文本，这里是简短的插件介绍文本）
用户：捡漂流瓶
骰娘：（从文本中抽取一个返回，若有需要也可以将被抽取内容删除）
骰娘（到达上限时）：（返回不可再继续捡漂流瓶的内容）
骰娘（无瓶子时）：（返回没有瓶子时的提示）
用户：跳进海里
骰娘：（返回文本、在文件里记下某群某人某日跳海）
骰娘（到达上限时）：（返回不可再继续跳海的内容，正常反馈数字）
骰娘（无瓶子时）：（返回没有瓶子时的提示）
]]

-- 以下为可自定义部分

-- 扔出瓶子时的语句，默认为“扔漂流瓶”。使用例：【扔漂流瓶盐焗百合花】，会扔进去一个内容为“盐焗百合花”的漂流瓶
throw_bottle_order = "扔漂流瓶"

-- 捡瓶子的语句，默认为“捡漂流瓶”
pick_bottle_order = "捡漂流瓶"

-- 跳海，默认为“跳进海里”
drown_self_order = "跳进海里"

-- 重置漂流瓶全部次数，默认为“漂流瓶重置”。使用例：【漂流瓶重置1142145792】，会重置QQ号为1142145792的用户的扔、捡、跳海次数。
reset_order = "漂流瓶重置"

--捡起漂流瓶后直接销毁，1为开启
burn_after_read = 1

-- 每日扔瓶子的上限
DB_everyday_max_throw = 300

-- 每日捡瓶子的上限
DB_everyday_max_pick = 500

--每日跳海的上限
DB_everyday_max_drown = 1

-- 骰主的QQ号，请务必更改否则你的重置权限可就归兔兔了（
master_qq = "2561360151"

-- 在这里添加瓶子类型，做法与json牌堆类似，照着格式添加就行
bottle_type = {"啤酒瓶","塑料瓶","玻璃瓶","牛奶瓶","娃哈哈AD钙奶瓶","威士忌酒瓶","伏特加酒瓶","莫洛托夫鸡尾酒瓶","可乐瓶","宠物小精灵瓶","化妆瓶","葡萄酒瓶","安眠药瓶","止咳糖浆瓶","五粮液瓶","江小白瓶","梦境增强剂瓶","克莱因瓶"}

-- 以上为自定义部分



-- 以下为代码部分

random_bottle = bottle_type[math.random(#bottle_type)]-- 全局变量：随机瓶子类型，会在每次被调用时随机抽取
bottle_dir_path = getDiceDir().."\\plugin\\bottle\\"-- 全局变量：漂流瓶路径
save_bottle_text_name = "Dbottle_letter"..".txt"-- 全局变量：纸条名字
bottle_text_path = bottle_dir_path .. save_bottle_text_name-- 全局变量：纸条路径

-- 用于读文件
function read_file(path)
    local text = ""
    local file = io.open(path, "r") -- 打开了文件读写路径
    if (file ~= nil) then -- 如果文件不是空的
        text = file.read(file, "*a") -- 读取内容
        io.close(file) -- 关闭文件
    end 
    return text
end

-- 用于写文件
function write_file(path, text)
	file = io.open(path, "a") -- 以追加的方式
    file.write(file, text) -- 写入内容
    io.close(file) -- 关闭文件
end

-- 用于覆写文件
function overwrite_file(path, text)
	file = io.open(path, "w") -- 以只写的方式，会将原内容清空后写
	file.write(file, text)
	io.close(file)
end

-- 扔漂流瓶主程序
function throw_bottle(msg)
	-- 优先进行上限检定
	if ( getUserToday(msg.fromQQ,"DB_everyday_throw",0)>= DB_everyday_max_throw ) then
		return "[CQ:at,qq="..msg.fromQQ.."]今天已经扔了很多漂流瓶了，请不要造成海洋污染——\n（如果你真的很想继续的话，可以联系2561360151进行次数重置）"
		else
		local letter = string.match(msg.fromMsg,"[%s]*(.-)[%s]*$",#throw_bottle_order+1)
		-- 检测触发词后是否有剩余内容，如果只有触发词则返回帮助词条并跳出
		if ( #letter == 0 ) then
			return "简单漂流瓶\n输入“"..throw_bottle_order.."”后跟你想说的内容将留言投入大海！\n输入“"..pick_bottle_order.."”来获取他人的留言！\n输入“"..drown_self_order.."”来查看当前漂流瓶数量！"
		end
		-- 判定是群聊还是私聊，合并所需内容
		if ( msg.fromGroup == "0" ) then
			letter_full = "你在海边捡到了一个"..random_bottle.."，打开瓶子，里面有一张纸条，写着：\n"..letter.."\n【来自"..getUserConf(msg.fromQQ,"nick","某人").."("..msg.fromQQ..")悄悄留下的漂流瓶】c2xhc2g="
			else
			letter_full = "你在海边捡到了一个"..random_bottle.."，打开瓶子，里面有一张纸条，写着：\n"..letter.."\n【来自群："..getGroupConf(msg.fromGroup, "name", "获取群名参数错误！").."("..msg.fromGroup..")的"..getUserConf(msg.fromQQ,"nick","某人").."("..msg.fromQQ..")留下的漂流瓶】c2xhc2g="
		end
		-- 写入本地
		write_file(bottle_text_path,letter_full)
		-- 返回文本
		setUserToday(msg.fromQQ, "DB_everyday_throw", getUserToday(msg.fromQQ, "DB_everyday_throw", 0)+1)
		return "你将一个写着【"..letter.."】的纸条塞入瓶中扔进大海，希望有人捞到吧~"
	end
end
msg_order[throw_bottle_order] = "throw_bottle"
-- msg_order["丢漂流瓶"] = "throw_bottle"

-- 捡漂流瓶程序
function pick_bottle(msg)
	-- 优先进行上限判定
	if ( getUserToday(msg.fromQQ,"DB_everyday_pick",0)>= DB_everyday_max_pick ) then
		return "[CQ:at,qq="..msg.fromQQ.."]今天已经获取很多漂流瓶了。\n回忆虽然诱人，但也不得过量服用。"
		else
		local letter = read_file(bottle_text_path)
		local letter_list = {}
		-- 随机读取其中一条内容并发送
		if ( #letter == 0 ) then
			return "现在海里空无一物，不信你自己跳进海里看看~"
			else
			-- 以设定的特征字符串为分割，切割letter的内容，注意是分隔符前后各算一个所以最后的空内容会被计入，因此在调用的时候需要调整以避免调用到最后一个空值。分隔符这里使用的是base64加密后的单词“slash”，因为喜欢。
			letter_list = Split(letter,"c2xhc2g=") 
			n = ranint(1,#letter_list-1)
			letter_text = letter_list[n]
			
			-- 阅后即焚模式
			if ( burn_after_read == 1 ) then
				table.remove(letter_list,n)
				Dbottle_new = table.concat(letter_list,"c2xhc2g=")
				overwrite_file(bottle_text_path,Dbottle_new)
			end
			
			setUserToday(msg.fromQQ, "DB_everyday_pick", getUserToday(msg.fromQQ, "DB_everyday_pick", 0)+1)
			return letter_text
		end
	end

end
msg_order[pick_bottle_order] = "pick_bottle"
-- msg_order["捡漂流瓶"] = "pick_bottle"
-- msg_order["捞漂流瓶"] = "pick_bottle"

-- 跳海程序（会往海里添加一具尸体）
function bottle_num(msg)
	if ( getUserToday(msg.fromQQ,"DB_everyday_drown",0) >= DB_everyday_max_drown ) then
		local letter = read_file(bottle_text_path)
		local letter_list = {}
		letter_list = Split(letter,"c2xhc2g=") 
		return "温暖的海水包覆住你的身体……\n你放松全身，任由海浪推着你漂流，朦胧中好像看见".. #letter_list-1 .."道影子漂在远处。\n……\n转眼间你被推上原先所处的海岸，风浪一如既往，只有一团泡沫轻抚你的脸颊。"
		else
		local letter = read_file(bottle_text_path)
		local letter_list = {}
		letter_list = Split(letter,"c2xhc2g=") 
		date=os.date("%Y-%m-%d %H:%M:%S")
		if ( msg.fromGroup == "0" ) then
		text_full = "[CQ:image,url=http://q1.qlogo.cn/g?b=qq&nk="..msg.fromQQ.."&s=640]\n海面飘来了"..getUserConf(msg.fromQQ,"nick","某人").."的浮尸……\n他于"..date.."悄悄潜入深海……\n愿深蓝之意志保佑他的灵魂。c2xhc2g="
		else
		text_full = "[CQ:image,url=http://q1.qlogo.cn/g?b=qq&nk="..msg.fromQQ.."&s=640]\n海面飘来了"..getUserConf(msg.fromQQ,"nick","某人").."的浮尸……\n他于"..date.."在"..getGroupConf(msg.fromGroup, "name", "获取群名参数错误！").."("..msg.fromGroup..")处的海边沉入深海……c2xhc2g="
		end
		write_file(bottle_text_path,text_full)
		setUserToday(msg.fromQQ, "DB_everyday_drown", getUserToday(msg.fromQQ, "DB_everyday_drown", 0)+1)
		return "你缓缓走入大海，感受着海浪轻柔地拍打着你的小腿，膝盖……\n波浪卷着你的腰腹，你感觉有些把握不住平衡了……\n……\n你沉入海中，".. #letter_list-1 .."个物体与你一同沉浮。\n不知何处涌来一股暗流，你失去了意识。"
	end
end
msg_order[drown_self_order] = "bottle_num"
-- msg_order["跳入大海"] = "bottle_num"
-- msg_order["跳进大海"] = "bottle_num"

-- 次数重置
function DB_reset(msg)
	if ( msg.fromQQ == master_qq ) then
		local user_qq = string.match(msg.fromMsg,"[%s]*(.-)[%s]*$",#reset_order+1)
		setUserToday (user_qq,"DB_everyday_throw",0)
		setUserToday (user_qq,"DB_everyday_pick",0)
		setUserToday (user_qq,"DB_everyday_drown",0)
		return "成功重置了[CQ:at,qq="..user_qq.."]("..user_qq..")今日的使用次数"
		else
		return "你不是我的Master！你到底是谁！"
	end
end
msg_order[reset_order] = "DB_reset"

-- 随便从哪找来的字符串分割函数，来源： https://www.cnblogs.com/AaronBlogs/p/7615877.html 
function Split(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
	   if not nFindLastIndex then
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
		break
	   end
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	   nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end

-- 祝使用愉快。