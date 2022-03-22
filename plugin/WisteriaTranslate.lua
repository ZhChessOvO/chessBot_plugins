msg_order = {}

function encodeURI(s) --对传入参数编码，兼容中文
    s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    
    return string.gsub(s, " ", "+")
end

msg_order[".translate"]="translate"
function translate(msg)
    local rest = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",11)--匹配文本
    local api="http://fanyi.youdao.com/translate?&doctype=json&type=AUTO&i="
    local polar=""
    
    if(rest and #rest>0)then
        rest=encodeURI(rest)--编码
        polar=api..rest--拼接
    else--空参，返回默认说明文字
        return"ChessTranslate ver2.0 by ChessZH\n使用方法：.translate [翻译内容]，支持英日韩法俄西译中和中译英"
    end
    
    json=require "json"
    res,data = http.get(polar)
    j=json.decode(data)
    
    if(j.errorCode==0)then
        return j.translateResult[1][1].tgt
    else
        return "未找到对应翻译"
    --j=json.decode(data)
   end 
end