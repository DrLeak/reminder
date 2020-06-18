
local reminds = {};

RegisterCommand('remindme', function(source, args, rawCommand)
	if source > 0 then
		if args[1] ~= nil then
			if not string.find(args[1], ':') or string.find(args[1], '60') then
				TriggerClientEvent('chat:addMessage', source, {
					color={255, 0, 0},
					args={'System', 'You need to use the right format! [hour:minute] [^~24^r ^_00^r:^~59^r ^_00^r]'}
				})
			elseif string.len(args[1]) < 5 or string.len(args[1]) > 5 then
				TriggerClientEvent('chat:addMessage', source, {
					color={255, 0, 0},
					args={'System', 'Your time is incorrect, please enter a valid time! [00:00]'}
				})
			else
				local time = args[1]
				local args = string.gsub(table.concat(args, " "), time, '')
				
				if args ~= '' then
					TriggerClientEvent('chat:addMessage', source, {
						color={255, 0, 0},
						args={'System', 'You\'ll be reminded at '..time..'!'}
					})
					table.insert(reminds, {trigger=time, string=args, user=tonumber(source)})
				else
					TriggerClientEvent('chat:addMessage', source, {
						color={255, 0, 0},
						args={'System', 'You\'ve forgot to add the reminder text!'}
					})
				end
			end
		end
	end
end)

RegisterCommand('remindplayer', function(source, args, rawCommand)
	if source > 0 then
		if args[1] ~= nil and args[2] ~= nil then
			if not string.find(args[2], ':') or string.find(args[2], '24') or string.find(args[2], '60') then
				TriggerClientEvent('chat:addMessage', source, {
					color={255, 0, 0},
					args={'System', 'You need to use the right format! [hour:minute] [^~24^r ^_00^r:^~59^r ^_00^r]'}
				})
			elseif string.len(args[2]) < 5 or string.len(args[2]) > 5 then
				TriggerClientEvent('chat:addMessage', source, {
					color={255, 0, 0},
					args={'System', 'Your time is incorrect, please enter a valid time! [00:00]'}
				})
			else
				local time = args[2]
				local player = args[1]
				local args = string.gsub(table.concat(args, " "), time, '')
				args = string.gsub(args, player, '')
				
				if args ~= '' and (player == '-1' and Config.AllowNotifyAll == true or DoesEntityExist(GetPlayerPed(player))) then
					TriggerClientEvent('chat:addMessage', source, {
						color={255, 0, 0},
						args={'System', 'The player will be reminded at '..time..'!'}
					})
					table.insert(reminds, {trigger=time, string=args, user=player})
				else
					TriggerClientEvent('chat:addMessage', source, {
						color={255, 0, 0},
						args={'System', 'You\'ve forgot to add the reminder text, or the player does not exist / you have no permissions to add a reminder for him!'}
					})
				end
			end
		end
	end
end, Config.NeedsAdmin)

RegisterCommand('removereminders', function(source)
	local id = tonumber(source)
	local reminders = 0
	for i = 1, #reminds do
		if reminds[i].user == id then
			reminds[i] = nil
			reminders = reminders +1
		end
	end
	
	TriggerClientEvent('chat:addMessage', source, {
		color={255, 0, 0},
		args={'Reminder', 'You deleted '..reminders..' reminders.'}
	})
end)


Citizen.CreateThread(function()
	while true do
		
		if #reminds > 0 then
			local stime = tostring(os.date('%H')..':'..os.date('%M'))
			for i = 1, #reminds do
				if stime == reminds[i].trigger then
					TriggerClientEvent('chat:addMessage', reminds[i].user, {
						color={255, 0, 0},
						args={'Reminder', reminds[i].string}
					})
					if Config.notifysound == true then
						TriggerClientEvent('reminder:PlayNotifySound', reminds[i].user)
					end
					
					reminds[i] = nil;
				end
			end
		end
		
		Citizen.Wait(10000) --every 10 seconds.
	end
end)
