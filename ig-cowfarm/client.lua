

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
local JobStarted = false

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
                SetBlipSprite(sellmilk, 293)
                SetBlipColour(sellmilk, 2)
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




RegisterNetEvent("ig-cowfarm:milk")
AddEventHandler("ig-cowfarm:milk", function()
	local playerPed = PlayerPedId()
	if JobStarted == false then
	JobStarted = true
	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 5000, true)
	if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then end
	ClearPedTasks(playerPed)
	TriggerServerEvent("ig-cowfarm:getmilk")
	Citizen.Wait(500)
	JobStarted = false
	else
		Notify(cfg.translation['jobisnotdone'])
	end
end)


RegisterNetEvent("ig-cowfarm:sellcl")
AddEventHandler("ig-cowfarm:sellcl", function()
	TriggerServerEvent("ig-cowfarm:sell")
end)


exports.ox_target:addModel("a_c_cow", {{
            event = 'ig-cowfarm:milk',
            icon = 'fa-solid fa-cow',
            label = cfg.translation['getmilk'],
            groups = cfg.job['job'],
	    distance = 2,
}})

exports.ox_target:addModel("a_m_m_farmer_01", {{
	event = 'ig-cowfarm:sellcl',
	icon = 'fa-solid fa-dollar-sign',
	label = cfg.translation['sellmilk'],
	groups = cfg.job['job'],
	distance = 2,
}})


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

