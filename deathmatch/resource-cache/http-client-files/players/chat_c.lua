-- define our chat radius
local chatRadius = 20 --units

-- define a handler that will distribute the message to all nearby players
function sendMessageToNearbyPlayers(message, messageType)
    -- we will only send normal chat messages, action and team types will be ignored
    if messageType == 0 then
        -- get the chatting player's position
        local posX1, posY1, posZ1 = getElementPosition(source)

        -- loop through all player and check distance
        for id, player in ipairs(getElementsByType("player")) do
            local posX2, posY2, posZ2 = getElementPosition(player)
            if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) <= chatRadius then
                outputChatBox(message, player)
            end
        end
    end
    -- block the original message by cancelling this event
    cancelEvent()
end
-- attach our new chat handler to onPlayerChat
addEventHandler( "onPlayerChat", getRootElement(), sendMessageToNearbyPlayers )