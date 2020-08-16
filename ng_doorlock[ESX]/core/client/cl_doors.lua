---------------------------
-- Variables --
---------------------------
-- //©_Scrubz#0001_© ^_^// --
-- //NextGen Framework Public Release// --
ESX = nil
Data = {
    Current = {
        Area = nil,
        Doors = {}
    },
    Player = {
        IsLoaded = false,
        Job = nil
    },
    Utilities = {
        IsNight = false,
        Active = false
    }
}

---------------------------
-- Threads --
---------------------------
-- //Lock At Night// --
function lockAtNight()
    local time = GetClockHours()
    if time >= 7
        and time <= 19
        then
        if Data.Utilities.IsNight then
            for a = 1, #doorList do
                for b = 1, #doorList[a].doors do
                    if doorList[a].doors[b].lockAtNight
                        and doorList[a].doors[b].isLocked
                        then
                        doorList[a].doors[b].isLocked = false
                    end
                end
            end
            Data.Utilities.IsNight = false
            TriggerServerEvent('ng_doorlock_sv:lockAtNight', Data.Utilities.IsNight)
        end
    else
        if not Data.Utilities.IsNight then
            for a = 1, #doorList do
                for b = 1, #doorList[a].doors do
                    if doorList[a].doors[b].lockAtNight
                        and not doorList[a].doors[b].isLocked
                        then
                        doorList[a].doors[b].isLocked = true
                    end
                end
            end
            Data.Utilities.IsNight = true
            TriggerServerEvent('ng_doorlock_sv:lockAtNight', Data.Utilities.IsNight)
        end
    end
    SetTimeout(5000, lockAtNight)
end
lockAtNight()

-- //NO TOUCHY// --
function locationCheck()
    local plyPed = GetPlayerPed(-1)
    local plyPos = GetEntityCoords(plyPed)
    local reset = true
    for i = 1, #doorList do
        local isNear = #(plyPos - doorList[i].centralPos)
        if isNear <= doorList[i].distanceCheck then
            reset = false
            if Data.Current.Area == nil
                or Data.Current.Area ~= doorList[i].location
                then
                Data.Current.Doors = doorList[i].doors
                Data.Current.Area = doorList[i].location
            end
        end
    end
    if reset then
        if Data.Current.Area ~= nil then
            Data.Current.Doors = {}
            Data.Current.Area = nil
        end
    end
    SetTimeout(250, locationCheck)
end
locationCheck()

-- Meh.
function disableFuccBoisFromShootingLockedDoorsOpen()
    if Data.Current.Area ~= nil then
        for i = 1, #Data.Current.Doors do
            local doorSingle = nil
            local door1 = nil
            local door2 = nil
            if Data.Current.Doors[i].isGate then
                local gate = GetClosestObjectOfType(Data.Current.Doors[i].doorPos, Data.Current.Doors[i].unlockDistance + 0.0, GetHashKey(Data.Current.Doors[i].doorModel), false, false, false)
                FreezeEntityPosition(gate, Data.Current.Doors[i].isLocked)
            else
                if Data.Current.Doors[i].doubleDoor then
                    if Data.Current.Doors[i].multiModel then
                        local model1 = nil
                        local model2 = nil
                        for k, v in pairs(Data.Current.Doors[i].doorModel) do
                            if k == 1 then
                                model1 = v
                            elseif k == 2 then
                                model2 = v
                            end
                            for m, n in pairs(Data.Current.Doors[i].doorPos) do
                                if k == 1 then
                                    if door1 == nil then
                                        door1 = GetClosestObjectOfType(n, Data.Current.Doors[i].unlockDistance + 0.0, GetHashKey(model1), false, false, false)
                                    end
                                    local currentHeading1 = GetEntityHeading(door1)
                                    if currentHeading1 ~= Data.Current.Doors[i].heading1 then
                                        if Data.Current.Doors[i].isLocked then
                                            SetEntityRotation(door1, 0, 0, Data.Current.Doors[i].heading1)
                                        end
                                    end
                                    FreezeEntityPosition(door1, Data.Current.Doors[i].isLocked)
                                elseif k == 2 then
                                    if door2 == nil then
                                        door2 = GetClosestObjectOfType(n, Data.Current.Doors[i].unlockDistance + 0.0, GetHashKey(model2), false, false, false)
                                    end
                                    local currentHeading2 = GetEntityHeading(door2)
                                    if currentHeading2 ~= Data.Current.Doors[i].heading2 then
                                        if Data.Current.Doors[i].isLocked then
                                            SetEntityRotation(door2, 0, 0, Data.Current.Doors[i].heading2)
                                        end
                                    end
                                    FreezeEntityPosition(door2, Data.Current.Doors[i].isLocked)
                                end
                            end
                        end
                    else
                        for k, v in pairs(Data.Current.Doors[i].doorPos) do
                            if k == 1 then
                                if door1 == nil then
                                    door1 = GetClosestObjectOfType(v, Data.Current.Doors[i].unlockDistance + 0.0, GetHashKey(Data.Current.Doors[i].doorModel), false, false, false)
                                end
                                local currentHeading1 = GetEntityHeading(door1)
                                if currentHeading1 ~= Data.Current.Doors[i].heading1 then
                                    if Data.Current.Doors[i].isLocked then
                                        SetEntityRotation(door1, 0, 0, Data.Current.Doors[i].heading1)
                                    end
                                end
                                FreezeEntityPosition(door1, Data.Current.Doors[i].isLocked)
                            elseif k == 2 then
                                if door2 == nil then
                                    door2 = GetClosestObjectOfType(v, Data.Current.Doors[i].unlockDistance + 0.0, GetHashKey(Data.Current.Doors[i].doorModel), false, false, false)
                                end
                                local currentHeading2 = GetEntityHeading(door2)
                                if currentHeading2 ~= Data.Current.Doors[i].heading2 then
                                    if Data.Current.Doors[i].isLocked then
                                        SetEntityRotation(door2, 0, 0, Data.Current.Doors[i].heading2)
                                    end
                                end
                                FreezeEntityPosition(door2, Data.Current.Doors[i].isLocked)
                            end
                        end
                    end
                else
                    if doorSingle == nil then
                        doorSingle = GetClosestObjectOfType(Data.Current.Doors[i].doorPos, Data.Current.Doors[i].unlockDistance + 0.0, GetHashKey(Data.Current.Doors[i].doorModel), false, false, false)
                    end
                    local currentHeading = GetEntityHeading(doorSingle)
                    if currentHeading ~= Data.Current.Doors[i].heading then
                        if Data.Current.Doors[i].isLocked then
                            SetEntityRotation(doorSingle, 0, 0, Data.Current.Doors[i].heading)
                        end
                    end
                    FreezeEntityPosition(doorSingle, Data.Current.Doors[i].isLocked)
                end
            end
        end
    end
    SetTimeout(500, disableFuccBoisFromShootingLockedDoorsOpen)
