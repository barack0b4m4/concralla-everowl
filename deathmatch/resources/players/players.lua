setTime(12,0)
setMinuteDuration(10000000000)

addCommandHandler('clearchat', function(player)
    for i = 1, 16 do
        outputChatBox('', player)
    end
end, false, false)

addEventHandler('onPlayerJoin', root, function()

    triggerClientEvent(source, 'login-menu:open', source)

end)

function getPlayerFromAlias(callingPlayer, name)
    if name == nil then 
        outputChatBox('No such player found.', callingPlayer, 255, 100, 100)
        return false 
    end

   if name == '*' then 
    return callingPlayer
   end
   
    local player = getPlayerFromName(name)
    if player then 
        return player 
    end

    local players = {}
    for _, player in pairs(getElementsByType('player')) do
        if getPlayerName(player):find(name) then
            table.insert(players, player)
        end
    end
    if (#players== 1) then 
        return players[ 1 ]
    elseif #players == 0 then 
        outputChatBox('No such player found.', callingPlayer, 255, 100, 100)
        return false 
    else 
        outputChatBox('Multiple players found:', callingPlayer, 255, 100, 100)
        for _, player in pairs(players) do 
            outputChatBox('- ' .. getPlayerName(player), callingPlayer, 255, 100, 100)
        end
        return false
    end
end