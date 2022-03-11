local db = exports.db:getConnection()

local function buyGoods(source, command, amount)
    local account = getPlayerAccount(source)
    takeMoney(account, amount)
    local currentGDP = getCityGDP('los_santos')
    local newGDP = (currentGDP[1].citygdp + amount)
    dbExec(db, 'UPDATE GDP SET citygdp = ? WHERE cityname = ("los_santos")', newGDP)
end

addCommandHandler("buy", buyGoods, amount)

local function makeGoods()
end