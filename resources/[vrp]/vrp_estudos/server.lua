local Proxy = module("vrp", "lib/Proxy")
local Cristian = {}
Proxy.addInterface("Cristian", Cristian)
local vRP = Proxy.getInterface("vRP")

function Cristian.darBomdia()
    print("Bom Dia Cristian")
end

RegisterCommand("virarpolicial", function(source)
    local user_id = vRP.getUserId(source)
    local acceptedRequested = vRP.request(source, "Você aceita virar policial?", 8)
    if acceptedRequested then
        vRP.addUserGroup(user_id, "police")
    end
end)
    
RegisterCommand("virarcivil", function(source)
    local user_id = vRP.getUserId(source)
    local acceptedRequested = vRP.request(source, "Você aceita virar civil?", 8)
    if acceptedRequested then
        vRP.removeUserGroup(user_id,"police")
    end
end)

RegisterCommand("addgroup", function(source)
    local user_id = vRP.getUserId(source)
    local groupToAdd = vRP.prompt(source, "Coloque o grupo que deseja adicionar", "")
    vRP.addUserGroup(user_id,groupToAdd)
end)

RegisterCommand("removegroup", function(source)
    local user_id = vRP.getUserId(source)
    local groupToRemove = vRP.prompt(source, "Grupo que deseja remover", "")
    if groupToRemove then
        vRP.removeUserGroup(user_id,groupToRemove)
    end
end)

RegisterCommand("noclipPermission", function(source)
    local user_id = vRP.getUserId(source)
    local permission = "player.group.add"
    local hasPermission = vRP.hasPermission(user_id, permission)
    if hasPermission then
        print("Tem a permissão")
    else
        print("Não tem a permissão")
    end
end)

RegisterCommand("noclipGroup", function(source)
    local user_id = vRP.getUserId(source)
    local group = "superadmin"
    local hasGroup = vRP.hasGroup(user_id, group)
    if hasGroup then
        print("Tem o grupo")
    else
        print("Não tem o grupo")
    end
end)

RegisterCommand('moc', function(source)
    local user_id = vRP.getUserId(source)
    local inventory = vRP.getInventory(user_id)
    local inventoryText = ""
    for itemName, amountTable in pairs(inventory) do
        inventoryText = inventoryText .. itemName .. " " .. amountTable.amount .. "x \n"
    end
    print("O inventario do jogador é: ")
    print(inventoryText)
end)


local Tunnel = module("vrp", "lib/Tunnel")
local Caloro = {}
Tunnel.bindInterface("Caloro", Caloro)

function Caloro.darBomdia()
    print("Bom dia Caloro")
end

local Client = Tunnel.getInterface("Client")

RegisterCommand("vervida", function(source)
    local entityHealth = Client.getHealth(source)
    print(entityHealth)
end)
