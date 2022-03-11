local CAMERA_POS_X, CAMERA_POS_Y, CAMERA_POS_Z = 1480, -1710, 20
local CAMERA_LOOK_X, CAMERA_LOOK_Y, CAMERA_LOOK_Z = 1480, -1810, 20
local window

addEvent('login-menu:open', true)
addEventHandler('login-menu:open', root, function ()
    outputChatBox('Welcome to our server!')
    setCameraMatrix (CAMERA_POS_X, CAMERA_POS_Y, CAMERA_POS_Z, CAMERA_LOOK_X, CAMERA_LOOK_Y, CAMERA_LOOK_Z)
    fadeCamera(true)

    -- initialize cursor
    showCursor(true, true)
    guiSetInputMode('no_binds')

    --open menu
    local x, y, width, height = getWindowPosition(400, 230)
    window = GuiWindow.create(x, y, width, height, 'Login to our Server', false)
    window:setMovable(false)
    window:setSizable(false)
    
    local usernameLabel = guiCreateLabel(15, 30, width - 30, 20, 'Username', false, window)
    local usernameErrorLabel = guiCreateLabel(width - 120, 30, 140, 20, 'Username invalid', false, window)
    usernameErrorLabel:setColor(255, 0, 0)
    usernameErrorLabel:setVisible(false)
    local usernameInput = guiCreateEdit(10, 50, width - 20, 30, '', false, window)

    local passwordLabel = guiCreateLabel(15, 90, width - 30, 20, 'Password', false, window)
    local passwordErrorLabel = guiCreateLabel(width - 120, 90, 140, 20, 'Password invalid', false, window)
    passwordErrorLabel:setColor(255, 0, 0)
    passwordErrorLabel:setVisible(false)
    local passwordInput = guiCreateEdit(10, 110, width - 20, 30, '', false, window)
    passwordInput:setMasked(true)


    local loginButton = guiCreateButton(10, 150, width - 20, 30, 'Login', false, window)
    addEventHandler('onClientGUIClick', loginButton, function(button, state)
        if button ~= 'left' or state ~= 'up' then
            return
        end

        local username = guiGetText(usernameInput) 
        local password = guiGetText(passwordInput)
        local inputValid = true

        if not isUsernameValid(username) then
            -- invalid
            usernameErrorLabel:setVisible(true)
            inputValid = false
        end

        if not isPasswordValid(password) then
            passwordErrorLabel:setVisible(true)
            -- invalid
            inputValid = false
        end

        triggerServerEvent('auth:login-attempt', localPlayer, username, password)

    end, false)

    local registerButton = guiCreateButton(10, 190, (width / 2) - 15, 30, 'Sign Up', false, window)
    addEventHandler('onClientGUIClick', registerButton, function ()
        triggerEvent('login-menu:close', localPlayer)
        triggerEvent('register-menu:open', localPlayer)
    end, false)
    local forgotPasswordButton = guiCreateButton(width / 2 + 5, 190, width / 2 - 15, 30, 'Forgot Password', false, window)
    addEventHandler('onClientGUIClick', forgotPasswordButton, function ()
        outputChatBox('Coming soon.', 100, 100, 255)
    end, false)
end, true)

addEvent('login-menu:close', true)
addEventHandler('login-menu:close', root, function()
    destroyElement(window)
    showCursor(false)
    guiSetInputMode('allow_binds')
end)