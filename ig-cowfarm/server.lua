if cfg.esxLegacy == false then
    ESX = nil
    TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
end
local maxmoney = 1100

RegisterNetEvent("ig-cowfarm:getmilk")
AddEventHandler("ig-cowfarm:getmilk", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.canCarryItem("milk", 1) then
        xPlayer.addInventoryItem("milk", 1)
    else
        TriggerClientEvent('esx:showNotification', source, cfg.translation['limit'])

    end
end)

RegisterNetEvent("ig-cowfarm:sell")
AddEventHandler("ig-cowfarm:sell", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local money = 1000
    if xPlayer ~= nil then
        if money >= maxmoney then
            xPlayer.kick("Cheater")
        else
            local randomMoney = math.random(30,60)
            if xPlayer.getInventoryItem("milk").count > 0 then
                xPlayer.addMoney(cfg.money['permilk'])
                xPlayer.removeInventoryItem("milk", 1)
            else
                TriggerClientEvent('esx:showNotification', source, cfg.translation['nomilk'])

            end
        end
    end
end)

