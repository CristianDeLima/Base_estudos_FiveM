local Tunnel = module("vrp", "lib/Tunnel")
local Caloro = Tunnel.getInterface("Caloro")

-- CreateThread(function()
--     Caloro.darBomdia()
-- end)
local Client = {}
Tunnel.bindInterface("Client", Client)

function Client.getHealth()
    local ped = PlayerPedId()
    local entityHealth = GetEntityHealth(ped)
    return entityHealth
end