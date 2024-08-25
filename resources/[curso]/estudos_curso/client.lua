-- Primeiro nativo, criando explosões

-- AddExplosion(-1707.4608154297, -184.22570800781, 57.745403289795, 23, 20, true, false, 5)

-- SetEntityCoords(PlayerPedId(), -1707.4608154297, -184.22570800781, 57.745403289795)

-- GiveWeaponToPed(PlayerPedId(), `weapon_assaultrifle_mk2`, 300, false, true)

-- SetPlayerWantedLevel(PlayerId(), 0, true)

-- SetEntityAlpha(PlayerPedId(), 50, false)

-- SetEntityVisible(PlayerPedId(), false, 0)

-- GiveWeaponComponentToPed(PlayerPedId(), `weapon_assaultrifle_mk2`, `COMPONENT_AT_SIGHTS`)

-- RegisterCommand('removerarmas', function()
--     RemoveAllPedWeapons(PlayerPedId(), true)
-- end)

-- RegisterCommand('armas', function()
--     GiveWeaponToPed(PlayerPedId(), `weapon_assaultrifle_mk2`, 200, false, true)
-- end)

-- RegisterCommand('attachs', function()
--     GiveWeaponComponentToPed(PlayerPedId(), `weapon_assaultrifle_mk2`, `COMPONENT_AT_SIGHTS`)
--     GiveWeaponComponentToPed(PlayerPedId(), `weapon_assaultrifle_mk2`, `COMPONENT_AT_AR_SUPP_02`)
--     GiveWeaponComponentToPed(PlayerPedId(), `weapon_assaultrifle_mk2`, `COMPONENT_ASSAULTRIFLE_MK2_CAMO_10`)
-- end)

-- RegisterCommand('mortal', function()
--     SetEntityInvincible(PlayerPedId(), false)
--     print('Você está mortal')
-- end)

-- RegisterCommand('imortal', function()
--     SetEntityInvincible(PlayerPedId(), true)
--     print('Você está imortal')
-- end)

--##############################
--## Entendendo argumentos do callback no registro de comandos
--##############################

RegisterCommand('tpcds', function(source, args)
    local ped = PlayerPedId()
    SetEntityCoords(ped, tonumber(args[1]), tonumber(args[2]), tonumber(args[3]))
end)

--##############################
--## Criando veículos, objetos e peds
--##############################

RegisterCommand('car', function(source, args)
    local ped = PlayerPedId()
    local pedCds = GetEntityCoords(ped)
    local pedHeading = GetEntityHeading(ped)
    local hashCarroPedido = GetHashKey(args[1])
    RequestModel(hashCarroPedido)
    repeat
        print('Carregando veículo')
        Wait(100)
    until HasModelLoaded(hashCarroPedido)
    local carroCriado = CreateVehicle(hashCarroPedido, pedCds, pedHeading, true)
    SetPedIntoVehicle(ped, carroCriado, -1)
end)

-- RegisterCommand('ped', function(source, args)
--     local ped = PlayerPedId()
--     local pedCds = GetEntityCoords(ped)
--     local modeloDoPed = GetHashKey('a_m_m_acult_01')

--     RequestModel(modeloDoPed)

--     repeat
--         print('Carregando Ped')
--         Wait(1000)
--     until HasModelLoaded(modeloDoPed)

--     CreatePed(4, modeloDoPed,pedCds, 0.0, true)
-- end)

--##############################
--## Nativas de pressionamento de controles por frame
--##############################

-- CreateThread(function()
--     while true do
--         if IsControlJustPressed(0, 38) then
--             print('pressionado com sucesso')
--         end
--         Wait(0)
--     end
-- end)

-- RegisterCommand('-clique', function()
--     print('Voce esta pressionando')
-- end)
-- RegisterCommand('+clique', function()
--     print('Voce soltou a tecla')
-- end)

-- RegisterKeyMapping('+clique', 'Verifica se esta clicando', 'keyboard', 'E')

--##############################
--## Dicionário e Animações
--##############################

-- RegisterCommand('e', function(source, args)
--     if args[1] == "dancar" then
--         local animDict = 'rcmnigel1bnmt_1b'
--         RequestAnimDict(animDict)
--         repeat
--             Wait(100)
--         until HasAnimDictLoaded(animDict)
        
--         TaskPlayAnim(PlayerPedId(), animDict, 'dance_loop_tyler', 8.0, 8.0, -1, 1, 1.0)
--     end
-- end) 

RegisterCommand('clear', function()
    ClearPedTasks(PlayerPedId())
    print("Voce limpou suas tarefas")
    DetachEntity(PlayerPedId(), true, true)
end)

