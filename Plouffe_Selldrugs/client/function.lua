function GetPed()
	local ped = GetPlayerPed(-1)
	local pedCoords = GetEntityCoords(ped, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(pedCoords.x, pedCoords.y, pedCoords.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, ped, 7)
	local retval, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
	return entityHit, endCoords
end

function DrawText3D(x, y, z, text)
	local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x,y,z)
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

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
	    Wait(0)
	end
end
