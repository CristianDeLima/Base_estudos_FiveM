RegisterNetEvent("cristian_estudos:spawnarCarro", function(source, args)
    print(1)
    local ped = PlayerPedId()
    local car = GetHashKey("kuruma")
    local pedCds = GetEntityCoords(ped)
    local pedHeading = GetEntityHeading(ped)
    repeat
        RequestModel(car)
        Wait(100)
    until HasModelLoaded(car)
    
    local vehicle = CreateVehicle(car, pedCds, pedHeading, true)
    SetPedIntoVehicle(ped, vehicle, -1)
    print(2)
end)