end
disableFuccBoisFromShootingLockedDoorsOpen()

-- //ESX Stuffs// --
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(50)
    end
    while ESX.IsPlayerLoaded() == false do
        Citizen.Wait(5)
    end
    ESX.PlayerData = ESX.GetPlayerData()
    Data.Player.Job = ESX.PlayerData.job.name
    TriggerServerEvent('ng_doorlock_sv:syncDoors')
end)

-- //Main Thread// --
Citizen.CreateThread(function()
    while true do
        local plyPed = GetPlayerPed(-1)
        local sleep = 250
        if Data.Current.Area ~= nil then
            sleep = 25
            local plyPos = GetEntityCoords(plyPed)
            for i = 1, #Data.Current.Doors do
                if Utilities.DistanceCheck(plyPos, Data.Current.Doors[i].textPos, Data.Current.Doors[i].unlockDistance) then
                    sleep = 4
                    if Data.Current.Doors[i].doubleDoor then
                        if Data.Current.Doors[i].isLocked then
                            if Utilities.CheckJob(Data.Player.Job, Data.Current.Doors[i].jobs) then
                                Utilities.DrawText(Data.Current.Doors[i].textPos.x, Data.Current.Doors[i].textPos.y, Data.Current.Doors[i].textPos.z, Config.JobLocked)
                            else
                                Utilities.DrawText(Data.Current.Doors[i].textPos.x, Data.Current.Doors[i].textPos.y, Data.Current.Doors[i].textPos.z, Config.Locked)
                            end
                        else
                            if Utilities.CheckJob(Data.Player.Job, Data.Current.Doors[i].jobs) then
                                Utilities.DrawText(Data.Current.Doors[i].textPos.x, Data.Current.Doors[i].textPos.y, Data.Current.Doors[i].textPos.z, Config.JobUnlocked)
                            else
                                Utilities.DrawText(Data.Current.Doors[i].textPos.x, Data.Current.Doors[i].textPos.y, Data.Current.Doors[i].textPos.z, Config.Unlocked)
                            end
                        end
                        if IsControlJustReleased(1, 38) then  -- Key: E
                            if Utilities.CheckJob(Data.Player.Job, Data.Current.Doors[i].jobs) then
                                Utilities.Anim.Start(Config.RemoteAnim, plyPed, false)
                                if not Data.Current.Doors[i].isLocked then
                                    local info = {pos = Data.Current.Doors[i].doorPos, dist = Data.Current.Doors[i].unlockDistance, model = Data.Current.Doors[i].doorModel}
                                    local door1 = nil
                                    local door2 = nil
                                    if type(Data.Current.Doors[i].doorModel) == 'table' then
                                        door1 = Utilities.AssignDoors(info, true, 1)
                                        door2 = Utilities.AssignDoors(info, true, 2)
                                    else
                                        door1 = Utilities.AssignDoors(info, false, 1)
                                        door2 = Utilities.AssignDoors(info, false, 2)
                                    end
                                    Data.Utilities.Active = true
                                    local lockCount = 0
                                    while Data.Utilities.Active do
                                        Citizen.Wait(1)
                                        lockCount = lockCount + 1
                                        local currentHeading1 = GetEntityHeading(door1)
                                        local rounded1 = Utilities.RoundNumber(currentHeading1, 0)
                                        local currentHeading2 = GetEntityHeading(door2)
                                        local rounded2 = Utilities.RoundNumber(currentHeading2, 0)
                                        Utilities.DrawText(Data.Current.Doors[i].textPos.x, Data.Current.Doors[i].textPos.y, Data.Current.Doors[i].textPos.z, Config.LockingDoor)
                                        if lockCount >= 500 then
                                            Data.Utilities.Active = false
                                            SetEntityRotation(door1, 0, 0, Data.Current.Doors[i].heading1)
                                            SetEntityRotation(door2, 0, 0, Data.Current.Doors[i].heading2)
                                        end
                                        if Utilities.HeadingCheck(rounded1, Data.Current.Doors[i].heading1)
                                            and Utilities.HeadingCheck(rounded2, Data.Current.Doors[i].heading2)
                                            then
                                            Data.Utilities.Active = false
                                            SetEntityRotation(door1, 0, 0, Data.Current.Doors[i].heading1)
                                            SetEntityRotation(door2, 0, 0, Data.Current.Doors[i].heading2)
                                        end
                                    end
                                else
                                    local timer = 175
                                    while timer ~= 0 do
                                        Citizen.Wait(1)
                                        timer = timer - 1
                                        Utilities.DrawText(Data.Current.Doors[i].textPos.x, Data.Current.Doors[i].textPos.y, Data.Current.Doors[i].textPos.z, Config.UnlockingDoor)
                                    end
                                end
                                local cDoorPos = Data.Current.Doors[i].textPos
                                for a = 1, #doorList do
                                    if doorList[a].location == Data.Current.Area then
                                        for b = 1, #doorList[a].doors do
                                            if doorList[a].doors[b].textPos == cDoorPos then
                                                doorList[a].doors[b].isLocked = not doorList[a].doors[b].isLocked
                                                TriggerServerEvent('ng_doorlock_sv:setState', Data.Current.Area, cDoorPos, doorList[a].doors[b].isLocked, true)
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if Data.Current.Doors[i].isLocked then
                            if Utilities.CheckJob(Data.Player.Job, Data.Current.Doors[i].jobs) then
                                Utilities.DrawText(Data.Current.Doors[i].textPos.x, Data.Current.Doors[i].textPos.y, Data.Current.Doors[i].textPos.z, Config.JobLocked)
                            else
                                Utilities.DrawText(Data.Current.Doors[i].textPos.x, Data.Current.Doors[i].textPos.y, Data.Current.Doors[i].textPos.z, Config.Locked)
                            end
                        else
                            if Utilities.CheckJob(Data.Player.Job, Data.Current.Doors[i].jobs) then
                                Utilities.DrawText(Data.Current.Doors[i].textPos.x, Data.Current.Doors[i].textPos.y, Data.Current.Doors[i].textPos.z, Config.JobUnlocked)
                            else
                                Utilities.DrawText(Data.Current.Doors[i].textPos.x, Data.Current.Doors[i].textPos.y, Data.Current.Doors[i].textPos.z, Config.Unlocked)
                            end
                        end
                        if IsControlJustReleased(1, 38) then  -- Key: E
                            if Utilities.CheckJob(Data.Player.Job, Data.Current.Doors[i].jobs) then
                                Utilities.Anim.Start(Config.RemoteAnim, plyPed, false)
                                if not Data.Current.Doors[i].isLocked then
                                    local doorSingle = GetClosestObjectOfType(Data.Current.Doors[i].doorPos, Data.Current.Doors[i].unlockDistance + 0.0, GetHashKey(Data.Current.Doors[i].doorModel), false, false, false)
                                    if not Data.Current.Doors[i].isGate then
                                        Data.Utilities.Active = true
                                        local lockCount = 0
                                        while Data.Utilities.Active do
                                            Citizen.Wait(1)
                                            lockCount = lockCount + 1
                                            local currentHeading = GetEntityHeading(doorSingle)
                                            local rounded = Utilities.RoundNumber(currentHeading, 0)
                                            Utilities.DrawText(Data.Current.Doors[i].textPos.x, Data.Current.Doors[i].textPos.y, Data.Current.Doors[i].textPos.z, Config.LockingDoor)
                                            if lockCount >= 500 then
                                                Data.Utilities.Active = false
                                                SetEntityRotation(doorSingle, 0, 0, Data.Current.Doors[i].heading)
                                            end
                                            if Utilities.HeadingCheck(rounded, Data.Current.Doors[i].heading) then
                                                Data.Utilities.Active = false
                                            end
                                        end
                                    end
                                else
                                    local timer = 175
                                    while timer ~= 0 do
                                        Citizen.Wait(1)
                                        timer = timer - 1
                                        Utilities.DrawText(Data.Current.Doors[i].textPos.x, Data.Current.Doors[i].textPos.y, Data.Current.Doors[i].textPos.z, Config.UnlockingDoor)
                                    end
                                end
                                local cDoorPos = Data.Current.Doors[i].doorPos
                                for a = 1, #doorList do
                                    if doorList[a].location == Data.Current.Area then
                                        for b = 1, #doorList[a].doors do
                                            if doorList[a].doors[b].doorPos == cDoorPos then
                                                doorList[a].doors[b].isLocked = not doorList[a].doors[b].isLocked
                                                TriggerServerEvent('ng_doorlock_sv:setState', Data.Current.Area, cDoorPos, doorList[a].doors[b].isLocked, false)
                                                break
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
        Citizen.Wait(sleep)
    end
end)

