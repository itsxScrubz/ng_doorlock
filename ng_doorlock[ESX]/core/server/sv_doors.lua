---------------------------
-- Variables --
---------------------------
ESX = nil
local doorInfo = {}
local isNight = false


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

---------------------------
-- Threads --
---------------------------
-- //Auto Locking// --
function autoLock()
    for a = 1, #doorInfo do
        for b = 1, #doorInfo[a].doors do
            if doorInfo[a].doors[b].autoLock
                and not doorInfo[a].doors[b].isLocked
                and doorInfo[a].doors[b].relock
                then
                if doorInfo[a].doors[b].autoLockCooldown <= 0 then
                    doorInfo[a].doors[b].isLocked = true
                    doorInfo[a].doors[b].autoLockCooldown = 0
                    doorInfo[a].doors[b].relock = false
                    local area = doorInfo[a].location
                    local pos = doorInfo[a].doors[b].doorPos
                    TriggerClientEvent('ng_doorlock_cl:setState', -1, area, pos, true)
                else
                    doorInfo[a].doors[b].autoLockCooldown = doorInfo[a].doors[b].autoLockCooldown - 5
                end
            end
        end
    end
    -- Function runs every 5 seconds
    SetTimeout(5000, autoLock)
end
autoLock()

---------------------------
-- Event Handlers --
---------------------------
-- //Setting Master List// --
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        doorInfo = doorList
    end
end)

-- //Syncing on Join// --
RegisterServerEvent('ng_doorlock_sv:syncDoors')
AddEventHandler('ng_doorlock_sv:syncDoors', function()
	TriggerClientEvent('ng_doorlock_cl:syncDoors', source, doorInfo)
end)

-- //Lock/Unlock Toggle// --
RegisterServerEvent('ng_doorlock_sv:setState')
AddEventHandler('ng_doorlock_sv:setState', function(area, pos, status, doubleDoor)
    local cArea = area
    local cPos = pos
    local cStatus = status
    if doubleDoor then
        for a = 1, #doorInfo do
            if doorInfo[a].location == cArea then
                for b = 1, #doorInfo[a].doors do
                    if doorInfo[a].doors[b].textPos == cPos then
                        doorInfo[a].doors[b].isLocked = status
                    end
                end
            end
        end
        TriggerClientEvent('ng_doorlock_cl:setState', -1, cArea, cPos, cStatus, true)
    else
        for a = 1, #doorInfo do
            if doorInfo[a].location == cArea then
                for b = 1, #doorInfo[a].doors do
                    if doorInfo[a].doors[b].doorPos == cPos then
                        doorInfo[a].doors[b].isLocked = status
                    end
                end
            end
        end
        TriggerClientEvent('ng_doorlock_cl:setState', -1, cArea, cPos, cStatus, false)
    end
end)

-- //Locking at Night// --
RegisterServerEvent('ng_doorlock_sv:lockAtNight')
AddEventHandler('ng_doorlock_sv:lockAtNight', function(toggle)
    if toggle then
        if not isNight then
            for a = 1, #doorInfo do
                for b = 1, #doorInfo[a].doors do
                    if doorInfo[a].doors[b].lockAtNight
                        and not doorInfo[a].doors[b].isLocked
                        and not isNight
                        then
                        doorInfo[a].doors[b].isLocked = true
                    end
                end
            end
            isNight = true
        end
    else
        if isNight then
            for a = 1, #doorInfo do
                for b = 1, #doorInfo[a].doors do
                    if doorInfo[a].doors[b].lockAtNight
                        and doorInfo[a].doors[b].isLocked
                        and isNight
                        then
                        doorInfo[a].doors[b].isLocked = false
                    end
                end
            end
            isNight = false
        end
    end
end)

-- //Autolock Event// --
RegisterServerEvent('ng_doorlock_sv:autoLock')
AddEventHandler('ng_doorlock_sv:autoLock', function(area, pos)
    for a = 1, #doorInfo do
        if doorInfo[a].location == area then
            for b = 1, #doorInfo[a].doors do
                if doorInfo[a].doors[b].doorPos == pos then
                    doorInfo[a].doors[b].isLocked = false
                    doorInfo[a].doors[b].autoLockCooldown = doorInfo[a].doors[b].autoLockTimer
                    doorInfo[a].doors[b].relock = true
                end
            end
        end
    end
	TriggerClientEvent('ng_doorlock_cl:setState', -1, area, pos, false)
end)
