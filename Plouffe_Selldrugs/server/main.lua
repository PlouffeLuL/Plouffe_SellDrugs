RegisterServerEvent("Plouffe_SellDrugs:CheckSell")
AddEventHandler("Plouffe_SellDrugs:CheckSell", function(item,price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local itemCount = xPlayer.getInventoryItem(item).count
    
    if itemCount >= 1 then
        xPlayer.removeInventoryItem(item, 1)
        xPlayer.addAccountMoney('black_money', price)
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = SellDrugs.txt.sold.. tostring(price).." $", length = 6000 })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = SellDrugs.txt.notenough, length = 6000 })
        TriggerClientEvent("Plouffe_SellDrugs:NotEnough", _source)
    end

end)

RegisterServerEvent("Plouffe_SellDrugs:Alert")
AddEventHandler("Plouffe_SellDrugs:Alert",function(zone)
    local xPlayers = ESX.GetPlayers()

    for i = 1, # xPlayers, 1 do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer then
            if xPlayer.job.name == "police" then
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer, { type = 'error', text = SellDrugs.txt.policealert..tostring(zone), length = 9000 })
            end
        end
    end
end)