local otherPed, hitPedCoords = nil, nil
local firstPed = nil
local price = nil
local rejectedPed = {}
local isSelling = false

Citizen.CreateThread(function()
    DecorRegister(SellDrugs.PriceDecor,1)

    while true do
        local ped = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped)
        local inCar = IsPedInAnyVehicle(ped,true)
        local sleepTimer = 5000
        
        for k,v in ipairs(SellDrugs.DrugsArray) do 
            local dstCheck = #(pedCoords - v.zone)
            if dstCheck <= v.range + 100 then
                sleepTimer = 1000
                if dstCheck <= v.range then
                    sleepTimer = 500
                    if inCar ~= 1 and not IsPedDeadOrDying(ped) then
                        sleepTimer = 0
                        otherPed, hitPedCoords = GetPed()
                        local pedType = GetPedType(otherPed)
                        if otherPed ~= 0 and otherPed ~= firstPed and not IsPedAPlayer(otherPed) and pedType ~= 28 and not IsPedDeadOrDying(otherPed) and not IsPedInMeleeCombat(ped) and not IsPedArmed(ped,7) then
                            local otherPedCoords = GetEntityCoords(otherPed)
                            local otherPedDstCheck = GetDistanceBetweenCoords(pedCoords, otherPedCoords)
                            if otherPedDstCheck <= 3 then

                                if not DecorExistOn(otherPed,SellDrugs.PriceDecor) then
                                    DrawText3D(otherPedCoords.x,otherPedCoords.y,otherPedCoords.z,SellDrugs.txt.not_decor)
                                else
                                    DrawText3D(otherPedCoords.x,otherPedCoords.y,otherPedCoords.z,SellDrugs.txt.has_decor..tostring(DecorGetInt(otherPed,SellDrugs.PriceDecor)))
                                end

                                if IsControlJustReleased(0,SellDrugs.Keys["E"]) and isSelling == false then

                                    if not DecorExistOn(otherPed,SellDrugs.PriceDecor) then
                                        local pedHeading = GetEntityHeading(ped)
                                        price = math.random(v.minPrice,v.maxPrice) * math.random(v.minMultiplier,v.maxMultiplier)
                                        SetEntityHeading(otherPed, pedHeading - 180)
                                        DecorSetInt(otherPed,SellDrugs.PriceDecor,price)
                                    else
                                        local percent = math.random(0,11)
                                        firstPed = otherPed

                                        if percent >= SellDrugs.PedReject then
                                            table.insert(rejectedPed, otherPed)
                                            exports['mythic_notify']:SendAlert('error', SellDrugs.txt.refused, 7000)
                                            if percent >= SellDrugs.CallPercent then
                                                TriggerServerEvent('Plouffe_SellDrugs:Alert',v.Zone)
                                            end
                                            ClearPedTasksImmediately(otherPed)
                                            SetPedAsNoLongerNeeded(otherPed)
                                        else
                                            isSelling = true
                                            local alreadySold = false

                                            for i = 1, #rejectedPed, 1 do 
                                                if rejectedPed[i] == otherPed then
                                                    alreadySold = true
                                                end
                                            end

                                            if alreadySold == false then
                                                table.insert(rejectedPed, otherPed)
                                                local pedHeading = GetEntityHeading(ped)
                                                local offSetCoords = GetOffsetFromEntityInWorldCoords(otherPed, 0.0, 0.0, 0.0)
                                                local savedOtherPedCoords = GetEntityCoords(otherPed)
                                                local savedPedCoords = GetEntityCoords(ped)

                                                SetEntityAsMissionEntity(otherPed)
                                                TaskStandStill(otherPed,13)
                                                Wait(100)
                                                SetEntityCoordsNoOffset(otherPed,offSetCoords.x,offSetCoords.y,offSetCoords.z)
                                                SetEntityHeading(otherPed, pedHeading - 180)
                                                loadAnimDict("reaction@intimidation@1h")
                                                TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 1.0, 1.0, -1, 01, 2, 0, 0, 0 )
                                                Wait(1500)
                                                StopAnimTask(ped, "reaction@intimidation@1h", "intro", 1.0)
                                                loadAnimDict("mp_ped_interaction")
                                                TaskPlayAnim(otherPed, "mp_ped_interaction", "handshake_guy_a", 1.0, 1.0, -1, 01, 2, 0, 0, 0 )
                                                TaskPlayAnim(ped, "mp_ped_interaction", "handshake_guy_a", 1.0, 1.0, -1, 01, 2, 0, 0, 0 )
                                                Wait(1500)
                                                ClearPedTasks(ped)
                                                Wait(1000)
                                                SetPedAsNoLongerNeeded(otherPed)
                                                TriggerServerEvent("Plouffe_SellDrugs:CheckSell",v.itemName,price)
                                                -- if SellDrugs.PedSetUp == percent then
                                                --     TriggerServerEvent('Bckekw_addons_gcphone:startCallAnonyme', 'police', SellDrugs.txt.policealert,nil)
                                                -- end
                                                isSelling = false
                                            else
                                                SetPedAsNoLongerNeeded(otherPed)
                                                exports['mythic_notify']:SendAlert('error', SellDrugs.txt.alreadysold, 7000)
                                                isSelling = false
                                            end
                                        end
                                    end

                                end
                            end
                        end
                    end
                end
            end
        end
        Wait(sleepTimer)
    end
end)

RegisterNetEvent("Plouffe_SellDrugs:NotEnough")
AddEventHandler("Plouffe_SellDrugs:NotEnough", function()
    SetEntityAsMissionEntity(otherPed)
    TaskCombatPed(otherPed,GetPlayerPed(-1),0,16)
    Wait(10000)
    SetPedAsNoLongerNeeded(otherPed)
end)