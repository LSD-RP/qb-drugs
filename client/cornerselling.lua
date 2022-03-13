-- local cornerselling = false
-- local hasTarget = false
-- local startLocation = nil
-- local lastPed = {}
-- local stealingPed = nil
-- local stealData = {}
-- local availableDrugs = {}
-- local policeMessage = {
--     "Suspicious situation",
--     "Possible drug dealing",
-- }

-- CurrentCops = 0

-- local function stopSelling()
--     LocalPlayer.state:set("inv_busy", false, true)
--     cornerselling = false
--     hasTarget = false
--     startLocation = nil
--     availableDrugs = {}
--     Wait(1000)
-- end

-- RegisterNetEvent('qb-drugs:client:cornerselling', function(data)
--     QBCore.Functions.TriggerCallback('qb-drugs:server:cornerselling:getAvailableDrugs', function(result)
--         if CurrentCops >= Config.MinimumDrugSalePolice then
--             if result ~= nil then
--                 availableDrugs = result
--                 if not cornerselling then
--                     cornerselling = true
--                     LocalPlayer.state:set("inv_busy", true, true)
--                     QBCore.Functions.Notify(Lang:t("info.started_selling_drugs"))
--                     startLocation = GetEntityCoords(PlayerPedId())
--                 else
--                     cornerselling = false
--                     LocalPlayer.state:set("inv_busy", false, true)
--                     QBCore.Functions.Notify(Lang:t("info.stopped_selling_drugs"))
--                     stopSelling()
--                 end
--             else
--                 QBCore.Functions.Notify(Lang:t("error.has_no_drugs"), 'error')
--                 LocalPlayer.state:set("inv_busy", false, true)
--             end
--         else
--             QBCore.Functions.Notify(Lang:t("error.not_enough_police", {polices = Config.MinimumDrugSalePolice}), "error")
--         end
--     end)
-- end)

-- RegisterNetEvent('police:SetCopCount', function(amount)
--     CurrentCops = amount
-- end)

-- RegisterNetEvent('qb-drugs:client:refreshAvailableDrugs', function(items)
--     availableDrugs = items
--     if #availableDrugs <= 0 then
--         QBCore.Functions.Notify(Lang:t("error.no_drugs_left"), 'error')
--         cornerselling = false
--         LocalPlayer.state:set("inv_busy", false, true)
--     end
-- end)

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function loadAnimDict(dict)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

-- local function toFarAway()
--     QBCore.Functions.Notify(Lang:t("error.too_far_away"), 'error')
--     LocalPlayer.state:set("inv_busy", false, true)
--     cornerselling = false
--     hasTarget = false
--     startLocation = nil
--     availableDrugs = {}
--     Wait(5000)
-- end



