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

local function checkInv(source)
    local inv = getElementData(source, 'inventory')
    for index, item_id in pairs(inv) do
        iprint(inv)
        for k, v in pairs(item_id) do
            local item_name = dbPoll ( dbQuery  (db, "SELECT item_name FROM items WHERE item_id =?", v), -1 )
            iprint(v)
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
                if itemType[1].item_type == 'food' then 
                    if currentHunger >= 0 then
                        local effects = dbPoll ( dbQuery  (db, "SELECT attribute_1 FROM items WHERE item_name =?", itemName), -1 )
                        setElementData(source,'hunger', currentHunger - effects[1].attribute_1)
                        outputChatBox('You ate a '.. itemName ..'', source, 100, 255, 100)
                        else 
                           return outputChatBox('You are not hungry', source, 255, 100, 100)
                        
                    end
                elseif itemType[1].item_type == 'gun'then 
                    local wepID = dbPoll ( dbQuery  (db, "SELECT attribute_1 FROM items WHERE item_name =?", itemName), -1 )
                    local wepRange = dbPoll ( dbQuery  (db, "SELECT attribute_2 FROM items WHERE item_name =?", itemName), -1 )
                    local wepAcc = dbPoll ( dbQuery  (db, "SELECT attribute_3 FROM items WHERE item_name =?", itemName), -1 )
                    local wepDmg = dbPoll ( dbQuery  (db, "SELECT attribute_4 FROM items WHERE item_name =?", itemName), -1 )
                    local wepAmmo = dbPoll ( dbQuery  (db, "SELECT attribute_5 FROM items WHERE item_name =?", itemName), -1 )
                    local wepSpeed = dbPoll ( dbQuery  (db, "SELECT attribute_6 FROM items WHERE item_name =?", itemName), -1 )
                    giveWeapon(source, wepID[1].attribute_1, wepAmmo[1].attribute_5)
                    setWeaponProperty(wepID[1].attribute_1, poor, target_range, wepRange[1].attribute_2)
                    setWeaponProperty(wepID[1].attribute_1, poor, accuracy, wepAcc[1].attribute_3)
                    setWeaponProperty(wepID[1].attribute_1, poor, damage, wepDmgc[1].attribute_4)
                    setWeaponProperty(wepID[1].attribute_1, poor, maximum_clip_ammo, wepAmmo[1].attribute_5)
                    setWeaponProperty(wepID[1].attribute_1, poor, move_speed, wepSpeed[1].attribute_6)
                    else 
                end
            elseif itemName ~= item_name[1].item_name then
                return outputChatBox('You do not have an item by that name', source, 255, 100, 100)
            end
        end
    end
end

addCommandHandler('inventory', checkInv)
addCommandHandler('useitem', useItem)