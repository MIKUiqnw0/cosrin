require "spells"

manual = false
shaman = false
colors = {'demon shards', 'tiger eye', 'giant strength', 'freedom', 'crystal skin', 'flamebane', 'aurora', 'bloodshrine'}
shaColors = {'dragon shards', 'magic eye', 'dragon strength', 'freedom', 'crystal skin', 'flamebane', 'aurora', 'bloodshrine'}
colorEffect = {'Protected', 'Magically Accurate', 'Magically Strengthened', 'Entangle Resistant', 'Cold Resistant', 'Fire Resistant', 'Electrical Resistant', 'Poison Resistant'}
shaColorEffect = {'Protected', 'Magically Accurate', 'Magically Strengthened', 'Entangle Resistant', 'Cold Resistant', 'Fire Resistant', 'Electrical Resistant', 'Poison Resistant'}

function BuffSelf(isShaman)
	shaman = isShaman
	for k,effect in ipairs(shaman == true and shaColorEffect or colorEffect) do
		if effects[effect] == 0 then
			CastSpell(shaman == true and shaColors[k] or colors[k])
			Put('t')
		end
	end
end

function BuffTarget(target)
	for k,color in ipairs(shaman == true and shaColors or colors) do
		CastSpell(color)
		Put('t '..target)
	end
end

for k,arg in ipairs(args) do
	if arg == 'e' then
		manual = true
	elseif arg == 's' then
		shaman = true
	elseif string.match(arg, 't:.*') ~= nil then
		target = string.match(arg, 't:(.*)')
	end
end

if manual == true then BuffSelf(shaman) end
if target ~= nil then BuffTarget(target) end