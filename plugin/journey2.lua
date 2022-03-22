msg_order = {}

function new(msg)
--新建角色
local userday = getUserConf(msg.fromQQ, "总旅行次数", 0)
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local userlevel = getUserConf(msg.fromQQ, "等级", 0)
local userexp = getUserConf(msg.fromQQ, "经验", 0)
local userexp = getUserConf(msg.fromQQ, "dingtimes", 0)
local userfavor = getUserConf(msg.fromQQ, "世界亲和度", 0)
local userfood = getUserConf(msg.fromQQ, "食物", 0)
local date=os.date("%H%M")
 setUserConf(msg.fromQQ, "旅行日历", date)
 setUserConf(msg.fromQQ, "总旅行次数", 0)
 setUserConf(msg.fromQQ, "世界亲和度", 0)
 setUserConf(msg.fromQQ, "金币",200)
 setUserConf(msg.fromQQ, "食物",0)
setUserConf(msg.fromQQ, "等级",1)
setUserConf(msg.fromQQ, "经验",0)
 setUserConf(msg.fromQQ, "世界亲和度", getUserConf(msg.fromQQ, "世界亲和度", 0)+1)
setUserToday(msg.fromQQ, "dingtimes", 0)
return "新建旅行者{nick}成功。"
end

--旅行系统
function anotherworld(msg)
local userday = getUserConf(msg.fromQQ, "总旅行次数", 0)
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local userlevel = getUserConf(msg.fromQQ, "等级", 0)
local userexp = getUserConf(msg.fromQQ, "经验", 0)
local userfavor = getUserConf(msg.fromQQ, "世界亲和度", 0)
local userfood = getUserConf(msg.fromQQ, "食物", 0)
local date=os.date("%H%M")
local num=ranint(70, 90)
local a=num

if(userfood >=a) then
   setUserConf(msg.fromQQ, "旅行日历", date)
   setUserConf(msg.fromQQ, "总旅行次数", getUserConf(msg.fromQQ, "总旅行次数", 0)+1)
   setUserConf(msg.fromQQ, "经验", getUserConf(msg.fromQQ, "经验", 0)+150)
   setUserConf(msg.fromQQ, "世界亲和度", getUserConf(msg.fromQQ, "世界亲和度", 0)+ranint(0, 7)) 
   setUserConf(msg.fromQQ, "食物", getUserConf(msg.fromQQ, "食物", 0)-a) 
   local userTotalCheck = getUserConf(msg.fromQQ,"总旅行次数",0)
   local userComboCheck = getUserConf(msg.fromQQ,"世界亲和度",0)

   local userComboCheck = getUserConf(msg.fromQQ,"食物",0)
   return "旅行者{nick}这次旅行来到了世界一角，并在这品尝到了美味的地方小吃，获得了150经验，消耗了"..a.."食物"

else
   return "旅行者{nick}，请准备好充足的食物再出发吧~"


 end
end

--购物系统
function buy(msg)
local userday = getUserConf(msg.fromQQ, "总旅行次数", 0)
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local userfavor = getUserConf(msg.fromQQ, "世界亲和度", 0)
local userfood = getUserConf(msg.fromQQ, "食物", 0)
local ccc=ranint(170, 200)
local num=ranint(100, 170)
local mum=ranint(80, 120)
local a = mum
if(usermoney >=a) then
local b = num
  setUserConf(msg.fromQQ, "食物", getUserConf(msg.fromQQ, "食物", 0)+b) 
   setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)-a)
  return "旅行者{nick}在花了"..a.."金币在商店进行了购物，买到了"..ccc.."食物，在缴纳了部分税款后，一共获得了"..b.."食物."
else
   return "旅行者{nick}，请带够钱再来购物哦"

 end
end

--打工系统
function dagong(msg)
local num=ranint(120, 200)
local mum=ranint(150, 230)
local ccc=ranint(230, 250)
local a = num
local b = mum
local userlevel = getUserConf(msg.fromQQ, "等级", 0)
local userexp = getUserConf(msg.fromQQ, "经验", 0)
local userday = getUserConf(msg.fromQQ, "总旅行次数", 0)
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local userfavor = getUserConf(msg.fromQQ, "世界亲和度", 0)
local userfood = getUserConf(msg.fromQQ, "食物", 0)
local ding_limit = 10
local today_ding = getUserToday(msg.fromQQ,"dingtimes",0)
    if(today_ding>=ding_limit)then
        return"今日已达到打工次数上限了哦~"
    end
    today_ding = today_ding + 1
    setUserToday(msg.fromQQ, "dingtimes", today_ding)

