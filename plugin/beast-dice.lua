msg_order = {}
-- 加密第一步，字符转16进制unicode的4位数字
function str2hex(str)
    local ret = ""
    for p, c in utf8.codes(str) do
        local charHexStr = string.sub(string.format("%#x", c), 3, -1)
        if string.len(charHexStr) == 3 then
            charHexStr = "0" .. charHexStr
        elseif string.len(charHexStr) == 2 then
            charHexStr = "00" .. charHexStr
        elseif string.len(charHexStr) == 1 then --解决了换行无法正常转换的问题
            charHexStr = "000" .. charHexStr
        end
        ret = ret .. charHexStr
    end
    return ret
end

-- 加密第二步，对字符串进行二次加密
function OwO(str)
    -- 兽语
    beast = {"嗷", "呜", "啊", "~"}
    local hex = str2hex(str)
    local code = ""
    local n = 0
    for p, c in utf8.codes(hex) do -- p是序号，c是内容
        -- print("c:"..c..",n:"..n)
        local k = tonumber(tostring(utf8.char(c)), 16) + math.fmod(n, 16)
        if k >= 16 then
            k = k - 16
        end
        q = math.floor(k / 4) + 1
        p = math.fmod(k, 4) + 1
        -- print("q="..q..",p="..p)
        code = code .. beast[q] .. beast[p]
        n = n + 1
        ---print("k="..k.."  code="..code)
    end
    return (beast[4] .. beast[2] .. beast[1] .. code .. beast[3])
end


-- 解密第一步，将兽语转换为16进制unicode字符串
function human(str)
    -- 兽语(没有思路怎么截取中文字符串来自定义词典)
    beast = {
        ["嗷"] = "1",
        ["呜"] = "2",
        ["啊"] = "3",
        ["~"] = "4"
    }
    local aouwa = string.sub(str, 8, -4)
    ret = ""
    t = 0
    i = 0
    for p, c in utf8.codes(aouwa) do
        if i == 0 then
            pos1 = beast[utf8.char(c)] -1
            i = 1
            t = t + 1
        else
            pos2 = beast[utf8.char(c)] -1
            i = 0
            t = t + 1
            code = (pos1 * 4 + pos2) - math.fmod((t-2) / 2, 16)
            if code < 0 then
                code = code + 16
            end
            code = string.format("%#x", math.floor(code))
            if code == "0" then
                ret = ret .. code
            else
                ret = ret .. string.sub(code, 3, 3)
            end
        end

    end
    return (ret)
end

-- 解密第二步，将unicode字符串恢复为文本
function hex2str(str)
	hexArray = human(str)
    local ret = ""
    local i = 1
    while (i <= string.len(hexArray)) do
        charStr = utf8.char(tonumber(string.sub(hexArray, i, i + 3), 16))
        ret = ret .. charStr
        i = i + 4
    end
    return (ret)
end

-- 判断是否是兽语
function isAouwa(str)
	a = 1
	b = str2hex(str)
	while (a < #b) do
		c = string.sub(b,a,a+3)
		if (not(c=="554a" or c=="55f7" or c=="545c" or c=="007e")) then
			return false
		end
		a = a + 4
	end
	return true
end

-- QQ机器人相关的function
function beast(msg)
return "象棋帮{nick}加密如下：\n"..OwO(string.sub(msg.fromMsg,7,-1))
end

function renhua(msg)
	local detector = string.match(msg.fromMsg,"[%s]*(.-)[%s]*$",1)
	b = isAouwa(detector)
	if b then
		return "{nick}解密如下：\n"..hex2str(msg.fromMsg)
	else
		return "这可不像是象棋的密语呢，你确定没讲错吗？"
	end
end

msg_order["加密"] = "beast"
msg_order["~呜嗷"] = "renhua"