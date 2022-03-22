--[[ 
{\_/}		参考：狗屁不通文章生成器网页版(https://suulnnka.github.io/BullshitGenerator/index.html) Github(https://github.com/menzi11/BullshitGenerator)
(-ω-)		脚本制作 by 兔兔(1142145792)
/ >❤ 		本是作为http库试验项目的一部分，结果发现不能调用不说，里面的东西其实贼简单……所以干脆另开一个脚本全部搬运过来了。
]]
msg_order = {}


--以下为可自定义部分

--群聊中限制的字符数量，不推荐过长，具体长度还请酌情考虑
BSG_group_limit = 800

--私聊中限制的字符数量，QQ的最大单次发送消息限制字符数量为5000，由于生成时的数量会略微超过设定数量，推荐设定在4900以下
BSG_private_limit = 4000

--以上为可自定义部分

function FamousGenerator()
	--前面垫话
	before = {
		"曾经说过",
		"在不经意间这样说过",
		"说过一句著名的话",
		"曾经提到过",
		"说过一句富有哲理的话"
	}
	random_before = before[math.random(#before)]
	--后面垫话
	after = {
		"这不禁令我深思。",
		"带着这句话, 我们还要更加慎重的审视这个问题：",
		"这启发了我。",
		"我希望诸位也能好好地体会这句话。",
		"这句话语虽然很短, 但令我浮想联翩。",
		"这句话看似简单，但其中的阴郁不禁让人深思。",
		"这句话把我们带到了一个新的维度去思考这个问题：",
		"这似乎解答了我的疑惑。"
	}
	random_after = after[math.random(#after)]
	--名人名言
	famous = {
		"爱迪生" .. random_before .. "，天才是百分之一的勤奋加百分之九十九的汗水。" .. random_after,
		"查尔斯·史" .. random_before .. "，一个人几乎可以在任何他怀有无限热忱的事情上成功。" .. random_after,
		"培根说过，深窥自己的心，而后发觉一切的奇迹在你自己。" .. random_after,
		"歌德曾经" .. random_before .. "，流水在碰到底处时才会释放活力。" .. random_after,
		"莎士比亚" .. random_before .. "，那脑袋里的智慧，就像打火石里的火花一样，不去打它是不肯出来的。" .. random_after,
		"戴尔·卡耐基" .. random_before .. "，多数人都拥有自己不了解的能力和机会，都有可能做到未曾梦想的事情。" .. random_after,
		"白哲特" .. random_before .. "，坚强的信念能赢得强者的心，并使他们变得更坚强。" .. random_after,
		"伏尔泰" .. random_before .. ", 不经巨大的困难，不会有伟大的事业。" .. random_after,
		"富勒曾经" .. random_before .. ", 苦难磨炼一些人，也毁灭另一些人。" .. random_after,
		"文森特·皮尔" .. random_before .. ", 改变你的想法，你就改变了自己的世界。" .. random_after,
		"拿破仑·希尔" .. random_before .. ", 不要等待，时机永远不会恰到好处。" .. random_after,
		"塞涅卡" .. random_before .. ", 生命如同寓言，其价值不在与长短，而在与内容。" .. random_after,
		"奥普拉·温弗瑞" .. random_before .. ", 你相信什么，你就成为什么样的人。" .. random_after,
		"吕凯特" .. random_before .. ", 生命不可能有两次，但许多人连一次也不善于度过。" .. random_after,
		"莎士比亚" .. random_before .. ", 人的一生是短的，但如果卑劣地过这一生，就太长了。" .. random_after,
		"笛卡儿" .. random_before .. ", 我的努力求学没有得到别的好处，只不过是愈来愈发觉自己的无知。" .. random_after,
		"左拉" .. random_before .. ", 生活的道路一旦选定，就要勇敢地走到底，决不回头。" .. random_after,
		"米歇潘" .. random_before .. ", 生命是一条艰险的峡谷，只有勇敢的人才能通过。" .. random_after,
		"吉姆·罗恩" .. random_before .. ", 要么你主宰生活，要么你被生活主宰。" .. random_after,
		"日本谚语" .. random_before .. ", 不幸可能成为通向幸福的桥梁。" .. random_after,
		"海贝尔" .. random_before .. ", 人生就是学校。在那里，与其说好的教师是幸福，不如说好的教师是不幸。" .. random_after,
		"杰纳勒尔·乔治·S·巴顿" .. random_before .. ", 接受挑战，就可以享受胜利的喜悦。" .. random_after,
		"德谟克利特" .. random_before .. ", 节制使快乐增加并使享受加强。" .. random_after,
		"裴斯泰洛齐" .. random_before .. ", 今天应做的事没有做，明天再早也是耽误了。" .. random_after,
		"歌德" .. random_before .. ", 决定一个人的一生，以及整个命运的，只是一瞬之间。" .. random_after,
		"卡耐基" .. random_before .. ", 一个不注意小事情的人，永远不会成就大事业。" .. random_after,
		"卢梭" .. random_before .. ", 浪费时间是一桩大罪过。" .. random_after,
		"康德" .. random_before .. ", 既然我已经踏上这条道路，那么，任何东西都不应妨碍我沿着这条路走下去。" .. random_after,
		"克劳斯·莫瑟爵士" .. random_before .. ", 教育需要花费钱，而无知也是一样。" .. random_after,
		"伏尔泰" .. random_before .. ", 坚持意志伟大的事业需要始终不渝的精神。" .. random_after,
		"亚伯拉罕·林肯" .. random_before .. ", 你活了多少岁不算什么，重要的是你是如何度过这些岁月的。" .. random_after,
		"韩非" .. random_before .. ", 内外相应，言行相称。" .. random_after,
		"富兰克林" .. random_before .. ", 你热爱生命吗？那么别浪费时间，因为时间是组成生命的材料。" .. random_after,
		"马尔顿" .. random_before .. ", 坚强的信心，能使平凡的人做出惊人的事业。" .. random_after,
		"笛卡儿" .. random_before .. ", 读一切好书，就是和许多高尚的人谈话。" .. random_after,
		"塞涅卡" .. random_before .. ", 真正的人生，只有在经过艰难卓绝的斗争之后才能实现。" .. random_after,
		"易卜生" .. random_before .. ", 伟大的事业，需要决心，能力，组织和责任感。" .. random_after,
		"歌德" .. random_before .. ", 没有人事先了解自己到底有多大的力量，直到他试过以后才知道。" .. random_after,
		"达尔文" .. random_before .. ", 敢于浪费哪怕一个钟头时间的人，说明他还不懂得珍惜生命的全部价值。" .. random_after,
		"佚名" .. random_before .. ", 感激每一个新的挑战，因为它会锻造你的意志和品格。" .. random_after,
		"奥斯特洛夫斯基" .. random_before .. ", 共同的事业，共同的斗争，可以使人们产生忍受一切的力量。　" .. random_after,
		"苏轼" .. random_before .. ", 古之立大事者，不惟有超世之才，亦必有坚忍不拔之志。" .. random_after,
		"王阳明" .. random_before .. ", 故立志者，为学之心也；为学者，立志之事也。" .. random_after,
		"歌德" .. random_before .. ", 读一本好书，就如同和一个高尚的人在交谈。" .. random_after,
		"乌申斯基" .. random_before .. ", 学习是劳动，是充满思想的劳动。" .. random_after,
		"别林斯基" .. random_before .. ", 好的书籍是最贵重的珍宝。" .. random_after,
		"富兰克林" .. random_before .. ", 读书是易事，思索是难事，但两者缺一，便全无用处。" .. random_after,
		"鲁巴金" .. random_before .. ", 读书是在别人思想的帮助下，建立起自己的思想。" .. random_after,
		"培根" .. random_before .. ", 合理安排时间，就等于节约时间。" .. random_after,
		"屠格涅夫" .. random_before .. ", 你想成为幸福的人吗？但愿你首先学会吃得起苦。" .. random_after,
		"莎士比亚" .. random_before .. ", 抛弃时间的人，时间也抛弃他。" .. random_after,
		"叔本华" .. random_before .. ", 普通人只想到如何度过时间，有才能的人设法利用时间。" .. random_after,
		"博" .. random_before .. ", 一次失败，只是证明我们成功的决心还够坚强。 维" .. random_after,
		"拉罗什夫科" .. random_before .. ", 取得成就时坚持不懈，要比遭到失败时顽强不屈更重要。" .. random_after,
		"莎士比亚" .. random_before .. ", 人的一生是短的，但如果卑劣地过这一生，就太长了。" .. random_after,
		"俾斯麦" .. random_before .. ", 失败是坚忍的最后考验。" .. random_after,
		"池田大作" .. random_before .. ", 不要回避苦恼和困难，挺起身来向它挑战，进而克服它。" .. random_after,
		"莎士比亚" .. random_before .. ", 那脑袋里的智慧，就像打火石里的火花一样，不去打它是不肯出来的。" .. random_after,
		"希腊" .. random_before .. ", 最困难的事情就是认识自己。" .. random_after,
		"黑塞" .. random_before .. ", 有勇气承担命运这才是英雄好汉。" .. random_after,
		"非洲" .. random_before .. ", 最灵繁的人也看不见自己的背脊。" .. random_after,
		"培根" .. random_before .. ", 阅读使人充实，会谈使人敏捷，写作使人精确。" .. random_after,
		"斯宾诺莎" .. random_before .. ", 最大的骄傲于最大的自卑都表示心灵的最软弱无力。" .. random_after,
		"西班牙" .. random_before .. ", 自知之明是最难得的知识。" .. random_after,
		"塞内加" .. random_before .. ", 勇气通往天堂，怯懦通往地狱。" .. random_after,
		"赫尔普斯" .. random_before .. ", 有时候读书是一种巧妙地避开思考的方法。" .. random_after,
		"笛卡儿" .. random_before .. ", 阅读一切好书如同和过去最杰出的人谈话。" .. random_after,
		"邓拓" .. random_before .. ", 越是没有本领的就越加自命不凡。" .. random_after,
		"爱尔兰" .. random_before .. ", 越是无能的人，越喜欢挑剔别人的错儿。" .. random_after,
		"老子" .. random_before .. ", 知人者智，自知者明。胜人者有力，自胜者强。" .. random_after,
		"歌德" .. random_before .. ", 意志坚强的人能把世界放在手中像泥块一样任意揉捏。" .. random_after,
		"迈克尔·F·斯特利" .. random_before .. ", 最具挑战性的挑战莫过于提升自我。" .. random_after,
		"爱迪生" .. random_before .. ", 失败也是我需要的，它和成功对我一样有价值。" .. random_after,
		"罗素·贝克" .. random_before .. ", 一个人即使已登上顶峰，也仍要自强不息。" .. random_after,
		"马云" .. random_before .. ", 最大的挑战和突破在于用人，而用人最大的突破在于信任人。" .. random_after,
		"雷锋" .. random_before .. ", 自己活着，就是为了使别人过得更美好。" .. random_after,
		"布尔沃" .. random_before .. ", 要掌握书，莫被书掌握；要为生而读，莫为读而生。" .. random_after,
		"培根" .. random_before .. ", 要知道对好事的称颂过于夸大，也会招来人们的反感轻蔑和嫉妒。" .. random_after,
		"莫扎特" .. random_before .. ", 谁和我一样用功，谁就会和我一样成功。" .. random_after,
		"马克思" .. random_before .. ", 一切节省，归根到底都归结为时间的节省。" .. random_after,
		"莎士比亚" .. random_before .. ", 意志命运往往背道而驰，决心到最后会全部推倒。" .. random_after,
		"卡莱尔" .. random_before .. ", 过去一切时代的精华尽在书中。" .. random_after,
		"培根" .. random_before .. ", 深窥自己的心，而后发觉一切的奇迹在你自己。" .. random_after,
		"罗曼·罗兰" .. random_before .. ", 只有把抱怨环境的心情，化为上进的力量，才是成功的保证。" .. random_after,
		"孔子" .. random_before .. ", 知之者不如好之者，好之者不如乐之者。" .. random_after,
		"达·芬奇" .. random_before .. ", 大胆和坚定的决心能够抵得上武器的精良。" .. random_after,
		"叔本华" .. random_before .. ", 意志是一个强壮的盲人，倚靠在明眼的跛子肩上。" .. random_after,
		"黑格尔" .. random_before .. ", 只有永远躺在泥坑里的人，才不会再掉进坑里。" .. random_after,
		"普列姆昌德" .. random_before .. ", 希望的灯一旦熄灭，生活刹那间变成了一片黑暗。" .. random_after,
		"维龙" .. random_before .. ", 要成功不需要什么特别的才能，只要把你能做的小事做得好就行了。" .. random_after,
		"郭沫若" .. random_before .. ", 形成天才的决定因素应该是勤奋。" .. random_after,
		"洛克" .. random_before .. ", 学到很多东西的诀窍，就是一下子不要学很多。" .. random_after,
		"西班牙" .. random_before .. ", 自己的鞋子，自己知道紧在哪里。" .. random_after,
		"拉罗什福科" .. random_before .. ", 我们唯一不会改正的缺点是软弱。" .. random_after,
		"亚伯拉罕·林肯" .. random_before .. ", 我这个人走得很慢，但是我从不后退。" .. random_after,
		"美华纳" .. random_before .. ", 勿问成功的秘诀为何，且尽全力做你应该做的事吧。" .. random_after,
		"俾斯麦" .. random_before .. ", 对于不屈不挠的人来说，没有失败这回事。" .. random_after,
		"阿卜·日·法拉兹" .. random_before .. ", 学问是异常珍贵的东西，从任何源泉吸收都不可耻。" .. random_after,
		"白哲特" .. random_before .. ", 坚强的信念能赢得强者的心，并使他们变得更坚强。 " .. random_after,
		"查尔斯·史考伯" .. random_before .. ", 一个人几乎可以在任何他怀有无限热忱的事情上成功。 " .. random_after,
		"贝多芬" .. random_before .. ", 卓越的人一大优点是：在不利与艰难的遭遇里百折不饶。" .. random_after,
		"莎士比亚" .. random_before .. ", 本来无望的事，大胆尝试，往往能成功。" .. random_after,
		"卡耐基" .. random_before .. ", 我们若已接受最坏的，就再没有什么损失。" .. random_after,
		"德国" .. random_before .. ", 只有在人群中间，才能认识自己。" .. random_after,
		"史美尔斯" .. random_before .. ", 书籍把我们引入最美好的社会，使我们认识各个时代的伟大智者。" .. random_after,
		"冯学峰" .. random_before .. ", 当一个人用工作去迎接光明，光明很快就会来照耀着他。" .. random_after,
		"吉格·金克拉" .. random_before .. ", 如果你能做梦，你就能实现它。" .. random_after
	}
	random_famous = famous[math.random(#famous)]
	return random_famous
end

function BoshGenerator(str)
	--连接用的废话
	bosh = {
		"现在，解决" .. str .. "的问题, 是非常非常重要的。所以，",
		"我们不得不面对一个非常尴尬的事实，那就是，",
		"" .. str .. "的发生，到底需要如何做到，不" .. str .. "的发生，又会如何产生。",
		"而这些并不是完全重要，更加重要的问题是，",
		"" .. str .. "，到底应该如何实现。",
		"带着这些问题，我们来审视一下" .. str .. "。",
		"所谓" .. str .. "，关键是" .. str .. "需要如何写。",
		"我们一般认为，抓住了问题的关键，其他一切则会迎刃而解。",
		"问题的关键究竟为何？",
		"" .. str .. "因何而发生？",
		"每个人都不得不面对这些问题。在面对这种问题时，",
		"一般来讲，我们都必须务必慎重的考虑考虑。",
		"要想清楚，" .. str .. "，到底是一种怎么样的存在。",
		"了解清楚" .. str .. "到底是一种怎么样的存在，是解决一切问题的关键。",
		"就我个人来说，" .. str .. "对我的意义，不能不说非常重大。",
		"本人也是经过了深思熟虑，在每个日日夜夜思考这个问题。",
		"" .. str .. "，发生了会如何，不发生又会如何。",
		"在这种困难的抉择下，本人思来想去，寝食难安。",
		"生活中，若" .. str .. "出现了，我们就不得不考虑它出现了的事实。",
		"这种事实对本人来说意义重大，相信对这个世界也是有一定意义的。",
		"我们都知道，只要有意义，那么就必须慎重考虑。",
		"既然如此，",
		"那么，",
		"我认为，",
		"一般来说，",
		"总结的来说，",
		"既然如何，",
		"经过上述讨论，",
		"这样看来，",
		"从这个角度来看，",
		"我们不妨可以这样来想：",
		"这是不可避免的。",
		"可是，即使是这样，" .. str .. "的出现仍然代表了一定的意义。",
		"" .. str .. "似乎是一种巧合，但如果我们从一个更大的角度看待问题，这似乎是一种不可避免的事实。",
		"在这种不可避免的冲突下，我们必须解决这个问题。",
		"对我个人而言，" .. str .. "不仅仅是一个重大的事件，还可能会改变我的人生。"
	}
	random_bosh = bosh[math.random(#bosh)]
	return random_bosh
end


--主程序
function BullshitGenerator(msg)
	title = string.match(msg.fromMsg,"[%s]*(.-)[%s]*$",#BullshitGenerator_order+1)
	text = "《" .. title .. "》\n作者：{nick}\n"
	paragraph = ""
	if #title ~= 0 then
		if msg.fromGroup == "0" then
			while #text < BSG_private_limit do
				a = ranint(1,100)
				if(a <=5 and #paragraph > 200) then
					paragraph = ""
					text = text .. "\n"
				elseif (a <= 20) then
					sentence = FamousGenerator()
					text = text .. sentence
					paragraph = paragraph .. sentence
				else
					sentence = BoshGenerator(title)
					text = text .. sentence
					paragraph = paragraph .. sentence
				end
			end
			return text
		else
			while #text < BSG_group_limit do
				a = ranint(1,100)
				if(a <=5 and #paragraph > 200) then
					paragraph = ""
					text = text .. "\n"
				elseif (a <= 20) then
					sentence = FamousGenerator()
					text = text .. sentence
					paragraph = paragraph .. sentence
				else
					sentence = BoshGenerator(title)
					text = text .. sentence
					paragraph = paragraph .. sentence
				end
			end
			return text .. "\n……\n【为防止刷屏，群聊中为删减版。请私聊{self}获取较长版本！】"
		end
	else
		return "狗屁不通文章生成器 作者：menzi11\n修改：ChessZH\n输入" ..BullshitGenerator_order.. "以开始生成！"
	end
end
BullshitGenerator_order = "写文章"
msg_order[BullshitGenerator_order] = "BullshitGenerator"