if(userfavor>= 50) then
  setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)+b)
return "旅行者{nick}在当地完成了打工，获得了"..ccc.."金币工资，在缴纳了一部分税款后，一共获得了"..b.."金币"

else
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)+a)
setUserConf(msg.fromQQ, "经验", getUserConf(msg.fromQQ, "经验", 0)+60)
return "旅行者{nick}在当地完成了打工，获得了"..ccc.."金币工资和60经验，在缴纳了一部分税款后，一共获得了"..a.."金币"
 end
end

msg_order["新建旅行者"] = "new"
msg_order["旅行"] = "anotherworld"
msg_order["购物"] = "buy"
msg_order["打工"] = "dagong"

--查询系统
function chaxun(msg)
local userday = getUserConf(msg.fromQQ, "总旅行次数", 0)
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local userfavor = getUserConf(msg.fromQQ, "世界亲和度", 0)
local userfood = getUserConf(msg.fromQQ, "食物", 0)
local userlevel = getUserConf(msg.fromQQ, "等级", 0)
local userexp = getUserConf(msg.fromQQ, "经验", 0)
local date=os.date("%H%M")
return "旅行者{nick}的等级为"..userlevel.."，拥有"..userexp.."经验，一共旅行了"..userday.."次，拥有"..userfood.."食物和"..usermoney.."金币，世界亲和度为"..userfavor.."，世界期待你的旅行~"
end
msg_order["旅行查询"] = "chaxun"

--查询他人系统
function chaxuna(msg)
local QQ=string.match(msg.fromMsg,"[%s]*%[CQ:at,qq=(%d*)%]",#msg_order+1)
local userday = getUserConf(QQ, "总旅行次数", 0)
local usermoney = getUserConf(QQ, "金币", 0)
local userfavor = getUserConf(QQ, "世界亲和度", 0)
local userfood = getUserConf(QQ, "食物", 0)
local userlevel = getUserConf(QQ, "等级", 0)
local userexp = getUserConf(QQ, "经验", 0)
local date=os.date("%H%M")
return "旅行者"..QQ.."的等级为"..userlevel.."，拥有"..userexp.."经验，一共旅行了"..userday.."次，拥有"..userfood.."食物和"..usermoney.."金币，世界亲和度为"..userfavor.."，世界期待你的旅行~"
end
msg_order["查询"] = "chaxuna"

--打劫系统
function qiangjie(msg)
local userday = getUserConf(msg.fromQQ, "总旅行次数", 0)
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local userfavor = getUserConf(msg.fromQQ, "世界亲和度", 0)
local userfood = getUserConf(msg.fromQQ, "食物", 0)
local dajiecishu = getUserConf(msg.fromQQ, "打劫", 0)
local date=os.date("%H%M")
local num=ranint(120, 200)
local mum=ranint(1, 10)
local ccc=ranint(3, 9)
local a = num

if(dajiecishu <=ranint(3, 100)) then
 setUserConf(msg.fromQQ, "世界亲和度", getUserConf(msg.fromQQ, "世界亲和度", 0)-mum)
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)+a)
setUserConf(msg.fromQQ, "打劫", getUserConf(msg.fromQQ, "打劫", 0)+1)
return "旅行者{nick}成功从商店打劫到了"..a.."金币。"
else
 setUserConf(msg.fromQQ, "世界亲和度", 0)
 setUserConf(msg.fromQQ, "金币",0)
 setUserConf(msg.fromQQ, "食物",0)
setUserConf(msg.fromQQ, "打劫", 0)
return "旅行者{nick}打劫的时候被抓起来啦，金币食物都被没收啦~"
end
end
msg_order["打劫"] = "qiangjie"

