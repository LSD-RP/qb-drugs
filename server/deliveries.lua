local QBCore = exports['qb-core']:GetCoreObject()

local function GetDealers()
    return Config.Dealers
end

exports("GetDealers", GetDealers)

RegisterNetEvent('qb-drugs:server:updateDealerItems', function(itemData, amount, dealer)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.Dealers[dealer]["products"][itemData.slot].amount - 1 >= 0 then
        Config.Dealers[dealer]["products"][itemData.slot].amount =
            Config.Dealers[dealer]["products"][itemData.slot].amount - amount
        TriggerClientEvent('qb-drugs:client:setDealerItems', -1, itemData, amount, dealer)
    else
        Player.Functions.RemoveItem(itemData.name, amount)
        Player.Functions.AddMoney('cash', amount * Config.Dealers[dealer]["products"][itemData.slot].price)

        TriggerClientEvent("QBCore:Notify", src, Lang:t("error.item_unavailable"), "error")
    end
end)

RegisterNetEvent('qb-drugs:server:giveDeliveryItems', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('weed_brick', amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_brick"], "add")
end)

QBCore.Functions.CreateCallback('qb-drugs:server:RequestConfig', function(source, cb)
    cb(Config.Dealers)
end)

RegisterNetEvent('qb-drugs:server:succesDelivery', function(deliveryData, inTime, Party)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PartyMembers = Party
    local curRep = Player.PlayerData.metadata["dealerrep"]
    local copsOnDuty = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                copsOnDuty = copsOnDuty + 1
            end
        end
    end

    if inTime then
        if Player.Functions.GetItemByName('weed_brick') ~= nil and Player.Functions.GetItemByName('weed_brick').amount >=
            deliveryData["amount"] then
            Player.Functions.RemoveItem('weed_brick', deliveryData["amount"])
            local price = 3000
            if copsOnDuty == 1 then
                price = 4000
            elseif copsOnDuty == 2 then
                price = 5000
            elseif copsOnDuty >= 3 then
                price = 6000
            end
            local cashAmount = 3000
            if curRep < 10 then
                cashAmount = deliveryData["amount"] * price / 100 * 8
                -- Player.Functions.AddMoney('cash', (deliveryData["amount"] * price / 100 * 8), "dilvery-drugs")
            elseif curRep >= 10 then
                cashAmount = deliveryData["amount"] * price / 100 * 10
                -- Player.Functions.AddMoney('cash', (deliveryData["amount"] * price / 100 * 10), "dilvery-drugs")
            elseif curRep >= 20 then
                cashAmount = deliveryData["amount"] * price / 100 * 12
                -- Player.Functions.AddMoney('cash', (deliveryData["amount"] * price / 100 * 12), "dilvery-drugs")
            elseif curRep >= 30 then
                cashAmount = deliveryData["amount"] * price / 100 * 15
                -- Player.Functions.AddMoney('cash', (deliveryData["amount"] * price / 100 * 15), "dilvery-drugs")
            elseif curRep >= 40 then
                cashAmount = deliveryData["amount"] * price / 100 * 18
                -- Player.Functions.AddMoney('cash', (deliveryData["amount"] * price / 100 * 18), "dilvery-drugs")
            end
            local partySize = #PartyMembers + 1
            cashAmount = math.ceil(cashAmount / partySize)
            for q,b in pairs(PartyMembers) do
                local Member = QBCore.Functions.GetPlayerByCitizenId(b)
                Member.Functions.AddMoney('cash', cashAmount, "dilvery-drugs")
            end
            Player.Functions.AddMoney('cash', cashAmount, "dilvery-drugs")

            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_brick"], "remove")
            TriggerClientEvent('QBCore:Notify', src, Lang:t("success.order_delivered"), 'success')

            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'perfect', deliveryData)
                for q,b in pairs(PartyMembers) do
                    local Member = QBCore.Functions.GetPlayerByCitizenId(b)
                    local MemberRep = Member.PlayerData.metadata["dealerrep"]
                    Member.Functions.SetMetaData('dealerrep', (MemberRep + 1))
                end
                Player.Functions.SetMetaData('dealerrep', (curRep + 1))
            end)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.order_not_right"), 'error')

            if Player.Functions.GetItemByName('weed_brick').amount ~= nil then
                Player.Functions.RemoveItem('weed_brick', Player.Functions.GetItemByName('weed_brick').amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_brick"], "remove")
                Player.Functions.AddMoney('cash', (Player.Functions.GetItemByName('weed_brick').amount * 6000 / 100 * 5))
            end
            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'bad', deliveryData)
                if curRep - 1 > 0 then
                    Player.Functions.SetMetaData('dealerrep', (curRep - 1))
                else
                    Player.Functions.SetMetaData('dealerrep', 0)
                end
            end)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.too_late"), 'error')

        Player.Functions.RemoveItem('weed_brick', deliveryData["amount"])
        Player.Functions.AddMoney('cash', (deliveryData["amount"] * 6000 / 100 * 4), "delivery-drugs-too-late")

        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_brick"], "remove")

        SetTimeout(math.random(5000, 10000), function()
            TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'late', deliveryData)

            if curRep - 1 > 0 then
                Player.Functions.SetMetaData('dealerrep', (curRep - 1))
            else
                Player.Functions.SetMetaData('dealerrep', 0)
            end
        end)
    end
