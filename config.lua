Config = {};

AddEventHandler('onClientResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('chat:addSuggestion', '/remindme', 'reminds you to whatever you need to remember.', {
			{ name="time", help="[hour:minute]" },
			{ name="notification", help="[what do you want to be reminded of?]" }
		})
		
		TriggerEvent('chat:addSuggestion', '/remindplayer', 'reminds you to whatever you need to remember.', {
			{ name="player", help="[server id or -1 (all players)]" },
			{ name="time", help="[hour:minute]" },
			{ name="notification", help="[what do you want to be reminded of?]" }
		})
		
		TriggerEvent('chat:addSuggestion', '/timer', 'reminds you in any given minutes again.', {
			{ name="time", help="[minute]" },
			{ name="notification", help="[what do you want to be reminded of?]" }
		})
	end
end)

Config.notifysound = true; --play a sound, in case the player is tabbed out?
Config.AllowNotifyAll = false; --should a normal user be able to add a reminder for each user?
Config.NeedsAdmin = true; --command restriction for /remindplayer. If you set this on false, everyone will be able to add a reminder for someone.


--end config;
