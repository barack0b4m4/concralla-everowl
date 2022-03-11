local window

local function getWindowPosition(width, height)
    local screenWidth, screenHeight = guiGetScreenSize()
    local x = (screenWidth / 2) - (width / 2)
    local y = (screenHeight / 2) - (height / 2)
    return x, y, width, height
end

addEvent('itemcreator:open', true)
addEventHandler('itemcreator:open', root, function ()
    triggerEvent('login-menu:close', localPlayer)

    -- initialize cursor
    showCursor(true, true)
    guiSetInputMode('no_binds')

    --open menu
    local x, y, width, height = getWindowPosition(400, 230)
    window = GuiWindow.create(x, y, width, height, 'Create Item', false)
    window:setMovable(false)
    window:setSizable(false)
    local itemTypeLabel = guiCreateLabel(15, 30, width - 30, 20, 'Item Type', false, window)
    local itemTypeInput = guiCreateEdit(10, 50, width - 20, 30, '', false, window)
    local continueButton = guiCreateButton(10, 150, width - 20, 30, 'Continue', false, window)
    local closeButton = guiCreateButton(10, 180, width - 20, 30, 'Close', false, window)

    addEventHandler('onClientGUIClick', continueButton, function ()
        local item_type = guiGetText(itemTypeInput)
        triggerServerEvent('itemcreator:pagetwo', localPlayer, item_type)
    end, false)

    addEventHandler('onClientGUIClick', closeButton, function ()

        triggerEvent('itemcreator:close', localPlayer)
    end, false)

end)

addEvent('itemcreator:food', true)
addEventHandler('itemcreator:food', root, function ()
    triggerEvent('itemcreator:close', localPlayer)

    -- initialize cursor
    showCursor(true, true)
    guiSetInputMode('no_binds')

    --open menu
    local x, y, width, height = getWindowPosition(800, 460)
    window = GuiWindow.create(x, y, width, height, 'Create Food Item', false)
    window:setMovable(false)
    window:setSizable(false)
    local itemNameLabel = guiCreateLabel(15, 30, width - 30, 20, 'Item Name', false, window)
    local itemNameInput = guiCreateEdit(10, 50, width - 20, 30, '', false, window)
    local materialLabel = guiCreateLabel(15, 80, width - 30, 20, 'Precursor material', false, window)
    local materialInput = guiCreateEdit(10, 100, width - 20, 30, '', false, window)
    local materialAmtLabel = guiCreateLabel(15, 130, width - 30, 20, 'Precursor material amount', false, window)
    local materialAmtInput = guiCreateEdit(10, 150, width - 20, 30, '', false, window)
    local sizeLabel = guiCreateLabel(15, 180, width - 30, 20, 'Size', false, window)
    local sizeInput = guiCreateEdit(10, 200, width - 20, 30, '', false, window)
    local marketLabel = guiCreateLabel(15, 230, width - 30, 20, 'Available On Market?', false, window)
    local marketInput = guiCreateEdit(10, 250, width - 20, 30, '', false, window)
    local hungerLabel = guiCreateLabel(15, 280, width - 30, 20, 'Hunger Reduction', false, window)
    local hungerInput = guiCreateEdit(10, 300, width - 20, 30, '', false, window)
    local continueButton = guiCreateButton(10, 350, width - 20, 30, 'Create', false, window)
    local closeButton = guiCreateButton(10, 400, width - 20, 30, 'Close', false, window)

    addEventHandler('onClientGUIClick', continueButton, function ()
        local item_name = guiGetText(itemNameInput)
        local material = guiGetText(materialInput)
        local material_amount = guiGetText(materialAmtInput)
        local size = guiGetText(sizeInput)
        local market = guiGetText(marketInput)
        local hunger = guiGetText(hungerInput)
        triggerServerEvent('itemcreator:createfooditem', localPlayer, item_name, material, material_amount, size, market, hunger)
        triggerEvent('itemcreator:close', localPlayer)
    end, false)

    addEventHandler('onClientGUIClick', closeButton, function ()

        triggerEvent('itemcreator:close', localPlayer)
    end, false)

end)

addEvent('itemcreator:close', true)
addEventHandler('itemcreator:close', root, function()
    destroyElement(window)
    showCursor(false)
    guiSetInputMode('allow_binds')
end)