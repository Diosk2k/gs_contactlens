ESX = exports['es_extended']:getSharedObject()
local originalEyeColors = {}
local currentlyWearingContacts = {}

local function playAnimation(callback)
    local playerPed = PlayerPedId()
    local dict = Config.dict
    local anim = Config.anim
    local animationDuration = GetAnimDuration(dict, anim) * 1000

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end

    TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, -1, 50, 0, false, false, false)

    Citizen.Wait(animationDuration)
    ClearPedTasks(playerPed)

    if callback then
        callback()
    end
end

local function getTranslation(key, ...)
    local lang = Config.language
    local translation = Config.translations[lang][key]
    if translation then
        return string.format(translation, ...)
    else
        return key 
    end
end

RegisterNetEvent('gs_contactlens:applyContacts')
AddEventHandler('gs_contactlens:applyContacts', function(color, label)
    local playerPed = PlayerPedId()
    local playerId = GetPlayerServerId(PlayerId())

    if originalEyeColors[playerId] == nil then
        originalEyeColors[playerId] = GetPedEyeColor(playerPed)
    end

    local eyeColorConfig = Config.eyeColors[color]
    if eyeColorConfig ~= nil then
        playAnimation(function()
            SetPedEyeColor(playerPed, eyeColorConfig)
            currentlyWearingContacts[playerId] = color
            ESX.ShowNotification(getTranslation('applyContacts', label))
        end)
    else
        print(getTranslation('unknownColor', color))
    end
end)

RegisterNetEvent('gs_contactlens:removeContacts')
AddEventHandler('gs_contactlens:removeContacts', function()
    local playerPed = PlayerPedId()
    local playerId = GetPlayerServerId(PlayerId())

    if originalEyeColors[playerId] ~= nil then
        playAnimation(function()
            SetPedEyeColor(playerPed, originalEyeColors[playerId])
            originalEyeColors[playerId] = nil
            currentlyWearingContacts[playerId] = nil
            ESX.ShowNotification(getTranslation('removeContacts'))
        end)
    else
        ESX.ShowNotification(getTranslation('removeContacts'))
    end
end)

AddEventHandler('playerDropped', function(reason)
    local playerPed = PlayerPedId()
    local playerId = GetPlayerServerId(PlayerId())

    if originalEyeColors[playerId] ~= nil then
        SetPedEyeColor(playerPed, originalEyeColors[playerId])
    end
end)
