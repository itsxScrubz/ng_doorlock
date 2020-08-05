---------------------------
-- Doorlist --
---------------------------
doorList = 
{
    {
        location = 'MRPD',  -- Not used in the script. Just used for door grouping.
        centralPos = vector3(449.27, -984.73, 30.69),
        distanceCheck = 60,  -- Distance used to grab all the doors in the area. MUST be large enough to cover all the doors for that building/area.
        doors =
        {
            {
                name = 'Chiefs Office',     -- Not used in the script. Just used to identify the door.
                jobs = {'POLICE'},     -- Jobs that can unlock/lock the door.
                doorModel = 'v_ilev_ph_gendoor002',  -- Door Model
                doorPos = vector3(446.57280, -980.01060, 30.83931),  -- Door Position
                textPos = vector3(447.21, -980.18, 30.69),  -- Text Position
                heading = 180.0,  -- The heading of the door when it's closed.
                isLocked = true,  -- Default lock status
                unlockDistance = 2.0,  -- Distance that both text is drawn, and how far away the player can be to unlock the door.
                canPlyLockpick = true,  -- Whether the door can be lockpicked.
                lockpickTime = 45000,  -- Amount of time it takes to lockpick the door.
                autoLock = true,  -- Whether the door will autolock if it's lockpicked.
                relock = false,  -- Used to signal that the door was lockpicked and will autolock again. This is so doors unlocked normally won't autolock.
                autoLockTimer = 5,  -- Time till the door autolocks in seconds
                autoLockCooldown = 0,  -- Autolock counter.
                lockAtNight = false  -- Whether the door will lock at night or not.
            },
            {
                name = 'Front Gate',
                jobs = {'POLICE'},
                doorModel = 'v_ilev_ph_gendoor005',
                doorPos = vector3(415.85000, -1025.08500, 28.15034),
                textPos = vector3(415.87, -1021.70, 29.32),
                heading = 269.0,
                isLocked = true,
                isGate = true,
                unlockDistance = 15.0,
                canPlyLockpick = false,
                lockpickTime = 45000,
                autoLock = true,
                relock = false,
                autoLockTimer = 120,
                autoLockCooldown = 0,
                lockAtNight = false
            },
            {
                name = 'Downstairs',
                jobs = {'POLICE'},
                doorModel = 'v_ilev_ph_gendoor005',
                doubleDoor = true,
                doorPos = {[1] = vector3(443.40780, -989.44540, 30.83931), [2] = vector3(446.00800, -989.44540, 30.83931)},
                textPos = vector3(444.72, -989.51, 30.69),
                heading1 = 180.0,
                heading2 = 0.0,
                isLocked = true,
                unlockDistance = 3.0,
                canPlyLockpick = true,
                lockpickTime = 45000,
                autoLock = true,
                relock = false,
                autoLockTimer = 120,
                autoLockCooldown = 0,
                lockAtNight = false
            },
            {
                name = 'Sallyport Gate',
                jobs = {'POLICE'},
                doorModel = 'hei_prop_station_gate',
                doorPos = vector3(488.89480, -1017.2100, 27.14651),
                textPos = vector3(488.89480, -1020.2100, 29.0),
                isLocked = true,
                isGate = true,
                unlockDistance = 13.0,
                canPlyLockpick = false,
                lockpickTime = 45000,
                autoLock = true,
                relock = false,
                autoLockTimer = 120,
                autoLockCooldown = 0,
                lockAtNight = false
            }
        }
    },
    {
        location = 'Clinton Residence - Forum Drive',
        centralPos = vector3(-14.31, -1443.82, 30.91),
        distanceCheck = 30,
        doors =
        {
            {
                name = 'Front Door',
                jobs = {'POLICE'},
                doorModel = 'v_ilev_fa_frontdoor',
                doorPos = vector3(-14.86892, -1441.18200, 31.19323),
                textPos = vector3(-14.12, -1441.06, 31.19),
                heading = 180.0,
                isLocked = true,
                unlockDistance = 3.0,
                canPlyLockpick = true,
                lockpickTime = 45000,
                autoLock = true,
                relock = false,
                autoLockTimer = 120,
                autoLockCooldown = 0,
                lockAtNight = false
            },
            {
                name = 'Garage Door',
                jobs = {'POLICE'},
                doorModel = 'prop_sc1_21_g_door_01',
                doorPos = vector3(-25.27840, -1431.06600, 30.86086),
                textPos = vector3(-25.28, -1431.44, 30.65),
                heading = 0.0,
                isLocked = true,
                isGate = true,
                unlockDistance = 12.0,
                canPlyLockpick = true,
                lockpickTime = 45000,
                autoLock = true,
                relock = false,
                autoLockTimer = 120,
                autoLockCooldown = 0,
                lockAtNight = false
            }
        }
    },
    {
        location = 'PDM',
        centralPos = vector3(-42.31, -1098.81, 26.42),
        distanceCheck = 30,
        doors =
        {
            {
                name = 'DoubleDoorSide',
                jobs = {'POLICE'},
                multiModel = true,
                doubleDoor = true,
                doorModel = {[1] = 'v_ilev_csr_door_l', [2] = 'v_ilev_csr_door_r'},
                doorPos = {[1] = vector3(-59.89302, -1092.95200, 26.88362), [2] = vector3(-60.54582, -1094.74900, 26.88872)},
                textPos = vector3(-60.09, -1093.87, 26.67),
                heading1 = 250.0,
                heading2 = -110.0,
                isLocked = true,
                unlockDistance = 4.0,
                canPlyLockpick = true,
                lockpickTime = 45000,
                autoLock = true,
                relock = false,
                autoLockTimer = 120,
                autoLockCooldown = 0,
                lockAtNight = false
            }
        }
    }
}