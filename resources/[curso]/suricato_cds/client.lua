CreateThread(function()
	Wait(5000)
	local bool = false
	
	RegisterCommand('focus', function()
		bool = not bool
		SetNuiFocus(bool, bool)
	end)
	
	
	CreateThread(function()
		while true do
			Wait(100)
			local ped = PlayerPedId()
			local cds = GetEntityCoords(ped)
			SendNUIMessage({action = 'input', data = cds.x .. ', ' .. cds.y .. ', ' .. cds.z .. ', ' .. GetEntityHeading(ped) })
		end
	end)
end)