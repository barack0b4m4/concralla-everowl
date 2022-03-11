local db = exports.db:getConnection()
local MINIMUM_PASSWORD_LENGTH = 6
local SPAWN_X, SPAWN_Y, SPAWN_Z = 1479.91015625, -1708.6591796875, 14.046875
local SPAWN_INTERIOR, SPAWN_DIMENSION = 0, 0

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
        spawnPlayer(player, SPAWN_X, SPAWN_Y, SPAWN_Z)
        setElementInterior(player, SPAWN_INTERIOR)
        setElementDimension(player, SPAWN_DIMENSION)
        setCameraTarget(player, player)
    
        return triggerClientEvent(player, 'register-menu:close', player)
    end)
end)


--login
addEvent('auth:login-attempt', true)
addEventHandler('auth:login-attempt', root, function (username, password)

    local account = getAccount(username)
    if not account then 
        return outputChatBox('No such account could be found with that username or password', source, 255, 100, 100)
    end

    local hashedPassword = getAccountData(account, 'hashed_password')
    local player = source
    passwordVerify(password, getAccountData(account, 'hashed_password'), function (isValid)
        if not isValid then
            return outputChatBox('No such account could be found with that username or password', player, 255, 100, 100)
        end

        if logIn(player, account, hashedPassword) then
            -- get info
            local x = getAccountData(account, "x") or SPAWN_X
            local y = getAccountData(account, "y") or SPAWN_Y
            local z = getAccountData(account, "z") or SPAWN_Z
            local interior = getAccountData(account, "interior") or SPAWN_INTERIOR
            local dimension = getAccountData(account, "dimension") or SPAWN_DIMENSION
            
            -- spawn player
            spawnPlayer(player, x, y, z)
            setElementInterior(player, interior)
            setElementDimension(player, dimension)
            setPlayerMoney(player, exports.money:getMoney(account))
            setElementData (player, "extraHealth:invulnerable", true)

            setCameraTarget(player, player)
            return triggerClientEvent(player, 'login-menu:close', player)
        end

        return outputChatBox('An unknown error ocurred while attempting to authenticate.', player, 255, 100, 100)

    end)
end)

addEventHandler('onPlayerQuit', root, function()
    local account = getPlayerAccount(source)

    if not account then 
        return
    end

    local x, y, z = getElementPosition(source)
    local interior = getElementInterior(source)
    local dimension = getElementDimension(source)

    setAccountData(account, "x", x)
    setAccountData(account, "y", y)
    setAccountData(account, "z", z)
    setAccountData(account, "interior", interior)
    setAccountData(account, "dimension", dimension)
    setAccountData(account, 'last_seen', getRealTime().timestamp)
end)

-- logout
addCommandHandler('accountLogout', function (player)
    logOut(player)
end)