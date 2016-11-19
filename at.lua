require "buff"

if args[1] ~= nil then 
	if args[1] == 'k' then
		SetVariable('run', 0)
		SetVariable('empty', 0)
		KillScript('checkempty')
		KillScript('at')
	else
		SetVariable('spell', args[1])
		if args[2] ~= nil and args[2] == 'g' then
			Put('group')
			result = WaitFor('No one', 'HP:')
			if not string.find(result, 'No one') then
				Echo("TEST: "..result)
			end
		end
	end
end

if tonumber(GetVariable('run')) == 0 then
	RunMacro('.checkempty&')
end

function SpellPointsRestore()
	Put('activate relic')
	PauseMS(2000)
	Put('t')
	ub = WaitFor('You are unbalanced.', 'You are invigorated with')
	if string.find(ub, 'You are unbalanced') then
		PauseMS(500)
		Put('t')
	end
end

function SelfRestore(complete)
	if character.sp <= 100 then
		SpellPointsRestore()
	end
	if complete == true then
		while effects['POISONED'] > 10 do 
			Put('t;;cast antidote')
			PauseMS(1000)
		end
		while effects['BlEEDING'] > 10 do
			Put('t;;cast body bind')
			PauseMS(1000)
		end
	end
	if character.hp / character.maxhp <= 0.7 then
		while character.hp / character.maxhp < 0.85 do
			if character.sp <= 100 then
				SpellPointsRestore()
			end
			Put('t;;cast heal')
			PauseMS(1000)
		end
	end
end

isRunning = tonumber(GetVariable('run'))
spell = GetVariable('spell')
if spell ~= nil and isRunning == 0 then
	SetVariable('run', 1)
	while(true) do
		if GetVariable('spell') ~= spell then
			spell = GetVariable('spell')
		end
		
		SelfRestore()
		
		Put('t Gigantic storm fly;;t;;cast '..spell)
		PauseMS(1000)
		if tonumber(GetVariable('empty')) == 1 then
			BuffSelf(false)
			if character.sp / character.maxsp < 0.6 then
				SpellPointsRestore()
			end
			SelfRestore(true)
		end
				
		if effects['CONFUSED'] == 0 and tonumber(GetVariable('empty')) == 1 then
			for i = 0,10,1 do
				Put('e;;w;;e;;w;;e;;w')
				PauseMS(400)
				Echo('Pass: ^R'..i)
			end
		end
		SetVariable('empty', 0)
	end
end