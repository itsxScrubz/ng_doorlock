---------------------------
-- Functions --
---------------------------
Utilities = {
	Anim = {
		Repeat = {
			Request = function(data)
				RequestAnimDict(data.dict)
				while not HasAnimDictLoaded(data.dict) do
					Citizen.Wait(0)
				end
			end,
			Check = function(data, player)
				return IsEntityPlayingAnim(player, data.dict, data.name, 3)
			end,
			Start = function(data, player)
				TaskPlayAnim(player, data.dict, data.name, data.blendin, data.blendout, data.duration, data.flag, data.pbr, 0, 0, 0)
			end,
		},
        Start = function(data, player, multi, p2)
            RequestAnimDict(data.dict)
            while not HasAnimDictLoaded(data.dict) do
                Citizen.Wait(0)
            end
			if multi then
                TaskPlayAnim(player, data.dict, data.name, data.blendin, data.blendout, data.duration, data.flag, data.pbr, 0, 0, 0)
                TaskPlayAnim(p2, data.dict, data.name, data.blendin, data.blendout, data.duration, data.flag, data.pbr, 0, 0, 0)
            else
                TaskPlayAnim(player, data.dict, data.name, data.blendin, data.blendout, data.duration, data.flag, data.pbr, 0, 0, 0)
            end
        end,
        End = function(data, player, multi, p2)
            if multi then
                StopAnimTask(player, data.dict, data.name, 1.0)
                StopAnimTask(p2, data.dict, data.name, 1.0)
            else
                StopAnimTask(player, data.dict, data.name, 1.0)
            end
		end
    },
	CheckJob = function(job, isAllowed)
		for k, v in pairs(isAllowed) do
			if job == v then
				return true
			end
			return false
		end
	end,
	AssignDoors = function(data, multi, value)
		if multi then
			if value == 1 then
				local model = nil
				for k, v in pairs(data.model) do
					if k == 1 then
						model = v
					end
					for m, n in pairs(data.pos) do
						if m == 1 then
							local door = GetClosestObjectOfType(n, data.dist + 0.0, GetHashKey(model), false, false, false)
							return door
						end
					end
				end
			else
				local model = nil
				for k, v in pairs(data.model) do
					if k == 2 then
						model = v
					end
					for m, n in pairs(data.pos) do
						if m == 2 then
							local door = GetClosestObjectOfType(n, data.dist + 0.0, GetHashKey(model), false, false, false)
							return door
						end
					end
				end
			end
		else
			if value == 1 then
				for k, v in pairs(data.pos) do
					if k == 1 then
						local door = GetClosestObjectOfType(v, data.dist + 0.0, GetHashKey(data.model), false, false, false)
						return door
					end
				end
			else
				for k, v in pairs(data.pos) do
					if k == 2 then
						local door = GetClosestObjectOfType(v, data.dist + 0.0, GetHashKey(data.model), false, false, false)
						return door
					end
				end
			end
		end
	end,
	HeadingCheck = function(pos1, pos2)
		if pos1 <= pos2 + 3
			and pos1 >= pos2 - 3
			then
			return true
		else
			return false
		end
	end,
	RoundNumber = function(num, numDecimalPlaces)
		local mult = 10^(numDecimalPlaces or 0)
		return math.floor(num * mult + 0.5) / mult
	end,
	DrawText = function(x, y, z, text)
		local onScreen, _x, _y = World3dToScreen2d(x,y,z)
        if onScreen then
            local factor = #text / 350
            SetTextScale(0.30, 0.30)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 215)
            SetTextEntry('STRING')
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x, _y)
            DrawRect(_x, _y + 0.0120, 0.006 + factor, 0.024, 0, 0, 0, 155)
        end
	end,
	DistanceCheck = function(pos1, pos2, rDist)
		if #(pos1 - pos2) <= rDist then
			return true
		end
		return false
    end,
	LockpickAnimation = function()
		local plyPed = GetPlayerPed(-1)
		FreezeEntityPosition(plyPed, true)
		if DoesEntityExist(plyPed) and not IsEntityDead(plyPed) then
			Utilities.Anim.Repeat.Request(Config.LockPickingAnim)
			repeat
				if not Utilities.Anim.Repeat.Check(Config.LockPickingAnim, plyPed) then
					Utilities.Anim.Repeat.Start(Config.LockPickingAnim, plyPed)
				end
				Citizen.Wait(1)
			until not Data.Player.Lockpicking
			FreezeEntityPosition(plyPed, false)
		end
	end
}

-- //Export - Use this to check if a ply is near a door when the lockpick item is used// --
-- //local isNearDoor = exports['ng_doorlock']:doorCheck()// --
-- //Used in conjuction with the vehicle system export: exports['ng_vehiclesystem']:isNearVehicle()// --
exports('doorCheck', function()
	local plyPed = GetPlayerPed(-1)
	local plyPos = GetEntityCoords(plyPed)
	for a = 1, #doorList do
        if doorList[a].location == Data.Current.Area then
            for b = 1, #doorList[a].doors do
                if Utilities.DistanceCheck(plyPos, doorList[a].doors[b].textPos, Config.LockpickDistance) then
                    if doorList[a].doors[b].isLocked
                        and doorList[a].doors[b].canPlyLockpick
						then
						return true
					end
				end
			end
		end
	end
	return false
end)