--开启旅行
function yishijiehelp(msg)
return"亲爱的{nick}，欢迎加入旅行者协会，按照下列提示开启游戏：\n[新建旅行者]    建立一个全新的旅者角色（注意：新建旅者会导致曾经的旅者无法找回。）\n[旅行] 进行旅行，不过请注意，旅行需要消耗食物，食物不足将无法旅行\n[购物] 在商店进行购物，花费金币获得食物\n[打工] 在当地进行打工，获得金币 \n[竞技场] 匹配其他挑战者并进行战斗\n[决斗@QQ] 与指定群友进行决斗\n[打劫] 在商店进行打劫，获得金币，但会损失世界亲和度，某些时候打劫到的东西还会进不到你的口袋\n[抢劫@QQ]对指定玩家进行抢劫\n[贷款]在银行进行贷款，但请注意负债过多有惩罚\n[还贷][大额还款]可以使用货币偿还债务，并获取经验 \n[旅行查询] 查询你的旅行者信息\n[查询@QQ]查询指定玩家的信息\n[每日委托]进行每日委托，等级越高，委托奖励越高\n[赌局]开启赌局\n值得注意的是，这个世界存在税款机制，你所购买、打工得到的东西不会全额进入你的口袋，每次税率皆为随机且不会告知。"
end
msg_order["旅行帮助"] = "yishijiehelp"

--升级系统
function shengji(msg)
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local userlevel = getUserConf(msg.fromQQ, "等级", 0)
local userexp = getUserConf(msg.fromQQ, "经验", 0)
local userfavor = getUserConf(msg.fromQQ, "世界亲和度", 0)
local paya = getUserConf(msg.fromQQ, "等级", 0)*1000
local middle = getUserConf(msg.fromQQ, "世界亲和度", 0)*1
local payb = paya - middle
local payc = getUserConf(msg.fromQQ, "等级", 0)*1000

if(userexp>=payc)then
setUserConf(msg.fromQQ, "等级", getUserConf(msg.fromQQ, "等级", 0)+1)
setUserConf(msg.fromQQ, "经验", getUserConf(msg.fromQQ, "金币", 0)-payc)
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)-payb)
return"旅行者{nick}花费"..payb.."金币和"..payc.."经验完成了升级，等级+1"

else if(usermoney<=payb)then
return"您的货币不足，请攒足货币再来升级~"

else
return"您的货币不足，请攒足货币再来升级~"
  end
 end
end
msg_order["升级"] = "shengji"

function shengjix(msg)
--升级查询
local paya = getUserConf(msg.fromQQ, "等级", 0)*1000
local middle = getUserConf(msg.fromQQ, "世界亲和度", 0)*1
local userlevel = getUserConf(msg.fromQQ, "等级", 0)
local payb = paya - middle
local payc = getUserConf(msg.fromQQ, "等级", 0)*1000
return"旅行者{nick}现在是等级"..userlevel..",升至下一级需要花费"..payb.."金币和"..payc.."经验。"
end
msg_order["升级查询"] = "shengjix"

--战斗系统
function battle(msg)
local a = ranint(1, 50)
local userlevel = getUserConf(msg.fromQQ, "等级", 0)
local userexp = getUserConf(msg.fromQQ, "经验", 0)
local c = ranint(0, 100)+userlevel
local d = ranint(0, 85)+(a*0.5)
if(c>=d)then
setUserConf(msg.fromQQ, "经验", getUserConf(msg.fromQQ, "经验", 0)+a)
return"旅行者{nick}在世界竞技场中匹配到了一个等级"..a.."的对手，一番战斗之后，成功将其击败。获得经验"..a..""
else
return"旅行者{nick}在世界竞技场中匹配到了一个等级"..a.."的对手，一番艰苦的战斗后，你被其击败。"
 end
end
msg_order["竞技场"] = "battle"

--重置打工次数
function reload(msg)
local today_ding = getUserToday(msg.fromQQ,"dingtimes",0)
local jiaban = getUserToday(msg.fromQQ,"加班次数",0)
if(jiaban<=3)then
setUserToday(msg.fromQQ, "加班次数", getUserToday(msg.fromQQ, "加班次数", 0)+1)
setUserToday(msg.fromQQ, "dingtimes", 0)
return"旅行者{nick}进行加班，打工次数限制+10"
else
return"{nick}今天已经加了太多次班了，请好好休息哦~"
 end
end
msg_order["加班"] = "reload"