---------------------------
-- Event Handlers --
---------------------------
-- //Syncing Client List with Master List// --
RegisterNetEvent('ng_doorlock_cl:syncDoors')
AddEventHandler('ng_doorlock_cl:syncDoors', function(table)
    for k, v in pairs(table) do
        for m, n in pairs(v.doors) do
            doorList[k].doors[m].isLocked = n.isLocked
        end
    end
end)

-- //Lock/Unlock Toggle// --
RegisterNetEvent('ng_doorlock_cl:setState')
AddEventHandler('ng_doorlock_cl:setState', function(area, pos, status, doubleDoor)
    local cArea = area
    local cPos = pos
    local cStatus = status
    if doubleDoor then
        for a = 1, #doorList do
            if doorList[a].location == cArea then
                for b = 1, #doorList[a].doors do
                    if doorList[a].doors[b].textPos == cPos then
                        doorList[a].doors[b].isLocked = cStatus
                    end
                end
            end
        end
    else
        for a = 1, #doorList do
            if doorList[a].location == cArea then
                for b = 1, #doorList[a].doors do
                    if doorList[a].doors[b].doorPos == cPos then
                        doorList[a].doors[b].isLocked = cStatus
                    end
                end
            end
        end
    end
end)

-- //Lockpick Stuffs// --
RegisterNetEvent('ng_doorlock_cl:startLockpick')
AddEventHandler('ng_doorlock_cl:startLockpick', function()
    local plyPed = GetPlayerPed(-1)
	local plyPos = GetEntityCoords(plyPed)
    for a = 1, #doorList do
        if doorList[a].location == Data.Current.Area then
            for b = 1, #doorList[a].doors do
                if Utilities.DistanceCheck(plyPos, doorList[a].doors[b].textPos, Config.LockpickDistance) then
                    if doorList[a].doors[b].isLocked
                        and doorList[a].doors[b].canPlyLockpick
                        then
                        Data.Player.Lockpicking = true
                        local data = {
                            name = Config.LockpickText,
                            time = 5000,
                            dead = false,
                            cancel = false,
                            freeze = {
                                ped = false,
                                car = false,
                                camera = false
                            }
                        }
                        exports['ng_progressbar']:Start(data, function(cancelled)
                            if not cancelled then
                            if doorList[a].doors[b].autoLock then
                                Data.Player.Lockpicking = false
                                local cDoorPos = doorList[a].doors[b].doorPos
                                TriggerServerEvent('ng_doorlock_sv:autoLock', Data.Current.Area, cDoorPos)
                            else
                                Data.Player.Lockpicking = false
                                local cDoorPos = doorList[a].doors[b].doorPos
                                TriggerServerEvent('ng_doorlock_sv:setState', Data.Current.Area, cDoorPos, false)
                            end
                            end
                        end)
                        Utilities.LockpickAnimation()
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
    Citizen.Wait(500)
    Data.Player.Job = ESX.PlayerData.job.name
end)

-- //Used for testing// --
-- RegisterCommand('devlockpick', function(source, args, raw)
--     if doorCheck() then
--         TriggerEvent('ng_doorlock_cl:startLockpick')
--     end
-- end)


