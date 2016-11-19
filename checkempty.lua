function CheckEmpty(data)
	if data == 'There is no ^Rcreature^N in the room' then
		SetVariable('empty', 1)
		Echo('Its empty')
	end
end

RegisterEvent('line', CheckEmpty)