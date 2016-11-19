function CastSpell(spell, prefix)
	local ready
	local ready2
	local ready3 = false
	
	repeat
		if prefix == nil then prefix = '' end
		Put(prefix.."chant "..spell)
		text = WaitFor("You cannot Cast Spells while Mute...", "Spam filter", "spell points but you only have", "You are unbalanced.", "You hear ^CSyithnirag^N chant strange words of magic...", "You hear ^CDragthire^N chant strange words of magic...", "As you complete the casting of your ", "Just when you think you've completed the casting of your ", "spell fails for some reason. Perhaps you should become a knight?", "There is no ^Rcreature^N in the room", "You already have a")
		ready = string.find(text, "chant strange words of magic...")
		ready2 = string.find(text, "You already have a")
		if text == "There is no ^Rcreature^N in the room" then
			ready3 = true
		end
		if ready ~= nil then 
			PauseMS(600)
		end
	until ready ~= nil or ready2 ~= nil or ready3

	return ready3
end