puzzle = getUserConf(msg.uid,"flower_puzzle")
answer = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"解花谜"+1)
msg.answer = answer
if puzzle.name~=answer then
    return "{flower_puzzle_error}"
end
setUserConf(msg.uid,"flower_puzzle",nil)
return "{flower_puzzle_correct}"