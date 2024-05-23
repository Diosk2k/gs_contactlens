-- update.lua

local currentVersion = '1.0.0'
local resourceName = GetCurrentResourceName()
local repoURL = 'https://api.github.com/repos/GokuWrks/gs_contactlens/releases/latest'

PerformHttpRequest(repoURL, function(statusCode, response, headers)
    if statusCode == 200 and response then
        local latestRelease = json.decode(response)
        if latestRelease and latestRelease.tag_name and latestRelease.html_url then
            if latestRelease.tag_name ~= currentVersion then
                print('[^3UPDATE^0] Eine neue Version von ' .. resourceName .. ' ist verfügbar!')
                print('^3Aktuelle Version^0: ' .. currentVersion ..)
                print('^3Neue Version^0: ' .. latestRelease.tag_name ..)
                print('[^3Download-Link^0]: ' .. latestRelease.html_url ..)
            else
                print('^2[UPDATE] ' .. resourceName .. ' ist auf dem neuesten Stand. Version: ' .. currentVersion .. '^0')
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

