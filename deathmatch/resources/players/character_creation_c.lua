local window
local CAMERA_POS_X, CAMERA_POS_Y, CAMERA_POS_Z = 1480, -1710, 20
local CAMERA_LOOK_X, CAMERA_LOOK_Y, CAMERA_LOOK_Z = 1480, -1810, 20

function mouseKey() 
    showCursor(not isCursorShowing()) -- Toggles between true and false 
 end 
 bindKey("m", "down", mouseKey) 

addEvent('character-menu:open', true)
addEventHandler('character-menu:open', root, function ()
    triggerEvent('login-menu:close', localPlayer)

    setCameraMatrix (CAMERA_POS_X, CAMERA_POS_Y, CAMERA_POS_Z, CAMERA_LOOK_X, CAMERA_LOOK_Y, CAMERA_LOOK_Z)
    fadeCamera(true)

    -- initialize cursor
    showCursor(true, true)
    guiSetInputMode('no_binds')

    --open menu
    local x, y, width, height = getWindowPosition(400, 230)
    window = GuiWindow.create(x, y, width, height, 'Choose character', false)
    window:setMovable(false)
    window:setSizable(false)
    local noCharacterLabel = guiCreateLabel(15, 20, width - 30, 20, 'This account has no characters', false, window)
    noCharacterLabel:setColor(255, 0, 0)
    noCharacterLabel:setVisible(false)
    local charactermenuLabel = guiCreateLabel(15, 30, width - 30, 20, 'Characters:', false, window)
    local characterNameInput = guiCreateEdit(10, 50, width - 20, 30, '', false, window)
    local newCharacterButton = guiCreateButton(10, 150, width - 20, 30, 'Create New Character', false, window)
    local playCharacterButton = guiCreateButton(10, 180, width - 20, 30, 'Play as character', false, window)
        -- if no characters
       -- if charResult[1].character_name == nil then
        --noCharacterLabel:setVisible(true)
         -- list characters
        --elseif charResult[1].character_name ~= nil then
          --  characterListButton:setVisible(true)
        --end
    addEventHandler('onClientGUIClick', newCharacterButton, function ()
        triggerEvent('character-menu:close', localPlayer)
        triggerEvent('charcreate:open', localPlayer)
    end, false)

    addEventHandler('onClientGUIClick', playCharacterButton, function ()
        local characterName = guiGetText(characterNameInput)

        triggerServerEvent('character-menu:spawnchar', localPlayer, characterName)
    end, false)

end)


addEvent('character-menu:close', true)
addEventHandler('character-menu:close', root, function()
    destroyElement(window)
    showCursor(false)
    guiSetInputMode('allow_binds')
end)

addEvent('charcreate:open', true)
addEventHandler('charcreate:open', root, function()
    -- initialize cursor
    showCursor(true, true)
    guiSetInputMode('no_binds')

    --open menu
    local x, y, width, height = getWindowPosition(400, 230)
    window = guiCreateWindow(x, y, width, height + 200, 'Login to Our Server', false)
    guiWindowSetMovable(window, false)
    guiWindowSetSizable(window, false)
    
    local characterNameLabel = guiCreateLabel(15, 30, width - 30, 20, 'Name (Firstname_Lastname)', false, window)
    local characterNameInput = guiCreateEdit(10, 50, width - 20, 30, '', false, window)

    local ageLabel = guiCreateLabel(15, 90, width - 30, 20, 'Age', false, window)
    local ageInput = guiCreateEdit(10, 110, width - 20, 30, '', false, window)

    local genderLabel = guiCreateLabel(15, 150, width - 30, 20, 'Gender', false, window)
    local genderInput = guiCreateEdit(10, 170, width - 20, 30, '', false, window)
 
    local skinLabel = guiCreateLabel(15, 210, width - 30, 20, 'Skin ID (0-312)', false, window)
    local skinInput = guiCreateEdit(10, 230, width - 20, 30, '', false, window)


    local createButton = guiCreateButton(10, 300, width - 20, 30, 'Create Character', false, window)



    addEventHandler('onClientGUIClick', createButton, function(button, state)
        if button ~= 'left' or state ~= 'up' then
            return
        end

        local characterName = guiGetText(characterNameInput)
        local age = guiGetText(ageInput)
        local gender = guiGetText(genderInput)
        local skin = guiGetText(skinInput)    

        triggerServerEvent('character-menu:create', localPlayer, characterName, age, gender, skin)

    end, false)
end)



