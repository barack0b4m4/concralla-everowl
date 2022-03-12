local db = exports.db:getConnection()
local SPAWN_X, SPAWN_Y, SPAWN_Z = 1479.91015625, -1708.6591796875, 14.046875
local SPAWN_INTERIOR, SPAWN_DIMENSION = 0, 0


local function getCharacters()
    triggerClientEvent(source, 'character-menu:open', source)
    local accountObj = getPlayerAccount(source)
    local account = getAccountName(accountObj)
    outputChatBox('Finding characters..', source, 0, 255, 0)
    local charResult = dbPoll ( dbQuery  (db, "SELECT character_name FROM characters WHERE account =?", account), -1 )
    iprint(charResult)
        return charResult
end

--function loadAllVehicles(queryHandle)
  --  local results = dbPoll(queryHandle, 0)

    --for index, vehicle in pairs(results) do
      --  local vehicleObject = createVehicle(vehicle.model, vehicle.x, vehicle.y, vehicle.z, vehicle.rotation_x, vehicle.rotation_y, vehicle.rotation_z)

        --setElementData(vehicleObject, "id", vehicle.id)
    --end
--end

local function initCharInventory(characterName)
    local player = source
    local charName = getPlayerName(player)
    local results = dbPoll ( dbQuery  (db, "SELECT * FROM inventories WHERE character_name =?", charName), -1 )
    iprint(results)
    setElementData(player, 'inventory', results)
    local diditwork = getElementData(player, 'inventory')
    iprint(diditwork)
end
    
addEvent('initInventory', true)
addEventHandler('initInventory', root, initCharInventory)

local function spawnChar(characterName)
        -- create character
        local player = source
        local accountObj = getPlayerAccount(player)
        local account = getAccountName(accountObj)
        local results = dbPoll ( dbQuery  (db, "SELECT * FROM characters WHERE character_name =?", characterName), -1 )
        -- let user know you won
        if results ~= nil then
            for index, characters in pairs(results) do
                spawnPlayer(player, characters.x, characters.y, characters.z)
                setPlayerName(player, characters.character_name)
                setPlayerMoney(player, characters.money)
                setElementModel(player, characters.skin)
                setElementInterior(player, characters.interior)
                setElementData(player, 'hunger', characters.hunger)
                setElementData(player, 'age', characters.age)
                setElementData(player, 'head_hp', characters.head_hp)
                setElementData(player, 'torso_hp', characters.torso_hp)
                setElementData(player, 'leftarm_hp', characters.leftarm_hp)
                setElementData(player, 'rightarm_hp', characters.rightarm_hp)
                setElementData(player, 'leftleg_hp', characters.leftleg_hp)
                setElementData(player, 'rightleg_hp', characters.rightleg_hp)
                setElementData(player, 'lowerbody_hp', characters.lowerbody_hp)
                setElementData (player, "extraHealth:invulnerable", true)
                setElementDimension(player, characters.dimension)
                setCameraTarget(player, player)
                triggerEvent('initInventory', player)
                triggerClientEvent(player, 'character-menu:close', player)
                outputChatBox("Welcome to Thug Life Gangsta World RP", player, 100, 255, 100)
            end
        else outputChatBox("There is no character with this name", player, 255, 100, 100)
        end
end

addEvent('character-menu:getcharacters', true)
addEventHandler('character-menu:getcharacters', root, getCharacters)

addEvent('character-menu:spawnchar', true)
addEventHandler('character-menu:spawnchar', root, spawnChar)

local function createCharacter(characterName, age, gender, skin)
    -- create fingerprint
        local fingerprint = passwordHash(characterName, 'bcrypt', {})
        -- create character
        local player = source
        local accountObj = getPlayerAccount(player)
        local account = getAccountName(accountObj)
        
        -- let user know you won
        dbExec(db, 'INSERT INTO characters (account, character_name, fingerprint, age, gender, skin) VALUES (?, ?, ?, ?, ?, ?)', account, characterName, fingerprint, age, gender, skin)
            outputChatBox('Your character has been successfully created', source, 100, 255, 100)
            spawnPlayer(player, SPAWN_X, SPAWN_Y, SPAWN_Z)
            setPlayerName(player, characterName)
            setElementModel(player, skin)
            setElementInterior(player, SPAWN_INTERIOR)
            setPlayerMoney(player, 0)
            setElementData(player, 'hunger', 100)
            setElementData(player, 'head_hp', 100)
            setElementData(player, 'torso_hp', 100)
            setElementData(player, 'leftarm_hp', 100)
            setElementData(player, 'rightarm_hp', 100)
            setElementData(player, 'leftleg_hp', 100)
            setElementData(player, 'rightleg_hp', 100)
            setElementData(player, 'lowerbody_hp', 100)
            setElementDimension(player, SPAWN_DIMENSION)
            setCameraTarget(player, player)
            triggerClientEvent(player, 'character-menu:close', player)
end

addEvent('character-menu:create', true)
addEventHandler('character-menu:create', root, createCharacter)


