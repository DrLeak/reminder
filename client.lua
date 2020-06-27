local hidden = true;

RegisterNetEvent('reminder:PlayNotifySound')
AddEventHandler('reminder:PlayNotifySound', function()
	SendNUIMessage({message = 'play'})
end)

RegisterNetEvent('reminder:list')
AddEventHandler('reminder:list', function(msg)
	hidden = not hidden;
	SendNUIMessage({
		message = 'list',
		reminds = msg,
		hidden = hidden
	})
end)