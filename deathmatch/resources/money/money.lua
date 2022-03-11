-- account has money

function updatePlayerMoneyForAccount(account, amount)
    local player = getAccountPlayer(account)
    if player then 
        setPlayerMoney(player, amount)
    end
end

function setMoney(account, amount)
    updatePlayerMoneyForAccount(account, amount)
    return setAccountData(account, 'money', amount)
end 

function getMoney(account)
    return getAccountData(account, 'money') or 0
end 

function giveMoney(account, amount)
    return setMoney(account, getMoney(account) + amount)
end 

function takeMoney(account, amount)
    return setMoney(account, getMoney(account) - amount)
end 


