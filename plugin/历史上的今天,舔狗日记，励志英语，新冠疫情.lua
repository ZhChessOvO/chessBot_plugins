msg_order = {}

function lishishangdejintian(msg)
	lishi_res,lishi_data = http.get("http://api.weijieyue.cn/api/lsjt/api.php")
	return "历史上的今天：\n" .. lishi_data
end
msg_order["历史上的今天"] = "lishishangdejintian"


function lizhiyingyu(msg)
	res,info=http.get("https://api.vvhan.com/api/en?type=sj")
    js = require "json" --调用第三方库
    j = js.decode(info)
	return "To {nick}：\n"..j.data.zh.."("..j.data.en..")"
end
msg_order["励志英语"] = "lizhiyingyu"

function covid(msg)
	res,info=http.get("https://interface.sina.cn/news/wap/fymap2020_data.d.json")
    js = require "json" --调用第三方库
    j = js.decode(info)
    return "统计数据截至日期:"..j.data.mtime.."\n累计确诊:"..j.data.gntotal.."例\n累计死亡:"..j.data.deathtotal.."例\n累计治愈:"..j.data.curetotal.."例\n有病例城市个数:"..j.data.sustotal
end
msg_order["新冠疫情"] = "covid" --半成品待补充

function house(msg)
    doge_res,dog_data = http.get("http://api.weijieyue.cn/api/tgrj/api.php")
	return dog_data
end
msg_order["舔狗日记"] = "house"
