msg_reply.twenty_four_flower = {
    keyword = {
        --match=完全匹配
        match = { "花信风", "二十四番花信风" }
    },
    limit = {
        cd = 10
    },
    --echo的值为文本时，回复类型为Text;值为table时，将表作为Deck
    echo = "{twenty_four_flower_draw}" 
}
msg_reply.flower_moon = {
    keyword = {
        match = { "花月令", "十二花月令" }
    },
    limit = {
        cd = 10
    },
    echo = "{flower_moon_draw}"
}