RegisterKeyMapping('clear', 'Limpar tarefas', 'keyboard', 'F6')

--##############################
--## Simulador de sistema de farm
--##############################

-- Usando IsControlJustPressed ao invés de key mapping

-- local coordenada = vec3(2208.3696289063, 5577.7456054688, 53.722595214844)

-- CreateThread(function()
--     while true do
--         local sleep = 100
--         local ped = PlayerPedId()
--         local pedCds = GetEntityCoords(ped)
--         local distance = #(pedCds - coordenada)
--         if distance <= 5 then
--             sleep = 0
--             DrawMarker(22, coordenada, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 2500, true, false, 2, true)
--             if distance <= 2 and IsControlJustPressed(0, 38) then
--                 playAnim()
--                 Wait(5000)
--                 ClearPedTasks(ped)
--             end
--         end
--         Wait(sleep)
--     end
-- end)

-- function notify(msg)
--     BeginTextCommandThefeedPost("STRING")
--     AddTextComponentSubstringPlayerName("Hello ")
--     EndTextCommandThefeedPostTicker(true, true)
-- end

-- function playAnim()
--     local ped = PlayerPedId()
--     animDict = 'rcmnigel1bnmt_1b'
--     animName = 'dance_loop_tyler'
--     RequestAnimDict(animDict)
--     repeat
--         Wait(100)
--     until HasAnimDictLoaded(animDict)

--     TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, 1, 1.0)
-- end

-- CreateThread(function()
--     while true do
--         DrawMarker(22, coordenada, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 2500, true, false, 2, true)
--         Wait(0)
--     end
-- end)

-- RegisterCommand('tryFarm', function()
--     local ped = PlayerPedId()
--     local pedCds = GetEntityCoords(ped)
--     local distance = #(pedCds - coordenada)
--     if distance <= 5 then
--         sleep = 0
--         if distance <= 2 then
--             notify()
--             playAnim()
--             Wait(5000)
--             ClearPedTasks(ped)
--         end
--     end
-- end)

-- RegisterKeyMapping('tryFarm', 'Tentar farmar', 'Keyboard', 'E')

RegisterCommand('dv', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, true) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        SetEntityAsMissionEntity(entity, true, true)
        DeleteVehicle(vehicle)
    end
end)

-- RegisterCommand('beber', function()
--     local ped = PlayerPedId()
--     local pedCds = GetEntityCoords(ped)
--     local animDict = 'amb@world_human_drinking@beer@male@idle_a'
--     local animName = 'idle_a'
    
--     RequestAnimDict(animDict)
    
--     repeat
--         Wait(100)
--     until HasAnimDictLoaded(animDict)
    
--     local model = GetHashKey('p_cs_bottle_01')

--     RequestModel(model)
--     repeat
--         Wait(100)
--     until HasModelLoaded(model)

--     local object = CreateObject(model, pedCds+1, true, false)
--     AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, 0x6F06),
--     0.0, 0.0, 0.0, -- pos
--     0.0, 0.0, 0.0, -- rot
--     nil, true, false, false, false, true)

--     TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, 11, 1.0)

--     Wait(5000)
--     ClearPedTasks(ped)
--     DeleteObject(object)

-- end)

-- CreateThread(function()
--     for k,object in ipairs(GetGamePool('CObject')) do
--         if GetEntityModel(object) == GetHashKey('p_cs_bottle_01') then
--             SetEntityAsMissionEntity(object, true, true)
--             DeleteObject(object)
--         end
--     end
-- end)

-- RegisterCommand('colete', function(source, args)
--     local ped = PlayerPedId()
--     local armourAmount = tonumber(args[1])
--     if armourAmount then
--         SetPedArmour(ped, armourAmount)
--     end
-- end)

--##############################
--## Sistema de agachar e levantar no ctrl
--##############################

local isCrouched = false

CreateThread(function()
    while true do
		DisableControlAction(0, 36)
        
        local ped = PlayerPedId()
        if IsDisabledControlJustPressed(0, 36) then
            if not isCrouched then
                local movementClipset = 'move_ped_crouched'
                RequestAnimSet(movementClipset)
                repeat
                    Wait(100)
                until HasAnimSetLoaded(movementClipset)
                SetPedMovementClipset(ped, movementClipset, 0.5)
                isCrouched = true
            else
                ResetPedMovementClipset(ped, 0.5)
                isCrouched = false
            end
        end
		Wait(0)
	end
end)

local startCoroutine = coroutine.create( function()
    print("1")
    coroutine.yield()
    print("2")
end)

RegisterCommand("teste2", function()
    coroutine.resume( startCoroutine )
end)

RegisterCommand("teste", function()
    coroutine.resume( startCoroutine )
end)