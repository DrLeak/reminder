

RegisterNetEvent('reminder:PlayNotifySound')
AddEventHandler('reminder:PlayNotifySound', function()
	SendNUIMessage({message = 'play'})
end)