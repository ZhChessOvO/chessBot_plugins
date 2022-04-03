--感谢https://github.com/GardenHamster/GenshinPray项目，本项目提供开放API并对其lua化
--本脚本还非常简陋，期待能有大佬做出功能更多的版本，其中的api长期提供服务
msg_order = {}
function Arm_Pray_One(msg)
    url= "http://stardust.baimianxiao.cn/api/ArmPray/PrayOne?memberCode=" .. msg.fromQQ
    res,data = http.get(url)
    json = require("json")
    j = json.decode(data)
    if j.code~=0 then return "获取失败，请检查API服务器状态。" end
    image = "[CQ:image,url=" .. j.data.imgHttpUrl .. "]"
    return image
end
function Arm_Pray_Ten(msg)
    url= "http://stardust.baimianxiao.cn/api/ArmPray/PrayTen?memberCode=" .. msg.fromQQ
    res,data = http.get(url)
    json = require("json")
    j = json.decode(data)
    if j.code~=0 then return "获取失败，请检查API服务器状态。" end
    image = "[CQ:image,url=" .. j.data.imgHttpUrl .. "]"
    return image
end
function Perm_Pray_One(msg)
    url= "http://stardust.baimianxiao.cn/api/PermPray/PrayOne?memberCode=" .. msg.fromQQ
    res,data = http.get(url)
    json = require("json")
    j = json.decode(data)
    if j.code~=0 then return "获取失败，请检查API服务器状态。" end
    image = "[CQ:image,url=" .. j.data.imgHttpUrl .. "]"
    return image
end
function Perm_Pray_Ten(msg)
    url= "http://stardust.baimianxiao.cn/api/PermPray/PrayTen?memberCode=" .. msg.fromQQ
    res,data = http.get(url)
    json = require("json")
    j = json.decode(data)
    if j.code~=0 then return "获取失败，请检查API服务器状态。" end
    image = "[CQ:image,url=" .. j.data.imgHttpUrl .. "]"
    return image
end
function Role_Pray_One(msg)
    url= "http://stardust.baimianxiao.cn/api/RolePray/PrayOne?memberCode=" .. msg.fromQQ
    res,data = http.get(url)
    json = require("json")
    j = json.decode(data)
    if j.code~=0 then return "获取失败，请检查API服务器状态。" end
    image = "[CQ:image,url=" .. j.data.imgHttpUrl .. "]"
    return image
end
function Role_Pray_Ten(msg)
    url= "http://stardust.baimianxiao.cn/api/RolePray/PrayTen?memberCode=" .. msg.fromQQ
    res,data = http.get(url)
    json = require("json")
    j = json.decode(data)
    if j.code~=0 then return "获取失败，请检查API服务器状态。" end
    image = "[CQ:image,url=" .. j.data.imgHttpUrl .. "]"
    return image
end
msg_order["原神武器单抽"] = "Arm_Pray_One"
msg_order["原神武器十连"] = "Arm_Pray_Ten"
msg_order["原神常驻单抽"] = "Perm_Pray_One"
msg_order["原神常驻十连"] = "Perm_Pray_Ten"
msg_order["原神角色单抽"] = "Role_Pray_One"
msg_order["原神角色十连"] = "Role_Pray_Ten"