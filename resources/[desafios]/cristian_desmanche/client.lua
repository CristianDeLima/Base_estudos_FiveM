local markerVehicle = vec3(-1952.0517578125, 3306.4626464844, 32.960231781006 - 0.99)
local markDelivery = vec3(-1954.8822021484, 3301.7270507813, 32.960235595703)
local inChop
local quantityDoorsToChop
local inDelivery
local doorToDelete
local boneVehicleDoors = {
    "door_dside_f",
    "door_pside_f",
    "door_dside_r",
    "door_pside_r"
}

RegisterNetEvent("cristian_desmanche:tp", function()
    SetEntityCoords(PlayerPedId(), markerVehicle, 0.0, 0.0, 0.0)
end)


CreateThread(function()
    local ped = PlayerPedId()
    local sleep = 5000
    while not inChop do
        local pedCds = GetEntityCoords(ped)
        local distance = #(pedCds - markerVehicle)
        if distance <= 10 then
            sleep = 0
            DrawMarker(27, markerVehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 255, 0, 0, 255, false, false, false, true)
            if distance <= 5 and IsControlJustPressed(0, 38) then
                local vehicle = vehiclePedUsing(ped)
                if vehiclePedUsing(ped) then
                    if not IsPedInAnyVehicle(ped, true) then
                        if not inChop then
                            doorsQuantity(vehicle)
                            StartChop(vehicle)
                        end
                    else
                        notifyYellow("Desca do veículo para iniciar o desmanche")
                    end
                else
                    notifyYellow("Você só pode desmanchar carros aqui.")
                end

            end
        end    
        Wait(sleep)
    end
end)


function StartChop(vehicle)
    inChop = true
    for i = 0, quantityDoorsToChop - 1 do
        SetVehicleDoorOpen(vehicle, i, true, true)
        Wait(50)
    end
    SetEntityAsMissionEntity(vehicle, true, true)
    FreezeEntityPosition(vehicle, true)
    while inChop do
        local distanceForChopDoor = #(GetEntityCoords(PlayerPedId()) - coordBoneVehicleDoor(vehicle))
        drawText3D(coordBoneVehicleDoor(vehicle).x, coordBoneVehicleDoor(vehicle).y, coordBoneVehicleDoor(vehicle).z , "Pressione [~r~ E ~w~] para desmanchar esta porta.")
        if distanceForChopDoor <= 2 and IsControlJustPressed(0, 38) then
            playChopAnim(vehicle)
        end
        Wait(0)
    end
end

function playChopAnim(vehicle)
    local animDictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
    local animName = "machinic_loop_mechandplayer"

    repeat
        RequestAnimDict(animDictionary)
        Wait(100)
    until HasAnimDictLoaded(animDictionary)

    TaskPlayAnim(PlayerPedId(), animDictionary, animName, 8.0, 8.0, 5000, 01, 0.0, true, true, true)
    Wait(5000)
    inDeliveryDoor(vehicle)

end

function inDeliveryDoor(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleDoorBroken(vehicle, quantityDoorsToChop - 1, true)
    inDelivery = true
    animDeliveryDoor()
    while inDelivery do
        local ped = PlayerPedId()
        local pedCds = GetEntityCoords(ped)
        local distance = #(pedCds - markDelivery)
        drawText3D(markDelivery.x, markDelivery.y, markDelivery.z, "Pressione [~r~ E ~w~] para desmanchar esta porta.")
        DrawMarker(27, markDelivery.x, markDelivery.y, markDelivery.z - 0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 255, false, false, false, true)
        if distance <= 2 and IsControlJustPressed(0, 38) then
            deliveryDoor()
        end
        Wait(0)
    end
end

function animDeliveryDoor()
    local animDictionary = "anim@heists@box_carry@"
    local animName = "idle"

    repeat
        RequestAnimDict(animDictionary)
        Wait(100)
    until HasAnimDictLoaded(animDictionary)

    TaskPlayAnim(PlayerPedId(), animDictionary, animName, 8.0, 8.0, -1, 48, 0.0)
    createDoor()
end

function createDoor()
    local ped = PlayerPedId()
    local modelHash = "prop_car_door_01"
    local cdsCreate = GetEntityCoords(ped)
    local pedBoneIndex = GetPedBoneIndex(ped, 28422)
    local door = CreateObject(modelHash, pedBoneIndex, true)
    AttachEntityToEntity(door, ped, pedBoneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, true, false, false, 2, true)
    AttachEntityToEntity(entity1, entity2, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, p9, useSoftPinning, collision, isPed, vertexIndex, fixedRot)
    doorToDelete = door
end

function deliveryDoor()
    ClearPedTasks(PlayerPedId())
    DeleteEntity(doorToDelete)
    inDelivery = false
    if quantityDoorsToChop >= 2 then
        quantityDoorsToChop = quantityDoorsToChop - 1
    else
        finishChop()
    end
end

function finishChop()
    notifyGreen("Você terminou o desmanche.")
    DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), true))
    inChop = false
    quantityDoorsToChop = false
    inDelivery = false
    doorToDelete = false
end

function coordBoneVehicleDoor(vehicle)
    local boneIndex = GetEntityBoneIndexByName(vehicle, boneVehicleDoors[quantityDoorsToChop])
    local boneCoords = GetWorldPositionOfEntityBone(vehicle, boneIndex)
    return vec3(boneCoords)
end

function doorsQuantity(vehicle)
    local vehicleDoorsQuantity = GetNumberOfVehicleDoors(vehicle)
    print(vehicleDoorsQuantity)
    if vehicleDoorsQuantity > 4 then
        quantityDoorsToChop = 4
    else
        quantityDoorsToChop = 2
    end
end

function vehiclePedUsing(ped)
    local vehicle = GetVehiclePedIsIn(ped, true)
    local vehicleType = GetVehicleClass(vehicle)
    if vehicleType ~= 8 and vehicleType ~= 13 then
        return vehicle
    else
        return false
    end
end


function notifyGreen(message)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName("~g~" .. message)
    EndTextCommandThefeedPostTicker(true, true)
end
function notifyYellow(message)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName("~y~" .. message)
    EndTextCommandThefeedPostTicker(true, true)
end
function notifyRed(message)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName("~r~" .. message)
    EndTextCommandThefeedPostTicker(true, true)
end



function drawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.39, 0.39)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 235)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 270
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.04, 0, 0, 0, 145)
end