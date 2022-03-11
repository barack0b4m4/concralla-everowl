local db = exports.db:getConnection()

local function makeDB () 
    dbExec(db, "CREATE TABLE IF NOT EXISTS cityTax (cityname TEXT, taxrate REAL)")
end

addEventHandler("onResourceStart", resourceRoot, makeDB) 

local function addCityTax(player, command, cityname, taxrate)
    dbExec(db, 'INSERT INTO cityTax (cityname, taxrate) VALUES (?, ?)', cityname, taxrate)
end

addCommandHandler("addcitytax", addCityTax)

local function setTaxRate(player, command, taxRate)
    dbExec(db, 'UPDATE cityTax SET taxrate = ? WHERE cityname = ("los_santos")', taxRate)
end

addCommandHandler("taxrate", setTaxRate, taxRate)

function getCityTax(cityName)
    local taxResult = dbPoll ( dbQuery  (db, "SELECT taxrate FROM cityTax WHERE cityname =?", cityName), -1 )
    return taxResult
end

local function executeTaxes()
    local currentTax = getCityTax('los_santos')
    local currentGDP = getCityGDP('los_santos')
    local currentBudget = getCityBudget('los_santos')
    local taxes = (currentTax[1].taxrate * currentGDP[1].citygdp)
    local newBudget = (currentBudget[1].citybudget + taxes)
    local newGDP = (currentGDP[1].citygdp - taxes)
    dbExec(db, 'UPDATE GDP SET citygdp = ? WHERE cityname = ("los_santos")', newGDP)
    dbExec(db, 'UPDATE govBudget SET citybudget = ? WHERE cityname = ("los_santos")', newBudget)
end

addCommandHandler("forcetaxes", executeTaxes)

-- daily tax npcs
addEventHandler('onResourceStart', resourceRoot, function()

    local time = getRealTime()
    local hourOfDay =  time.hour * 1000 * 60 * 60
    local minuteOfHour = time.minute * 1000 * 60
    local secondsOfMinute = time.second * 1000
    local millisecondsSinceMidnight = hourOfDay + minuteOfHour + secondsOfMinute
    local millisecondsInDay = 1000 * 60 * 60 * 24
    local timeInterval = millisecondsInDay - millisecondsSinceMidnight

    setTimer(executeTaxes, timeInterval, 1)
end)