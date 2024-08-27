RegisterCommand('iniciar', function(source,args)
    local scriptName = args[1]
    if scriptName then
        StartResource(scriptName)
    end 
end)

RegisterCommand('parar', function(source,args)
    local scriptName = args[1]
    if scriptName then
        StopResource(scriptName)
    end 
end)

RegisterCommand('reiniciar', function(source,args)
    local scriptName = args[1]
    if scriptName then
        StopResource(scriptName)
        StartResource(scriptName)
    end 
end)

-- CreateThread(function()
--     while true do
--         print("Numero Aleatorio " .. math.random())
--         Wait(1)
--     end
-- end)

local Proxy = module("vrp", "lib/Proxy")
local Cristian = Proxy.getInterface("Cristian")

Cristian.darBomdia()