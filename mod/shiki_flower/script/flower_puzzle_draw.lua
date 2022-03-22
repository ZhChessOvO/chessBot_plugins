if getUserConf(msg.uid,"flower_puzzle") then
    return "{flower_puzzle_draw_already}"
end
loadLua("flower_puzzle")
puzzle = flower_puzzle[ranint(1,#flower_puzzle)]
msg.puzzle = puzzle.verse
setUserConf(msg.uid,"flower_puzzle",puzzle)
return "{flower_puzzle_draw}"