-- local function callPolice(coords)
--     -- local title = policeMessage[math.random(1, #policeMessage)]
--     -- local pCoords = GetEntityCoords(PlayerPedId())
--     -- local s1, s2 = GetStreetNameAtCoord(pCoords.x, pCoords.y, pCoords.z)
--     -- local street1 = GetStreetNameFromHashKey(s1)
--     -- local street2 = GetStreetNameFromHashKey(s2)
--     -- local streetLabel = street1
--     -- if street2 ~= nil then streetLabel = street1..' '..street2 end
--     -- TriggerServerEvent('police:server:PoliceAlertMessage', title, streetLabel, coords)
--     -- hasTarget = false
--     -- Wait(5000)
-- end

-- function doPoliceAlert()
--     local ped = PlayerPedId()
--     local pos = GetEntityCoords(ped)
--     local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
--     local street1 = GetStreetNameFromHashKey(s1)
--     local street2 = GetStreetNameFromHashKey(s2)
--     local streetLabel = street1
--     if street2 ~= nil then
--         streetLabel = streetLabel .. " " .. street2
--     end

--     -- TriggerServerEvent('qb-drugs:server:callCops', streetLabel, pos)
--     TriggerServerEvent('police:server:policeAlert', 'Possible drug sales in the area')
-- end

-- local function SellToPed(ped)
--     hasTarget = true
--     for i = 1, #lastPed, 1 do
--         if lastPed[i] == ped then
--             hasTarget = false
--             return
--         end
--     end

--     local succesChance = math.random(1, 20)

--     local scamChance = math.random(1, 5)

--     local getRobbed = math.random(1, 20)

--     if succesChance <= 7 then
--         hasTarget = false
--         return
--     -- elseif succesChance >= 15 then
--     --     callPolice(GetEntityCoords(ped))
--     --     return
--     end

--     local drugType = math.random(1, #availableDrugs)
--     local bagAmount = math.random(1, availableDrugs[drugType].amount)

--     if bagAmount > 15 then
--         bagAmount = math.random(9, 15)
--     end
--     currentOfferDrug = availableDrugs[drugType]

--     local ddata = Config.DrugsPrice[currentOfferDrug.item]
--     local randomPrice = math.random(ddata.min, ddata.max) * bagAmount
--     if scamChance == 5 then
--        randomPrice = math.random(3, 10) * bagAmount
--     end

--     SetEntityAsNoLongerNeeded(ped)
--     ClearPedTasks(ped)

--     local coords = GetEntityCoords(PlayerPedId(), true)
--     local pedCoords = GetEntityCoords(ped)
--     local pedDist = #(coords - pedCoords)

--     if getRobbed == 18 or getRobbed == 9 then
--         TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
--     else
--         TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
--     end

--     while pedDist > 1.5 do
--         coords = GetEntityCoords(PlayerPedId(), true)
--         pedCoords = GetEntityCoords(ped)
--         if getRobbed == 18 or getRobbed == 9 then
--             TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
--         else
--             TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
--         end
--         TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
--         pedDist = #(coords - pedCoords)

--         Wait(100)
--     end

--     TaskLookAtEntity(ped, PlayerPedId(), 5500.0, 2048, 3)
--     TaskTurnPedToFaceEntity(ped, PlayerPedId(), 5500)
--     TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)

--     if hasTarget then
--         while pedDist < 1.5 do
--             coords = GetEntityCoords(PlayerPedId(), true)
--             pedCoords = GetEntityCoords(ped)
--             pedDist = #(coords - pedCoords)
--             if getRobbed == 18 or getRobbed == 9 then
--                 TriggerServerEvent('qb-drugs:server:robCornerDrugs', availableDrugs[drugType].item, bagAmount)
--                 QBCore.Functions.Notify(Lang:t("info.has_been_robbed", {bags = bagAmount, drugType = availableDrugs[drugType].label}))
--                 stealingPed = ped
--                 stealData = {
--                     item = availableDrugs[drugType].item,
--                     amount = bagAmount,
--                 }
--                 hasTarget = false
--                 local rand = (math.random(6,9) / 100) + 0.3
--                 local rand2 = (math.random(6,9) / 100) + 0.3
--                 if math.random(10) > 5 then
--                     rand = 0.0 - rand
--                 end
--                 if math.random(10) > 5 then
--                     rand2 = 0.0 - rand2
--                 end
--                 local moveto = GetEntityCoords(PlayerPedId())
--                 local movetoCoords = {x = moveto.x + math.random(100, 500), y = moveto.y + math.random(100, 500), z = moveto.z, }
--                 ClearPedTasksImmediately(ped)
--                 TaskSmartFleePed(ped, PlayerPedId(), 500.0, -1, true, true)
--                 -- TaskGoStraightToCoord(ped, movetoCoords.x, movetoCoords.y, movetoCoords.z, 15.0, -1, 0.0, 0.0)
--                 lastPed[#lastPed+1] = ped
--                 stopSelling()
--                 break
--             else
--                 if pedDist < 1.5 and cornerselling then
--                     DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, Lang:t("info.drug_offer", {bags = bagAmount, drugLabel = currentOfferDrug.label, randomPrice = randomPrice}))
--                     if IsControlJustPressed(0, 38) then
--                         TriggerServerEvent('qb-drugs:server:sellCornerDrugs', availableDrugs[drugType].item, bagAmount, randomPrice)
--                         hasTarget = false
--                         local policeChance = math.random(0,100)
--                         if policeChance <= 35 then
--                             doPoliceAlert()
--                         end
--                         loadAnimDict("gestures@f@standing@casual")
--                         TaskPlayAnim(PlayerPedId(), "gestures@f@standing@casual", "gesture_point", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
--                         Wait(650)
--                         ClearPedTasks(PlayerPedId())

--                         SetPedKeepTask(ped, false)
--                         SetEntityAsNoLongerNeeded(ped)
--                         ClearPedTasksImmediately(ped)
--                         lastPed[#lastPed+1] = ped
--                         break
--                     end

--                     if IsControlJustPressed(0, 47) then
--                         QBCore.Functions.Notify(Lang:t("error.offer_declined"), 'error')
--                         hasTarget = false
--                         if math.random(1,100) < 20 then
--                             if math.random(1,100) < 20 then
--                                 GiveWeaponToPed(ped, `weapon_pistol`, 1, false, true)

--                             else
--                                 GiveWeaponToPed(ped, `weapon_knife`, 1, false, true)
--                             end
--                             stopSelling()
--                             TaskPutPedDirectlyIntoMelee(ped, PlayerPedId(), 0.0, -1.0, 0.0, 0)
--                         else
--                             SetPedKeepTask(ped, false)
--                             SetEntityAsNoLongerNeeded(ped)
--                             ClearPedTasksImmediately(ped)
--                         end
                        
--                         lastPed[#lastPed+1] = ped
--                         break
--                     end
--                 else
--                     hasTarget = false
--                     pedDist = 5
--                     SetPedKeepTask(ped, false)
--                     SetEntityAsNoLongerNeeded(ped)
--                     ClearPedTasksImmediately(ped)
--                     lastPed[#lastPed+1] = ped
--                     cornerselling = false
--                 end
--             end
--             Wait(3)
--         end
--         Wait(math.random(4000, 7000))
--     end
-- end

-- CreateThread(function()
--     while true do
--         sleep = 1000
--         if stealingPed ~= nil and stealData ~= nil then
--             sleep = 0
--             if IsEntityDead(stealingPed) then
--                 local ped = PlayerPedId()
--                 local pos = GetEntityCoords(ped)
--                 local pedpos = GetEntityCoords(stealingPed)
--                 if #(pos - pedpos) < 1.5 then
--                     DrawText3D(pedpos.x, pedpos.y, pedpos.z, Lang:t("info.pick_up_button"))
--                     if IsControlJustReleased(0, 38) then
--                         RequestAnimDict("pickup_object")
--                         while not HasAnimDictLoaded("pickup_object") do
--                             Wait(0)
--                         end
--                         TaskPlayAnim(ped, "pickup_object" ,"pickup_low" ,8.0, -8.0, -1, 1, 0, false, false, false )
--                         Wait(2000)
--                         ClearPedTasks(ped)
--                         TriggerServerEvent("QBCore:Server:AddItem", stealData.item, stealData.amount)
--                         TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[stealData.item], "add")
--                         stealingPed = nil
--                         stealData = {}
--                     end
--                 end
--             end
--         end
--         Wait(sleep)
--     end
-- end)

-- CreateThread(function()
--     while true do
--         sleep = 1000
--         if cornerselling then
--             sleep = 0
--             local player = PlayerPedId()
--             local coords = GetEntityCoords(player)
--             if IsPedInAnyVehicle(player) then
--                 stopSelling()
--             end
--             if not hasTarget then
--                 local PlayerPeds = {}
--                 if next(PlayerPeds) == nil then
--                     for _, player in ipairs(GetActivePlayers()) do
--                         local ped = GetPlayerPed(player)
--                         PlayerPeds[#PlayerPeds+1] = ped
--                     end
--                 end
--                 local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
--                 if closestDistance < 15.0 and closestPed ~= 0 and not IsPedInAnyVehicle(closestPed) then
--                     SellToPed(closestPed)
--                 end
--             end
--             -- startLocation = GetEntityCoords(PlayerPedId())
--             -- local startDist = #(startLocation - coords)
--             -- if startDist > 10 then
--             --     toFarAway()
--             -- end
--         end
--         Wait(sleep)
--     end
-- end)

-- -- Citizen.CreateThread(function()
-- --     while true do
-- --         sleep = 1000
-- --         if cornerselling then
-- --             -- print(startLocation)
-- --             sleep = 2
-- --             DrawMarker(25, startLocation.x, startLocation.y, startLocation.z - 0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 20.0, 20.0, 0.5, 77, 181, 50, 0.8, false, false, 2,false, nil, nil, false)

-- --             -- DrawMarker(25, startLocation.x, startLocation.y, startLocation.z, 0,0,0, 0,0,0, 1, 1, 1, 255,255,0,255, false, false, 2, 0,0,0)
-- --             startLocation = GetEntityCoords(PlayerPedId())
-- --         end
-- --         Wait(sleep)
-- --     end
-- -- end)

local QBCore = exports['qb-core']:GetCoreObject()
local cornerselling = false
local hasTarget = false
local startLocation = nil
local lastPed = {}
local stealingPed = nil
local stealData = {}
local availableDrugs = {}
local policeMessage = {
    "Suspicious situation",
    "Possible drug dealing",
}

CurrentCops = 0

-- if player is near a ped
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if ped ~= 0 and not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) then 
			-- make sure its not one already sold to
			
            local pedType = GetPedType(ped)
			-- make sure not a player
			if hasTarget and (IsPedAPlayer(ped) == false and pedType ~= 28) then
				if CurrentCops >= Config.MinimumDrugSalePolice then 
					local pos = GetEntityCoords(ped)
					DrawText3Ds(pos.x, pos.y, pos.z, 'Press E to sell offer sale')
					if IsControlJustReleased(1, 86) then
                        Wait(50)
                        ClearPedTasksImmediately(ped)
                        FreezeEntityPosition(ped, true)
						attemptSale()
					end
				else 
					local pos = GetEntityCoords(ped)
					DrawText3Ds(pos.x, pos.y, pos.z, 'Not Enough Cops')
				end

			else
				Citizen.Wait(500)
			end
		end
	end
end)

-- while player has drugs, get the nearest ped to them
Citizen.CreateThread(function()
	while true do
		local sleep = 5000
		if #availableDrugs > 0 then
			sleep = 1000
			local playerPed = PlayerPedId()
            -- print(("has target: %s"):format(hasTarget))
			if not hasTarget and not IsPedInAnyVehicle(playerPed, true) and not IsPedDeadOrDying(playerPed, 1) then
                -- print("get ped in front")
                
                ped = GetPedInFront()
                -- print(#(GetEntityCoords(ped) - GetEntityCoords(PlayerPedId())))
                if ped ~= nil and #(GetEntityCoords(ped) - GetEntityCoords(PlayerPedId())) < 2.5 then
                    hasTarget = true
                end
			else
                hasTarget = false
				Citizen.Wait(sleep)
			end
		else
			ped = nil
		end
		Citizen.Wait(sleep)
    end
end)

function GetPedInFront()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
    for i = 1, #lastPed, 1 do
        if lastPed[i] == ped then
            hasTarget = false
            ped = nil
            break
        end
    end
	return ped
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end

function attemptSale()
	
    -- print("stand still you dumbass")
	TaskLookAtEntity(ped, PlayerPedId(), 5500.0, 2048, 3)
    TaskTurnPedToFaceEntity(ped, PlayerPedId(), 5500)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)

    local succesChance = math.random(1, 20)

    local scamChance = math.random(1, 5)

    local getRobbed = math.random(1, 20)

    local drugType = math.random(1, #availableDrugs)
    local bagAmount = math.random(1, availableDrugs[drugType].amount)

    if bagAmount > 15 then
        bagAmount = math.random(9, 15)
    end
    currentOfferDrug = availableDrugs[drugType]

    local ddata = Config.DrugsPrice[currentOfferDrug.item]
    local randomPrice = math.random(ddata.min, ddata.max) * bagAmount
    if scamChance == 5 then
       randomPrice = math.random(3, 10) * bagAmount
    end
	pedDist = 0
    if hasTarget then
        while pedDist < 3.5 do
            coords = GetEntityCoords(PlayerPedId(), true)
            pedCoords = GetEntityCoords(ped)
            pedDist = #(coords - pedCoords)
            if getRobbed == 18 or getRobbed == 9 then
                -- print("rob player")
                TriggerServerEvent('qb-drugs:server:robCornerDrugs', availableDrugs[drugType].item, bagAmount)
                QBCore.Functions.Notify(Lang:t("info.has_been_robbed", {bags = bagAmount, drugType = availableDrugs[drugType].label}))
                stealingPed = ped
                stealData = {
                    item = availableDrugs[drugType].item,
                    amount = bagAmount,
                }
                hasTarget = false
                ClearPedTasksImmediately(ped)
                TaskSmartFleePed(ped, PlayerPedId(), 500.0, -1, true, true)
                -- TaskGoStraightToCoord(ped, movetoCoords.x, movetoCoords.y, movetoCoords.z, 15.0, -1, 0.0, 0.0)
                lastPed[#lastPed+1] = ped
                FreezeEntityPosition(ped, false)
                ped = nil
                break
            else
                if pedDist < 2.5 then
                    -- print("offer sale")
                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, Lang:t("info.drug_offer", {bags = bagAmount, drugLabel = currentOfferDrug.label, randomPrice = randomPrice}))
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('qb-drugs:server:sellCornerDrugs', availableDrugs[drugType].item, bagAmount, randomPrice)
                        hasTarget = false
                        local policeChance = math.random(0,100)
                        if policeChance <= 35 then
                            doPoliceAlert()
                        end
                        loadAnimDict("gestures@f@standing@casual")
                        TaskPlayAnim(PlayerPedId(), "gestures@f@standing@casual", "gesture_point", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
                        Wait(650)
                        ClearPedTasks(PlayerPedId())

                        SetPedKeepTask(ped, false)
                        SetEntityAsNoLongerNeeded(ped)
                        ClearPedTasksImmediately(ped)
                        lastPed[#lastPed+1] = ped
                        FreezeEntityPosition(ped, false)
                        ped = nil
                        break
                    end

                    if IsControlJustPressed(0, 47) then
                        QBCore.Functions.Notify(Lang:t("error.offer_declined"), 'error')
                        if math.random(1,100) < 20 then
                            if math.random(1,100) < 20 then
                                GiveWeaponToPed(ped, `weapon_pistol`, 1, false, true)

                            else
                                GiveWeaponToPed(ped, `weapon_knife`, 1, false, true)
                            end
                            -- stopSelling()
                            TaskPutPedDirectlyIntoMelee(ped, PlayerPedId(), 0.0, -1.0, 0.0, 0)
                        else
                            SetPedKeepTask(ped, false)
                            SetEntityAsNoLongerNeeded(ped)
                            ClearPedTasksImmediately(ped)
                        end
                        
                        lastPed[#lastPed+1] = ped
                        FreezeEntityPosition(ped, false)
                        ped = nil
                        hasTarget = false
                        break
                    end
                else
                    -- hasTarget = false
                    pedDist = 5
                    SetPedKeepTask(ped, false)
                    SetEntityAsNoLongerNeeded(ped)
                    ClearPedTasksImmediately(ped)
                    FreezeEntityPosition(ped, false)
                    lastPed[#lastPed+1] = ped
                end
            end
            Wait(3)
        end
    end
end




RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('qb-drugs:client:refreshAvailableDrugs', function(items)
    availableDrugs = items
end)

function doPoliceAlert()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 ~= nil then
        streetLabel = streetLabel .. " " .. street2
    end

    -- TriggerServerEvent('qb-drugs:server:callCops', streetLabel, pos)
    TriggerServerEvent('police:server:policeAlert', 'Possible drug sales in the area')
end


-- allows player to retrieve drugs from npc when stolen
CreateThread(function()
    while true do
        sleep = 1000
        if stealingPed ~= nil and stealData ~= nil then
            sleep = 0
            if IsEntityDead(stealingPed) then
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local pedpos = GetEntityCoords(stealingPed)
                if #(pos - pedpos) < 1.5 then
                    DrawText3D(pedpos.x, pedpos.y, pedpos.z, Lang:t("info.pick_up_button"))
                    if IsControlJustReleased(0, 38) then
                        RequestAnimDict("pickup_object")
                        while not HasAnimDictLoaded("pickup_object") do
                            Wait(0)
                        end
                        TaskPlayAnim(ped, "pickup_object" ,"pickup_low" ,8.0, -8.0, -1, 1, 0, false, false, false )
                        Wait(2000)
                        ClearPedTasks(ped)
                        TriggerServerEvent("QBCore:Server:AddItem", stealData.item, stealData.amount)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[stealData.item], "add")
                        stealingPed = nil
                        stealData = {}
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('inventory:client:UpdatePlayerInventory', function(isError)
	-- print("update inventory")
	QBCore.Functions.TriggerCallback('qb-drugs:server:cornerselling:getAvailableDrugs', function(result)
		if result then
			availableDrugs = result
		else
			availableDrugs = {}
		end
	end)
end)