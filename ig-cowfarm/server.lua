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
            local rewardAmount = 0
            for i = 1, xPlayer.getInventoryItem("milk").count do
                rewardAmount = rewardAmount + math.random(2, 5)
            end
            if xPlayer.getInventoryItem("milk").count > 0 then
                xPlayer.addMoney(rewardAmount)
                xPlayer.removeInventoryItem("milk", xPlayer.getInventoryItem("milk").count)
            else
                TriggerClientEvent('esx:showNotification', source, cfg.translation['nomilk'])

            end
        end
    end

