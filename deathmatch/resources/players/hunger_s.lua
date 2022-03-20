local function getHunger(source, commandName, playerName)
    local player = getPlayerFromName(playerName)
    local currentHunger = getElementData(player, 'hunger')
        return outputChatBox('Player has a hunger of '.. tostring(currentHunger) ..'', source, 100, 100, 100)
end

addCommandHandler('gethunger', getHunger)

local function myHunger(source, commandName)
    local player = source
    local currentHunger = getElementData(player, 'hunger')
        return outputChatBox('You have a hunger of '.. tostring(currentHunger) ..'', source, 255, 255, 255)
end

addCommandHandler('hunger', myHunger)

function increaseHunger(player)
    local currentHunger = getElementData(player, 'hunger')
    if currentHunger < 0 then
        setElementData(player, 'hunger', 0)
    elseif currentHunger >= 0 then
    setElementData(player, 'hunger', currentHunger + 20)
    end
end

function increaseplayerHunger(source, commandName, playerName)
    local player = getPlayerFromName(playerName)
    local currentHunger = getElementData(player, 'hunger')
    if currentHunger < 0 then
        setElementData(player, 'hunger', 0)
    elseif currentHunger >= 0 then
    setElementData(player, 'hunger', currentHunger + 20)
    end
end

addCommandHandler('hungry', increaseplayerHunger)

function execHunger()
    setTimer(execHunger, 36000000, 1)
    for _, player in pairs(getElementsByType('player')) do 
        local currentHunger = getElementData(player, 'hunger')
        if currentHunger < 100 then 
            increaseHunger(player)
            outputChatBox('Hunger increased.', player, 255, 100, 100)
        end 
    end 
end

addEventHandler('onResourceStart', resourceRoot, function()

    local time = getRealTime()
    setTimer(execHunger, 5, 1)
end)