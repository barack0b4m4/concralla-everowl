
-- temp

local PAYDAY_AMOUNT = 100
local db = exports.db:getConnection()

function giveAccountPayday(account)
    giveMoney(account, PAYDAY_AMOUNT)
    local currentBudget = getCityBudget('los_santos')
    local newBudget = (currentBudget[1].citybudget - PAYDAY_AMOUNT)
    dbExec(db, 'UPDATE govBudget SET citybudget = ? WHERE cityname = ("los_santos")', newBudget)
end

function executePayday()
    local timeInterval = 1000 * 60 * 60 * 24
    setTimer(executePayday, timeInterval, 1)
    local currentTimeStamp = getRealTime().timestamp
    local oneDay = 60 * 60 * 24
    local accountsPaid = {}

    -- loop through all accounts that have logged in in the past 24 hours
    
    for _, player in pairs(getElementsByType('player')) do 
        local account = getPlayerAccount(player)
        if account then 
            giveAccountPayday(account)
            outputChatBox('You have received a daily payday of ' .. PAYDAY_AMOUNT .. '!', player, 100, 255, 100)
        end
    end 
    
    for _, account in pairs(getAccounts()) do 
        local lastSeen = getAccountData(account, "last_seen") or 0
        if (currentTimeStamp - lastSeen) < oneDay and not accountsPaid[getAccountName(account)] then
            giveAccountPayday(account)
            accountsPaid[getAccountName(account)] = true
        end
    end
end

addCommandHandler('forcepayday', executePayday)

addEventHandler('onResourceStart', resourceRoot, function()

    local time = getRealTime()
    local hourOfDay =  time.hour * 1000 * 60 * 60
    local minuteOfHour = time.minute * 1000 * 60
    local secondsOfMinute = time.second * 1000
    local millisecondsSinceMidnight = hourOfDay + minuteOfHour + secondsOfMinute
    local millisecondsInDay = 1000 * 60 * 60 * 24
    local timeInterval = millisecondsInDay - millisecondsSinceMidnight

    setTimer(executePayday, timeInterval, 1)
end)