msg_order = {}
--包含内容：翻译、星座运势、六十秒读世界
--其余内容由于本人看不上眼就不放了，芜湖

function xzys(msg)
	raw = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#xzys_order+1)
	if raw=="" then return "象棋的星座运势time~☆\n想不想知道自己的星座今天运势如何呢，发送“星座运势”后接自己的星座，我会告诉你答案哦~" end
	url = "https://api.iyk0.com/xzys/?msg=" .. encodeURI(raw)
	res,data = http.get(url)
	if data=="没有这个星座哦" then return data end
	json = require("json")
	j = json.decode(data)
	ret = string.gsub(string.gsub(j.data,":","\n"),";","\n")
	return ret
end
xzys_order = "星座运势"
msg_order[xzys_order] = "xzys"

function sixtysec(msg)
	url = "https://api.iyk0.com/60s/"
	res,data = http.get(url)
	json = require("json")
	j = json.decode(data)
	return "[CQ:image,url=" .. j.imageUrl .. "]\n注：新闻数据每天凌晨一点更新！"
end
msg_order["60秒读世界"] = "sixtysec"
msg_order["每日要闻"] = "sixtysec"