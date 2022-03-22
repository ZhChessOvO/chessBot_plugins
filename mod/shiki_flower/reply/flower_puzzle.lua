msg_reply.flower_puzzle_draw = {
    keyword = { --关键词
        --match=完全匹配
        match = { "抽花谜" }
    },
    limit = {
        --聊天窗口本回复冷却10秒
        cd = 10
    },
    --调用script中的flower_puzzle_draw.lua
    echo = { lua = "flower_puzzle_draw" }
}
msg_reply.flower_puzzle_answer = {
    keyword = {
        --prefix=前缀匹配
        prefix = { "解花谜" }
    },
    limit = {
        cd = 3,
        user_var = {    --用户conf中存有"flower_puzzle"
            flower_puzzle = true
        }
    },
    echo = { lua = "flower_puzzle_answer" }
}
msg_reply.flower_puzzle_ask_answer = {
    keyword = {
        match = { "求解花谜" }
    },
    limit = {
        cd = 3,
        user_var = {    --用户conf中存有"flower_puzzle"
            flower_puzzle = true
        }
    },
    echo = { lua = "flower_puzzle_ask_answer" }
}