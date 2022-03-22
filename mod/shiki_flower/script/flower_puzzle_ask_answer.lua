puzzle = getUserConf(msg.uid,"flower_puzzle")
msg.answer = puzzle.name
setUserConf(msg.uid,"flower_puzzle",nil)
return "{flower_puzzle_answer}"