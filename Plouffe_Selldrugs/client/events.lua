
Citizen.CreateThread(function()    
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    
    SellDrugs.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	SellDrugs.PlayerData.job = job
	Wait(5000)
end)
