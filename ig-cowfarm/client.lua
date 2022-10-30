

if cfg.esxLegacy == false then
    ESX = nil -- ESX 
    CreateThread(function()
	    while ESX == nil do
	    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		    Wait(0)
	    end
    end)
end

RegisterNetEvent('esx:playerLoaded') -- toto načte postavu prostě základ
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local blip = nil
local sellmilk = nil
local sellmilkmarker = true

CreateThread(function()
	while true do
        Citizen.Wait(5000)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == cfg.job['job'] then
            if blip == nil then
                blip = AddBlipForCoord(cfg.blip['blipcow'])
                AddTextEntry('blip', cfg.blip['blipcowname'])
                SetBlipSprite(blip, 366)
                SetBlipColour(blip, 37)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 1.0)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('blip')
                EndTextCommandSetBlipName(blip)
            end
            if sellmilk == nil then
                sellmilk = AddBlipForCoord(cfg.blip['sellmilk'])
                AddTextEntry('blip', cfg.blip['sellmilkname'])
                SetBlipSprite(sellmilk, 473)
                SetBlipColour(sellmilk, 37)
                SetBlipDisplay(sellmilk, 4)
                SetBlipScale(sellmilk, 1.0)
                SetBlipAsShortRange(sellmilk, true)
                BeginTextCommandSetBlipName('blip')
                EndTextCommandSetBlipName(sellmilk)
            end

        else
            if blip ~= nil then
                RemoveBlip(blip)
                blip = nil
            end
            if sellmilk ~= nil then
                RemoveBlip(sellmilk)
                sellmilk = nil
            end

        end
    end
end)


CreateThread(function()
	while true do
        cas = 1000
		local playerPed = PlayerPedId()
        local Coords = GetEntityCoords(PlayerPedId())
        local pos = (cfg.marker['sellmilk'])
		local dist = #(Coords - pos)
        if dist < 5 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == cfg.job['job'] then
                if sellmilkmarker then
                    sellmilkmarker = true
                    if sellmilkmarker == true then
                        cas = 5
                        ShowFloatingHelpNotification(cfg.translation['sellmilk'], pos)
                        if IsControlJustPressed(0, 38) and dist < 3 then
                            sellmilkmarker = true
							TriggerServerEvent("ig-cowfarm:sell")
							Wait(250)
                        end
                    end
                end
            end
        end
        Wait(cas)
	end
end)



RegisterNetEvent("ig-cowfarm:milk")
AddEventHandler("ig-cowfarm:milk", function()
	local playerPed = PlayerPedId()
	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 3000, true)
	exports.rprogress:MiniGame({
		Difficulty = "Easy",
		Timeout = 5000, -- Duration before minigame is cancelled
		onComplete = function(success)
				if success then
					TriggerServerEvent("ig-cowfarm:getmilk")
					ClearPedTasks(playerPed)
				else
					Notify(cfg.translation['tryagain'])
					ClearPedTasks(playerPed)

				end    
		end,
	})
end)

ShowFloatingHelpNotification = function(msg, pos)
    AddTextEntry('text', msg)
    SetFloatingHelpTextWorldPosition(1, pos.x, pos.y, pos.z)
    SetFloatingHelpTextStyle(2, 1, 25, -1, 3, 0)
    BeginTextCommandDisplayHelp('text')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

exports.qtarget:AddTargetModel({"a_c_cow"}, {
	options = {
		{
			event = "ig-cowfarm:milk",
			icon = "fas fa-box-circle-check",
			label = cfg.translation['getmilk'],
			num = 1
		},
	},
	distance = 2
})

-- IN TEST

zastavitkravu = function()
local player = PlayerPedId()
	if player then
		GetClosestPed(GetEntityCoords(PlayerPedId()), 5, true, true, true, true, 28)
		print("funguje")
	end
end

local npc = {}
local npcThreadas = 3000
local karves = {}
CreateThread(function() 
	while true do
		Wait(npcThreadas)
		local pos = GetEntityCoords(PlayerPedId())
		local dist = 0
		for k,v in pairs(cfg.karves) do
			dist = #(vec3(v.pos.x, v.pos.y, v.pos.z) - pos)
			if dist < 100 and not v.spawned then
				local hash = GetHashKey(v.model)
				-- Modelio uzkrovimas
				if not HasModelLoaded(hash) then
					RequestModel(hash)
					Wait(10)
				end
				while not HasModelLoaded(hash) do 
					Wait(10)
				end

				local pedas = CreatePed(1, hash, v.pos.x, v.pos.y, v.pos.z, v.pos.h, false, false)
                SetBlockingOfNonTemporaryEvents(pedas, true)
				SetEntityInvincible(pedas, true)
                FreezeEntityPosition(pedas, true)
				SetBlockingOfNonTemporaryEvents(illegpedasalFishSeller, true)
				SetModelAsNoLongerNeeded(hash)
				v.spawned = true
				karves[k] = pedas
			elseif v.spawned and dist > 100 then
				v.spawned = false
				DeleteEntity(karves[k])
			end
		end
	
	end
end)

