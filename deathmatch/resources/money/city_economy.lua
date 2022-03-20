local db = exports.db:getConnection()

local function makeDB () 
    dbExec(db, "CREATE TABLE IF NOT EXISTS GDP (cityname TEXT PRIMARY KEY, citygdp INT)")
    dbExec(db, "CREATE TABLE IF NOT EXISTS govBudget (cityname TEXT PRIMARY KEY, citybudget INT)")
end

addEventHandler("onResourceStart", resourceRoot, makeDB) 

local function addCityGDP(player, command, cityname, citygdp)
    dbExec(db, 'INSERT INTO GDP (cityname, citygdp) VALUES (?, ?)', cityname, citygdp)
end

local function addCityBudget(player, command, cityname, citybudget)
    dbExec(db, 'INSERT INTO govBudget (cityname, citybudget) VALUES (?, ?)', cityname, citybudget)
end

addCommandHandler('addcitygdp', addCityGDP, false, false)
addCommandHandler('addcitybudget', addCityBudget, false, false)

function getCityGDP(cityName)
    local gdpResult = dbPoll ( dbQuery  (db, "SELECT citygdp FROM GDP WHERE cityname =?", cityName), -1 )
    return gdpResult
end

function getCityBudget(cityName)
    local budgetResult = dbPoll ( dbQuery  (db, "SELECT citybudget FROM govBudget WHERE cityname =?", cityName), -1 )
    return budgetResult
end

function math.randomDiff (start, finish)
	if start >= finish or not start or not finish then return false end
	if (math.floor(start) ~= start) or (math.floor(finish) ~= finish) then return false end
	local rand = math.random(start, finish)
	while (rand == lastRand) do
		rand = math.random(start, finish)
	end
	lastRand = rand
	return rand
end

local function fluctuateGDP()
    local currentGDP = getCityGDP('los_santos')
    --local changetop = ( currentGDP[1].citygdp * 0.01 )
      --  iprint(changetop)
    --local changebottom = ( changetop - (changetop * 2))
      --  iprint(changebottom)
    local gdpChange = math.randomDiff(-16438356, 16438356)
       -- iprint(gdpChange)
    local newGDP = (currentGDP[1].citygdp + gdpChange)
        -- iprint(newGDP)
    dbExec(db, 'UPDATE GDP SET citygdp = ? WHERE cityname = ("los_santos")', newGDP)
end

local function whatsGDP()
    local currentGDP = getCityGDP('los_santos')
    outputChatBox('$'.. currentGDP[1].citygdp ..'', source, 255, 255, 255)
end

addCommandHandler('whatsgdp', whatsGDP)
addCommandHandler('fluctuategdp', fluctuateGDP)

addEventHandler('onResourceStart', resourceRoot, function()

    local time = getRealTime()
    local hourOfDay =  time.hour * 1000 * 60 * 60
    local minuteOfHour = time.minute * 1000 * 60
    local secondsOfMinute = time.second * 1000
    local millisecondsSinceMidnight = hourOfDay + minuteOfHour + secondsOfMinute
    local millisecondsInDay = 1000 * 60 * 60 * 24
    local timeInterval = millisecondsInDay - millisecondsSinceMidnight

    setTimer(fluctuateGDP, timeInterval, 1)
end)