end)

RegisterNetEvent('qb-drugs:server:callCops', function(streetLabel, coords)
    local msg = Lang:t("info.police_message_server")
    local alertData = {
        title = Lang:t("info.drug_deal"),
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        description = msg
    }
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("qb-drugs:client:robberyCall", Player.PlayerData.source, msg, streetLabel, coords)
                TriggerClientEvent("qb-phone:client:addPoliceAlert", Player.PlayerData.source, alertData)
            end
        end
    end
end)

QBCore.Commands.Add("newdealer", Lang:t("info.newdealer_command_desc"), {{
    name = Lang:t("info.newdealer_command_help1_name"),
    help = Lang:t("info.newdealer_command_help1_help")
}, {
    name = Lang:t("info.newdealer_command_help2_name"),
    help = Lang:t("info.newdealer_command_help2_help")
}, {
    name = Lang:t("info.newdealer_command_help3_name"),
    help = Lang:t("info.newdealer_command_help3_help")
}}, true, function(source, args)
    local dealerName = args[1]
    local mintime = tonumber(args[2])
    local maxtime = tonumber(args[3])
    TriggerClientEvent('qb-drugs:client:CreateDealer', source, dealerName, mintime, maxtime)
end, "admin")

QBCore.Commands.Add("deletedealer", Lang:t("info.deletedealer_command_desc"), {{
    name = Lang:t("info.deletedealer_command_help1_name"),
    help = Lang:t("info.deletedealer_command_help1_help")
}}, true, function(source, args)
    local dealerName = args[1]
    local result = MySQL.Sync.fetchScalar('SELECT * FROM dealers WHERE name = ?', {dealerName})
    if result then
        MySQL.Async.execute('DELETE FROM dealers WHERE name = ?', {dealerName})
        Config.Dealers[dealerName] = nil
        TriggerClientEvent('qb-drugs:client:RefreshDealers', -1, Config.Dealers)
        TriggerClientEvent('QBCore:Notify', source, Lang:t("success.dealer_deleted", {dealerName = dealerName}), "success")
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.dealer_not_exists_command", {dealerName = dealerName}), "error")
    end
end, "admin")

QBCore.Commands.Add("dealers", Lang:t("info.dealers_command_desc"), {}, false, function(source, args)
    local DealersText = ""
    if Config.Dealers ~= nil and next(Config.Dealers) ~= nil then
        for k, v in pairs(Config.Dealers) do
            DealersText = DealersText .. Lang:t("info.list_dealers_name_prefix") .. v["name"] .. "<br>"
        end
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message advert"><div class="chat-message-body"><strong>'..Lang:t("info.list_dealers_title")..'</strong><br><br> ' .. DealersText .. '</div></div>',
            args = {}
        })
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.no_dealers"), 'error')
    end
end, "admin")

QBCore.Commands.Add("dealergoto", Lang:t("info.dealergoto_command_desc"), {{
    name = Lang:t("info.dealergoto_command_help1_name"),
    help = Lang:t("info.dealergoto_command_help1_help")
}}, true, function(source, args)
    local DealerName = tostring(args[1])

    if Config.Dealers[DealerName] ~= nil then
        TriggerClientEvent('qb-drugs:client:GotoDealer', source, Config.Dealers[DealerName])
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.dealer_not_exists"), 'error')
    end
end, "admin")

