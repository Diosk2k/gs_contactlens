-- update.lua

local currentVersion = '1.0.0' 
local resourceName = GetCurrentResourceName()
local repoURL = 'https://api.github.com/repos/deinGitHubBenutzername/deinRepository/releases/latest'

PerformHttpRequest(repoURL, function(statusCode, response, headers)
    if statusCode == 200 then
        local latestRelease = json.decode(response)
        if latestRelease.tag_name ~= currentVersion then
            print('^1[UPDATE] Eine neue Version (' .. latestRelease.tag_name .. ') von ' .. resourceName .. ' ist verfügbar! Du verwendest Version ' .. currentVersion .. '.^0')
        else
            print('^2[UPDATE] ' .. resourceName .. ' ist auf dem neuesten Stand. Version: ' .. currentVersion .. '^0')
        end
    else
        print('^1[UPDATE] Konnte nicht nach Updates suchen. Statuscode: ' .. statusCode .. '^0')
    end
end, 'GET')
