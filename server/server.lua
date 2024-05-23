ESX = exports['es_extended']:getSharedObject()
local currentlyWearingContacts = {}

local contactLenses = {
    {name = 'green_contacts', label = 'Green Contact Lenses', color = 'green'},
    {name = 'emerald_contacts', label = 'Emerald Contact Lenses', color = 'emerald'},
    {name = 'light_blue_contacts', label = 'Light Blue Contact Lenses', color = 'lightBlue'},
    {name = 'ocean_blue_contacts', label = 'Ocean Blue Contact Lenses', color = 'oceanBlue'},
    {name = 'light_brown_contacts', label = 'Light Brown Contact Lenses', color = 'lightBrown'},
    {name = 'dark_brown_contacts', label = 'Dark Brown Contact Lenses', color = 'darkBrown'},
    {name = 'hazel_contacts', label = 'Hazel Contact Lenses', color = 'hazel'},
    {name = 'dark_gray_contacts', label = 'Dark Gray Contact Lenses', color = 'darkGray'},
    {name = 'light_gray_contacts', label = 'Light Gray Contact Lenses', color = 'lightGray'},
    {name = 'pink_contacts', label = 'Pink Contact Lenses', color = 'pink'},
    {name = 'yellow_contacts', label = 'Yellow Contact Lenses', color = 'yellow'},
    {name = 'purple_contacts', label = 'Purple Contact Lenses', color = 'purple'},
    {name = 'blackout_contacts', label = 'Blackout Contact Lenses', color = 'blackout'},
    {name = 'shades_of_gray_contacts', label = 'Shades of Gray Contact Lenses', color = 'shadesofGray'},
    {name = 'tequila_sunrise_contacts', label = 'Tequila Sunrise Contact Lenses', color = 'tequilaSunrise'},
    {name = 'atomic_contacts', label = 'Atomic Contact Lenses', color = 'atomic'},
    {name = 'warp_contacts', label = 'Warp Contact Lenses', color = 'warp'},
    {name = 'ecola_contacts', label = 'ECola Contact Lenses', color = 'eCola'},
    {name = 'space_ranger_contacts', label = 'Space Ranger Contact Lenses', color = 'spaceRanger'},
    {name = 'ying_yang_contacts', label = 'Ying Yang Contact Lenses', color = 'yingYang'},
    {name = 'bullseye_contacts', label = 'Bullseye Contact Lenses', color = 'bullseye'},
    {name = 'lizard_contacts', label = 'Lizard Contact Lenses', color = 'lizard'},
    {name = 'dragon_contacts', label = 'Dragon Contact Lenses', color = 'dragon'},
    {name = 'extra_terrestrial_contacts', label = 'Extra Terrestrial Contact Lenses', color = 'extraTerrestrial'},
    {name = 'goat_contacts', label = 'Goat Contact Lenses', color = 'goat'},
    {name = 'smiley_contacts', label = 'Smiley Contact Lenses', color = 'smiley'},
    {name = 'possessed_contacts', label = 'Possessed Contact Lenses', color = 'possessed'},
    {name = 'demon_contacts', label = 'Demon Contact Lenses', color = 'demon'},
    {name = 'infected_contacts', label = 'Infected Contact Lenses', color = 'infected'},
    {name = 'alien_contacts', label = 'Alien Contact Lenses', color = 'alien'},
    {name = 'undead_contacts', label = 'Undead Contact Lenses', color = 'undead'},
    {name = 'zombie_contacts', label = 'Zombie Contact Lenses', color = 'zombie'}
}

for _, contact in ipairs(contactLenses) do
    ESX.RegisterUsableItem(contact.name, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        local playerId = xPlayer.source

        if currentlyWearingContacts[playerId] == nil then
            TriggerClientEvent('gs_contactlens:applyContacts', source, contact.color, contact.label)
            currentlyWearingContacts[playerId] = contact.name
        elseif currentlyWearingContacts[playerId] == contact.name then
            TriggerClientEvent('gs_contactlens:removeContacts', source)
            currentlyWearingContacts[playerId] = nil
        else
            TriggerClientEvent('esx:showNotification', source, 'You are already wearing contact lenses.')
        end
    end)
end

AddEventHandler('playerDropped', function(reason)
    local playerId = source
    if currentlyWearingContacts[playerId] ~= nil then
        TriggerClientEvent('gs_contactlens:removeContacts', playerId)
        currentlyWearingContacts[playerId] = nil
    end
end)
