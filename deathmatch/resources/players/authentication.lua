local db = exports.db:getConnection()
local MINIMUM_PASSWORD_LENGTH = 6
local SPAWN_X, SPAWN_Y, SPAWN_Z = 1479.91015625, -1708.6591796875, 14.046875
local SPAWN_INTERIOR, SPAWN_DIMENSION = 0, 0


local function makeDB () 
    dbExec(db, "CREATE TABLE IF NOT EXISTS characters (character_id INTEGER PRIMARY KEY AUTOINCREMENT, account TEXT, character_name TEXT, age INT, gender TEXT, skin INT, fingerprint TEXT, money INT, hunger INT, strength INT, cunning INT, intelligence INT, head_hp INT, torso_hp INT, leftarm_hp INT, rightarm_hp INT, leftleg_hp INT, rightleg_hp INT, lowerbody_hp INT, x INT, y INT, z INT, interior INT, dimension INT, last_seen INT)")
    dbExec(db, "CREATE TABLE IF NOT EXISTS inventories (character_name TEXT, item_id INT)")
    dbExec(db, "CREATE TABLE IF NOT EXISTS charskills (character_name TEXT, skill_id INT, level INT)")
end

addEventHandler("onResourceStart", resourceRoot, makeDB) 

local function isPasswordValid(password)
    return string.len(password) >= MINIMUM_PASSWORD_LENGTH
end

-- create an account
addEvent('auth:register-attempt', true)
addEventHandler('auth:register-attempt', root, function (username, password)

-- check if an accouint with that username already exists
    if getAccount(username) then
        return outputChatBox('An account already exists with that name.', source, 255, 100, 100)
    end

-- is the password valid
    if not isPasswordValid(password) then
        return outputChatBox('The password supplied was not valid.', source, 255, 100, 100)
    end

-- create a hash of password
    local player = source
    passwordHash(password, 'bcrypt', {}, function (hashedPassword)
    -- create account
        local account = addAccount(username, hashedPassword)
        setAccountData(account, 'hashed_password', hashedPassword)

    -- let user know you won
        outputChatBox('Your account has been successfully created, login with /accountLogin', source, 100, 255, 100)
            -- automatically login and spawn the player.
        logIn(player, account, hashedPassword)
        --spawnPlayer(player, SPAWN_X, SPAWN_Y, SPAWN_Z)
        --setElementInterior(player, SPAWN_INTERIOR)
        --setElementDimension(player, SPAWN_DIMENSION)
        --setCameraTarget(player, player)
    
        return triggerClientEvent(player, 'register-menu:close', player)
    end)
end)




-- save data
--addEventHandler('onPlayerQuit', root, function()
  --  local account = getPlayerAccount(source)
  -- local character_name = getPlayerName(source)
   -- local skin = getElementModel(source)
   -- local x, y, z = getElementPosition(source)
   -- local interior = getElementInterior(source)
   -- local dimension = getElementDimension(source)

    
  ---  
--end)

-- login attempt
addEvent('auth:login-attempt', true)
addEventHandler('auth:login-attempt', root, function (username, password)
    
    -- check hashed password
        local account = getAccount(username)
        local player = source
        local hashedPassword = getAccountData(account,"hashed_password")
            if (passwordVerify(password,hashedPassword)) then 
                outputChatBox('Login successful', source, 100, 255, 100)
                logIn(player, account, hashedPassword)
                return triggerEvent('character-menu:getcharacters', player)
            else
				outputChatBox("Password is incorrect!",source,160,20,20)
            end
            --spawnPlayer(player, SPAWN_X, SPAWN_Y, SPAWN_Z)
            --setElementInterior(player, SPAWN_INTERIOR)
            --setElementDimension(player, SPAWN_DIMENSION)
            --setCameraTarget(player, player)
        
    end)


addEventHandler('onPlayerQuit', root, function()
    local account = getPlayerAccount(source)

    if not account then 
       return
    end

    local character_name = getPlayerName(source)
    local skin = getElementModel(source)
    local money = getPlayerMoney(source)
    local x, y, z = getElementPosition(source)
    local interior = getElementInterior(source)
    local dimension = getElementDimension(source)
    local hunger = getElementData(source, 'hunger')
    local head_hp = getElementData(source, 'head_hp')
    local torso_hp = getElementData(source, 'torso_hp')
    local leftarm_hp = getElementData(source, 'leftarm_hp')
    local rightarm_hp = getElementData(source, 'rightarm_hp')
    local leftleg_hp = getElementData(source, 'leftleg_hp')
    local rightleg_hp = getElementData(source, 'rightleg_hp')
    local lowerbody_hp = getElementData(source, 'lowerbody_hp')
    local last_seen = getRealTime().timestamp
    return dbExec(db, "UPDATE characters SET skin=?, money=?, x=?, y=?, z=?, interior=?, dimension=?, hunger=?, head_hp=?, torso_hp=?, leftarm_hp=?, rightarm_hp=?, leftleg_hp=?, rightleg_hp=?, lowerbody_hp=?, last_seen=? WHERE character_name =?", skin, money, x, y, z, interior, dimension, hunger, head_hp, torso_hp, leftarm_hp, rightarm_hp, leftleg_hp, rightleg_hp, lowerbody_hp, last_seen, character_name)
end)


-- logout
addCommandHandler('accountLogout', function (player)
    logOut(player)
end)