--每日委托
function weituos(msg)
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local today_weituo = getUserToday(msg.fromQQ,"今日委托",0)
local userlevel = getUserConf(msg.fromQQ, "等级", 0)
local userexp = getUserConf(msg.fromQQ, "经验", 0)
local limit = 4
local f=ranint(1, 3)
local a =userlevel+f
local b = a
local c = b*50
local d = b*30

--委托未上限
if(today_weituo<=limit) then
setUserToday(msg.fromQQ, "今日委托", getUserToday(msg.fromQQ, "今日委托", 0)+1)
setUserConf(msg.fromQQ, "经验", getUserConf(msg.fromQQ, "经验", 0)+c)
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)+d)
return"旅行者{nick}完成了等级"..a.."的委托，获得"..c.."经验和"..d.."金币"
else
return"旅行者{nick}今天完成的委托次数已达上限，请明天再来"
  end
end
msg_order["每日委托"] = "weituos"

--金币赌桌
function dubo(msg)
local userlevel = getUserConf(msg.fromQQ, "等级", 0)
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local userfavor = getUserConf(msg.fromQQ, "世界亲和度", 0)
local a=ranint(1, 6)
local b=ranint(1, 6)
local c=a
local d=b
local middle = userlevel+userfavor
local f = middle*0.01
local g = f+b
local h =usermoney*0.5
if (usermoney<=0)then
return"你没有足够的金币参加赌局"
else if(c>g)then
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)-h)
return"很遗憾，{nick}在赌桌上赌输了，失去了所有的赌注，共计"..h.."金币"
else
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)+h)
return"恭喜{nick}在赌桌上赌赢了对手，获得了对手所有的赌注，共计"..h.."金币"
end
end
end
msg_order["金币赌桌"] = "dubo"


--食物赌桌
function dubos(msg)
local userlevel = getUserConf(msg.fromQQ, "等级", 0)
local userfood = getUserConf(msg.fromQQ, "食物", 0)
local userfavor = getUserConf(msg.fromQQ, "世界亲和度", 0)
local a=ranint(1, 6)
local b=ranint(1, 6)
local c=a
local d=b
local middle = userlevel+userfavor
local f = middle*0.01
local g = f+b
local h =userfood*0.5
if (userfood<=0)then
return"你没有足够的食物参加赌局"
else if(c>g)then
setUserConf(msg.fromQQ, "食物", getUserConf(msg.fromQQ, "食物", 0)-h)
return"很遗憾，{nick}在赌桌上赌输了，失去了所有的赌注，共计"..h.."食物"
else
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)+h)
return"恭喜{nick}在赌桌上赌赢了对手，获得了对手所有的赌注，共计"..h.."食物"
end
end
end
msg_order["食物赌桌"] = "dubos"

--赌局说明
function dubosm(msg)
return"欢迎来到世界赌场，请按对应指令开启赌桌\n[金币赌桌]使用一半金币作为赌注进行博弈\n[食物赌桌]使用一半食物作为赌注进行博弈\n赌桌上不设税款，但具体能获得多少，谁也说不准"
end
msg_order["赌局"] = "dubosm"

--pvp
function pvp(msg)
local QQ=string.match(msg.fromMsg,"[%s]*%[CQ:at,qq=(%d*)%]",#msg_order+1)
local userlevel = getUserConf(msg.fromQQ, "等级", 0)
local targetlevel = getUserConf(QQ, "等级", 0)
local a = ranint(1, 100)+userlevel
local b = a
local c = ranint(1, 100)+targetlevel
local d = c
local f = a-c
local g = c-a
if(b>=d)then
setUserConf(msg.fromQQ, "经验", getUserConf(msg.fromQQ, "经验", 0)+f)
return"旅行者{nick}对"..QQ.."发起挑战，以等级"..b.."的攻击与"..d.."的攻击进行了战斗，成功击败了目标，获得"..f.."经验"
else
setUserConf(QQ, "经验", getUserConf(msg.fromQQ, "经验", 0)+g)
return"旅行者{nick}对"..QQ.."发起挑战，以等级"..b.."的攻击与"..d.."的攻击进行了战斗，被目标击败了，目标获得"..g.."经验"
 end
end
msg_order["决斗"] = "pvp"

function pvpdajie(msg)
local QQ=string.match(msg.fromMsg,"[%s]*%[CQ:at,qq=(%d*)%]",#msg_order+1)
local userlevel = getUserConf(msg.fromQQ, "等级", 0)
local targetlevel = getUserConf(QQ, "等级", 0)
local a = ranint(1, 100)+userlevel
local b = a
local c = ranint(1, 100)+targetlevel
local d = c
local h = ranint(1,150)
local f = h
local g = h
if(b>=d)then
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)+f)
setUserConf(QQ, "金币", getUserConf(msg.fromQQ, "金币", 0)-f)
return"旅行者{nick}对"..QQ.."进行打劫，以等级"..b.."的攻击与"..d.."的攻击进行了战斗，成功击败了目标，获得"..f.."金币"
else
setUserConf(QQ, "金币", getUserConf(msg.fromQQ, "金币", 0)+g)
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)-g)
return"旅行者{nick}对"..QQ.."进行打劫，以等级"..b.."的攻击与"..d.."的攻击进行了战斗，被目标击败了，目标抢走了你的"..g.."金币"
 end
