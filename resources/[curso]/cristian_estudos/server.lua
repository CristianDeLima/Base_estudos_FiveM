RegisterCommand("carro2", function(source, args)
    local source = tonumber(args[1])
    print(source)
    TriggerClientEvent("cristian_estudos:spawnarCarro", source)
end)