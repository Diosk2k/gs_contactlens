-- update.lua

local currentVersion = '1.0.0'
local resourceName = GetCurrentResourceName()
local repoURL = 'https://api.github.com/repos/GokuWrks/gs_contactlens/releases/latest'

Citizen.CreateThread(function()
    Citizen.Wait(4000)

    PerformHttpRequest(repoURL, function(statusCode, response, headers)
        if statusCode == 200 and response then
            local latestRelease = json.decode(response)
            if latestRelease and latestRelease.tag_name and latestRelease.html_url then
                if latestRelease.tag_name ~= currentVersion then
                    print('[^3UPDATE^0] Eine neue Version von ^3' .. resourceName .. '^0 ist verfügbar! [^3Aktuelle Version^0] ^3' .. currentVersion ..'^0')
                    print('[^5DOWNLOAD^0] ^5' .. latestRelease.html_url ..'^0')
                else
                    print('[^4INFO^0] ^4' .. resourceName .. '^0 ist auf dem neuesten Stand. [^2VERSION^0] ^2' .. currentVersion .. '^0')
                    print('[^6DISCORD^0] Join dem ^6GS Designs^0 Discord! (^6https://discord.gg/8E3NGMAn2H^0)')
                end
            else
                print('^1[UPDATE] Fehler beim Parsen der GitHub-Antwort. Überprüfe das Format der GitHub-Release-Daten.^0')
            end
        else
            print('^1[UPDATE] Konnte nicht nach Updates suchen. Statuscode: ' .. tostring(statusCode) .. '^0')
            if response then
                print('^1[UPDATE] Antwort: ' .. tostring(response) .. '^0')
            else
                print('^1[UPDATE] Keine Antwort erhalten.^0')
            end
        end
    end, 'GET')
end)