end
msg_order["抢劫"] = "pvpdajie"

function daikuanjinbi(msg)
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local userzhaiwu_jinbi = getUserConf(msg.fromQQ, "金币债务", 0)
local userlevel=getUserConf(msg.fromQQ, "等级", 0)
local limit = userlevel*2000
local a = ranint(100,300)
local b = a
if(usermoney>=0) then
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)+b)
setUserConf(msg.fromQQ, "金币债务", getUserConf(msg.fromQQ, "金币债务", 0)+b)
return"{nick}在银行贷款得到了"..b.."金币"

 else if(userzhaiwu_jinbi>=limit)then
setUserConf(msg.fromQQ, "金币债务", 0)
setUserConf(msg.fromQQ, "等级", getUserConf(msg.fromQQ, "等级", 0)-1)
return"{nick}在银行借款过多且未还款，被银行进行强制还款，等级-1，债务清空"

else
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local f=0-usermoney
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)+f)
setUserConf(msg.fromQQ, "金币债务", getUserConf(msg.fromQQ, "金币债务", 0)+f)
return"{nick}在银行贷款得到了"..f.."金币"
   end
  end
 end
msg_order["贷款"] = "daikuanjinbi"

function huandai(msg)
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local userzhaiwu_jinbi = getUserConf(msg.fromQQ, "金币债务", 0)
local userexp=getUserConf(msg.fromQQ, "经验", 0)

if(userzhaiwu_jinbi>=100) then
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)-100)
setUserConf(msg.fromQQ, "金币债务", getUserConf(msg.fromQQ, "金币债务", 0)-100)
setUserConf(msg.fromQQ, "经验", getUserConf(msg.fromQQ, "经验", 0)+100)
return"{nick}在银行花费金币100完成部分还款，银行奖励经验100"

else
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local userzhaiwu_jinbi = getUserConf(msg.fromQQ, "金币债务", 0)
local userexp=getUserConf(msg.fromQQ, "经验", 0)
local a = userzhaiwu_jinbi 
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)-a)
setUserConf(msg.fromQQ, "金币债务", getUserConf(msg.fromQQ, "金币债务", 0)-a)
setUserConf(msg.fromQQ, "经验", getUserConf(msg.fromQQ, "经验", 0)+a)
return"{nick}在银行花费金币"..a.."完成还款，银行奖励经验"..a..""
end
end
msg_order["还贷"] = "huandai"

function huandaia(msg)
local usermoney = getUserConf(msg.fromQQ, "金币", 0)
local userzhaiwu_jinbi = getUserConf(msg.fromQQ, "金币债务", 0)
local userexp=getUserConf(msg.fromQQ, "经验", 0)
local a = 1000
if(a>userzhaiwu_jinbi) then
return"旅行者{nick}并不需要还这么多债务哦"
else
setUserConf(msg.fromQQ, "金币", getUserConf(msg.fromQQ, "金币", 0)-a)
setUserConf(msg.fromQQ, "金币债务", getUserConf(msg.fromQQ, "金币债务", 0)-a)
setUserConf(msg.fromQQ, "经验", getUserConf(msg.fromQQ, "经验", 0)+a)
return"{nick}在银行花费金币"..a.."完成还款，银行奖励经验"..a..""
 end
end
msg_order["大额还款"] = "huandaia"
