local db = exports.db:getConnection()



local function makeDB () 
    dbExec(db, "CREATE TABLE IF NOT EXISTS items (item_id INTEGER PRIMARY KEY AUTOINCREMENT, item_name TEXT, item_type TEXT, material_id INT, material_amount INT, size INT, market_available TEXT, attribute_1 TEXT, attribute_2 TEXT, attribute_3 TEXT, attribute_4 TEXT, attribute_5 TEXT, attribute_6 TEXT, attribute_7 TEXT, attribute_8 TEXT)")
end

addEventHandler("onResourceStart", resourceRoot, makeDB)

local function launchItemCreator(source, commandName)
    triggerClientEvent(source, 'itemcreator:open', source)
end

local function itemcreatorTypes(item_type)
    iprint(item_type)
    if tostring(item_type) == "food" then
        triggerClientEvent(source, 'itemcreator:food', source)
    elseif tostring(item_type) == "weapon" then 
        triggerClientEvent(source, 'itemcreator:weapon', source)
    elseif tostring(item_type) == "material" then 
        triggerClientEvent(source, 'itemcreator:material', source)
    elseif tostring(item_type) == "consumable" then
        triggerClientEvent(source, 'itemcreator:consumable', source)
    else
    end
end

local function createFoodItem(item_name, material, material_amount, size, market, hunger)
    local food = "food"
    --local material_id = dbPoll ( dbQuery  (db, "SELECT material_id FROM items WHERE item_name =?", material), -1) 
    dbExec(db, 'INSERT INTO items (item_name, item_type, material_id, material_amount, size, market_available, attribute_1) VALUES (?, ?, ?, ?, ?, ?, ?)', item_name, food, material, material_amount, size, market, hunger)
    -- let user know you won
    outputChatBox('Food Item: '.. item_name ..' has been created succcessfully', player, 100, 255, 100)
end

addEvent('itemcreator:createfooditem', true)
addEventHandler('itemcreator:createfooditem', root, createFoodItem)

addEvent('itemcreator:pagetwo', true)
addEventHandler('itemcreator:pagetwo', root, itemcreatorTypes)

addCommandHandler('itemcreator', launchItemCreator)

local function checkInventory(source, commandName, slot_number)
    local slot = getElementData(source, slot_number)
    iprint(slot)
        if slot == false or slot == 0
        then 
            return outputChatBox('There is nothing in this slot', source, 255, 100, 100)
        else
            local results = dbPoll ( dbQuery  (db, "SELECT item_name FROM items WHERE item_id =?", slot), -1 )
            outputChatBox('This slot has a '.. results[1].item_name ..' in it', source, 255, 255, 255)
        end
end

local function checkInv(source)
    local inv = getElementData(source, 'inventory')
    for index, item_id in pairs(inv) do
        for k, v in pairs(item_id) do
            local item_name = dbPoll ( dbQuery  (db, "SELECT item_name FROM items WHERE item_id =?", v), -1 )
            outputChatBox('You have '.. item_name[1].item_name ..' in your inventory', player, 255, 255, 255)
        end
    end
end

local function useItem(source, commandName, itemName)
    local inv = getElementData(source, 'inventory')
    local currentHunger = getElementData(source, 'hunger')
    for index, item_id in pairs(inv) do
        for k, v in pairs(item_id) do
            local item_name = dbPoll ( dbQuery  (db, "SELECT item_name FROM items WHERE item_id =?", v), -1 )
            if itemName == item_name[1].item_name 
            then 
                local itemType = dbPoll ( dbQuery  (db, "SELECT item_type FROM items WHERE item_name =?", itemName), -1 )
                if itemType[1].item_type == 'food'
                then
                    if currentHunger >= 0 then
                        local effects = dbPoll ( dbQuery  (db, "SELECT attribute_1 FROM items WHERE item_name =?", itemName), -1 )
                        setElementData(source,'hunger', currentHunger - effects[1].attribute_1)
                        outputChatBox('You ate a '.. itemName ..'', source, 100, 255, 100)
                        else 
                           return outputChatBox('You are not hungry', source, 255, 100, 100)
                        
                    end
                end
            end
        end
    end
end

addCommandHandler('inventory', checkInv)
addCommandHandler('useitem', useItem)