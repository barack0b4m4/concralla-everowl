function getHunger()
    local currentHunger = tostring(getElementData(localPlayer, 'hunger'))
        return outputChatBox('Player has a hunger of '.. currentHunger ..'', localPlayer, 100, 100, 100)
end

addCommandHandler('gethunger', getHunger)