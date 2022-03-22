--[[ 
{\_/}     感谢SocialSisterYi的API收集项目，终于通过一个官方API搞定一切内容
(-ω-)     项目地址：https://github.com/SocialSisterYi/bilibili-API-collect
/ >❤     Dice! 脚本 by 兔兔(1142145792)
]]

msg_order = {}

function bili_BV(msg)
	raw = string.match(msg.fromMsg,"BV[A-Za-z0-9]*")
	if #raw==2 then return "" end
	url = "https://api.bilibili.com/x/web-interface/view?bvid=" .. raw
	res,data = http.get(url)
	json = require("json")
	j = json.decode(data)
	if j.code~=0 then return "获取失败！难道视频被吞入黑洞了？！" end
	title = j.data.title
	picture = "[CQ:image,url=" .. j.data.pic .. "]"
	describe = j.data.desc
	view = j.data.stat.view
	danmaku = j.data.stat.danmaku
	like = j.data.stat.like
	coin = j.data.stat.coin
	favorite = j.data.stat.favorite
	share = j.data.stat.share
	author = j.data.owner.name
	hrank = j.data.stat.his_rank
	pubdate = os.date("%Y-%m-%d %H:%M:%S",j.data.pubdate)
	if hrank~=0 then
		return picture .. "\n" .. title .. "\n" .. view .. "播放 · 总弹幕数" .. danmaku .. "   " .. pubdate .. "  全站排行榜最高第" .. hrank .. "名\n点赞" .. like .. " 投币" .. coin .. " 收藏" .. favorite .. " 转发" .. share .. "\n作者：" .. author .. "\n描述：\n" .. describe .. "\n\n链接：https://www.bilibili.com/video/" .. raw
	else
		return picture .. "\n" .. title .. "\n" .. view .. "播放 · 总弹幕数" .. danmaku .. "   " .. pubdate.. "\n点赞" .. like .. " 投币" .. coin .. " 收藏" .. favorite .. " 转发" .. share .. "\n作者：" .. author .. "\n描述：\n" .. describe .. "\n\n链接：https://www.bilibili.com/video/" .. raw
	end
end
msg_order["BV"] = "bili_BV"
msg_order["https://www.bilibili.com/video/BV"] = "bili_BV"
msg_order["http://www.bilibili.com/video/BV"] = "bili_BV"
msg_order["www.bilibili.com/video/BV"] = "bili_BV"
msg_order["bilibili.com/video/BV"] = "bili_BV"

function bili_av(msg)
	raw = string.match(msg.fromMsg,"av[0-9]*")
	if #raw==2 then return "" end
	url = "https://api.bilibili.com/x/web-interface/view?aid=" .. raw
	res,data = http.get(url)
	json = require("json")
	j = json.decode(data)
	if j.code~=0 then return "获取失败！难道视频被吞入黑洞了？！" end
	title = j.data.title
	picture = "[CQ:image,url=" .. j.data.pic .. "]"
	describe = j.data.desc
	view = j.data.stats.view
	danmaku = j.data.stats.danmaku
	like = j.data.stats.like
	coin = j.data.stats.coin
	favorite = j.data.stats.favorite
	share = j.data.stats.share
	author = j.data.owner.name
	hrank = j.data.stats.his_rank
	if hrank~=0 then
		return picture .. "\n" .. title .. "\n" .. view .. "播放 · 总弹幕数" .. danmaku .. "   " .. pubdate .. "  全站排行榜最高第" .. hrank .. "名\n点赞" .. like .. " 投币" .. coin .. " 收藏" .. favorite .. " 转发" .. share .. "\n作者：" .. author .. "\n描述：\n" .. describe .. "\n\n链接：https://www.bilibili.com/video/" .. raw
	else
		return picture .. "\n" .. title .. "\n" .. view .. "播放 · 总弹幕数" .. danmaku .. "   " .. pubdate.. "\n点赞" .. like .. " 投币" .. coin .. " 收藏" .. favorite .. " 转发" .. share .. "\n作者：" .. author .. "\n描述：\n" .. describe .. "\n\n链接：https://www.bilibili.com/video/" .. raw
	end
end
msg_order["av"] = "bili_av"
msg_order["https://www.bilibili.com/video/av"] = "bili_av"
msg_order["http://www.bilibili.com/video/av"] = "bili_av"
msg_order["www.bilibili.com/video/av"] = "bili_av"
msg_order["bilibili.com/video/av"] = "bili_av"
