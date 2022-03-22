msg_order = {}

function encodeURI(s) --对传入参数编码。天知道我因为没编码在中文歌曲搜索上卡了多久
    s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    
    return string.gsub(s, " ", "")--接口问题，理论上应该把空格换为+才行
end

msg_order[".music"]="getMusic"
function getMusic(msg)--点歌函数本体
    local rest = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",7)--从传过来的指令匹配歌名
    local api="https://api.iyk0.com/wymusic/?msg="
    local polar=""
    
    if(rest and #rest>0)then
        rest=encodeURI(rest)--编码
        polar=api..rest.."&n=1"--拼接
    else--空参，返回默认说明文字
        return"WisteriaMusic by ChessZH ver 1.0\n.music [歌名] //获取所点歌曲"
    end
    
    json=require "json"
    res,data = http.get(polar)--访问api获取点歌所得信息
    local j=json.decode(data)
    
    if(j.song) then--若找到了这首歌
    local songname=j.song
    local singername=j.singer
    local img=j.img
    local songurl=j.url
    
    return "[CQ:xml,data=<?xml version='1.0' encoding='UTF-8' standalone='yes' ?><msg serviceID=\"2\" templateID=\"1\" action=\"web\" brief=\"&#91;♫&#93;"..songname.."\" sourceMsgId=\"0\" url=\""..songurl.."\" flag=\"0\" adverSign=\"0\" multiMsgFlag=\"0\" ><item layout=\"2\"><audio cover=\""..img.."\" src=\""..songurl.."\" /><title>"..songname.."</title><summary>"..singername.."</summary></item></msg>]"
    else
        return "象棋将唱片拖入了空间的缝隙中，未搜到您所想要的歌曲"
    end
    
end