CreateThread(function()
    Wait(500)
    while true do
        local dealers = exports.oxmysql:executeSync('SELECT * FROM dealers', {})
        if dealers[1] ~= nil then
            for k, v in pairs(dealers) do
                local coords = json.decode(v.coords)
                local time = json.decode(v.time)
    
                Config.Dealers[v.name] = {
                    ["name"] = v.name,
                    ["coords"] = {
                        ["x"] = coords.x,
                        ["y"] = coords.y,
                        ["z"] = coords.z
                    },
                    ["time"] = {
                        ["min"] = time.min,
                        ["max"] = time.max
                    },
                    ["products"] = Config.Products
                }
            end
        end
        TriggerClientEvent('qb-drugs:client:RefreshDealers', -1, Config.Dealers)
        Wait(60000 * 90)
    end

end)

RegisterNetEvent('qb-drugs:server:CreateDealer', function(DealerData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.Sync.fetchAll('SELECT * FROM dealers WHERE name = ?', {DealerData.name})
    if result[1] ~= nil then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.dealer_already_exists"), "error")
    else
        MySQL.Async.insert('INSERT INTO dealers (name, coords, time, createdby) VALUES (?, ?, ?, ?)', {DealerData.name, json.encode(DealerData.pos), json.encode(DealerData.time), Player.PlayerData.citizenid}, function()
            Config.Dealers[DealerData.name] = {
                ["name"] = DealerData.name,
                ["coords"] = {
                    ["x"] = DealerData.pos.x,
                    ["y"] = DealerData.pos.y,
                    ["z"] = DealerData.pos.z
                },
                ["time"] = {
                    ["min"] = DealerData.time.min,
                    ["max"] = DealerData.time.max
                },
                ["products"] = Config.Products
            }

            TriggerClientEvent('qb-drugs:client:RefreshDealers', -1, Config.Dealers)
        end)
    end
end)

function GetDealers()
    return Config.Dealers
end


QBCore.Commands.Add('joinparty', 'Group up with others to share dealer XP', { name = 'ID', help = 'Player ID'}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Leader = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Leader ~= nil then
        if Leader.PlayerData.citizenid ~= Player.PlayerData.citizenid then
            -- send request 
                TriggerClientEvent('qb-drugs:client:sendRequestParty', src, Leader)
        else
            -- cant join yourself
            TriggerClientEvent('QBCore:Notify', src, 'You cannot join a party with yourself')
        end
    else
        -- person isnt online
        TriggerClientEvent('QBCore:Notify', src, 'Player not online')
    end
end)

QBCore.Commands.Add('stopparty', 'End your delivery party', {}, false, function(source, args)
    TriggerClientEvent('qb-drugs:client:endParty', source)
end)

QBCore.Commands.Add('leaveparty', 'Leave your delivery party', {}, false, function(source, args)
    TriggerClientEvent('qb-drugs:client:leavePlayerParty', source)
end)

QBCore.Commands.Add('partystatus', 'Leave your delivery party', {}, false, function(source, args)
    TriggerClientEvent('qb-drugs:client:printStatus', source)
end)

QBCore.Commands.Add('rep', 'End your delivery party', {}, false, function(source, args)
    TriggerClientEvent('qb-drugs:client:checkRep', source)
end)

RegisterNetEvent('qb-drugs:server:joinedParty')
AddEventHandler('qb-drugs:server:joinedParty', function(cid)
    local src = source
    local Leader = QBCore.Functions.GetPlayer(src)
    local Member = QBCore.Functions.GetPlayerByCitizenId(cid)
    local memberSource = Member.PlayerData.source
    -- notify member that they are in the party
    TriggerClientEvent('qb-drugs:client:notifyJoined', memberSource, Leader.PlayerData.citizenid)
end)

RegisterNetEvent('qb-drugs:server:endParticipants')
AddEventHandler('qb-drugs:server:endParticipants', function(Party)
    for i,v in pairs(Party) do
        local Member = QBCore.Functions.GetPlayerByCitizenId(v)
        local memberSrc = Member.PlayerData.source
        TriggerClientEvent("qb-drugs:client:leaveParty", memberSrc)
    end
end)

RegisterNetEvent('qb-drugs:server:leavePlayerParty')
AddEventHandler('qb-drugs:server:leavePlayerParty', function(cid)
    local Player = QBCore.Functions.GetPlayer(source)
    local pid = Player.PlayerData.citizenid
    local Leader = QBCore.Functions.GetPlayerByCitizenId(cid)
    local leaderSource = Leader.PlayerData.source
    TriggerClientEvent('qb-drugs:client:leftParty', leaderSource, pid)
end)


