
msg_order = {}

local version=1.0
--[[    天气插件
    ver1.0：
    仅支持国内城市，发送今明两天的天气。
    所调用的api源站为https://api.vvhan.com/，如果这一功能访问量大可以考虑去支持一下源站
]]

--对传入参数编码，兼容中文
function encodeURI(s) 
    s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    return string.gsub(s, " ", "+")
end

--在获取了数据的前提下，调用getWeather提取对应第x天的天气，返回拼接好的字符串
function getWeatherInfo(j,x)
    local info="【"..j.data.forecast[x].date.."】\n"
    info=info..j.data.forecast[x].type.."，"..j.data.forecast[x].high.."，"..j.data.forecast[x].low.."；"
    info=info..j.data.forecast[x].fengxiang..j.data.forecast[x].fengli
    return info
end

msg_order[".weather"]="weather"
function weather(msg)
    local rest = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",9)--匹配文本
    local api="https://api.vvhan.com/api/weather?city="
    local polar=""
    
    
    if(rest and #rest>0)then
        rest=encodeURI(rest)--编码
        polar=api..rest.."&type=week"--拼接
    else--空参，返回默认说明文字
        return"天气插件 ver"..version.."\n.weather 漠河   \\\\查询漠河天气\n当前版本仅支持国内城市"
    end
    
    json=require "json"
    res,data = http.get(polar)
    j=json.decode(data)
    
    --在兔兔的指导之下，写了更多的报错判断
    if(res==false) then
    return "api访问失败，当前版本"..version
    else
        if(j.desc~=nil) then --正常访问
            local info="『"..j.data.city.."』"..j.data.wendu.."℃"
            info=info..j.data.forecast[1].type.."\n"..getWeatherInfo(j,1).."\n"..getWeatherInfo(j,2)
            return info
        else --未查询到对应城市
            return "城市数据未记录"
        end
    end
end