msg_order = {}

function caihongpi(msg)
	chp_res,chp_data = http.get("https://chp.shadiao.app/api.php")
	return "{nick}，你要的彩虹屁来了：\n" .. chp_data
end
msg_order["夸我"] = "caihongpi"

function hitokoto(msg)
	htkt_res,htkt_data = http.get("https://api.ixiaowai.cn/ylapi/index.php")
	return "{nick}，你要的中二语录来了：\n" .. htkt_data
end
msg_order["中二生成"] = "hitokoto"

function dujitang(msg)
	djt_res,djt_data = http.get("https://du.shadiao.app/api.php")
	return "To {nick}：\n" .. djt_data
end
msg_order["毒鸡汤"] = "dujitang"

