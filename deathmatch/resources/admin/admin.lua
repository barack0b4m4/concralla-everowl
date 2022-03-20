addCommandHandler('setrank', function(player, command, account, group)
    if not account or not group then
        return outputChatBox('SYNTAX:/' .. command .. ' [acccount] [group]', player, 255, 255, 255)
    end

-- ensure the account is valid
    local accountObj = getAccount(account)
    if not accountObj then
        return outputChatBox("The specified account does not exist", player, 255, 100, 100)
    end


-- ensure the group is valid
    local groupObj = aclGetGroup(group)
    if not groupObj then
        return outputChatBox("The specified group does not exist", player, 255, 100, 100)
    end



-- prefix the account name with " user" to be a valid object string
    local objectStr = 'user.' .. account


-- remove user from all other groups
    local groups = aclGroupList()
    for _, removalGroup in pairs(groups) do
        aclGroupRemoveObject(removalGroup, objectStr)     
    end


-- if the group is everyone just reutrn
    if group == 'Everyone' then
        return outputChatBox('Successfully rmemoved account ' .. account .. ' from all groups', player, 100, 255, 100)
    end


-- add the account to acl group 
    aclGroupAddObject(groupObj, objectStr)


    -- let user know we won
    outputChatBox('Successfully added account ' .. account .. ' to group ' .. group .. '.', player, 100, 255, 100)

end)

addCommandHandler('setaclright', function (player, command, acl, right, access)
    if not acl or not right or not access then
        return outputChatBox('SYNTAX: /' .. command ..' [acl] [right] [access]', player, 255, 255, 255)
    end

    local aclObj = aclGet(acl)
    if not aclObj then
        return outputChatBox('The specified ACL does not exist.', player, 255, 100, 100)
    end

    local accessTypes = {['true'] = true, ['false'] = false}
    local accessBoolean = accessTypes[string.lower(access)]
    if accessBoolean == nil then
        return outputChatBox('ACL Access must be either TRUE or FALSE.', player, 255, 100, 100)
    end

    aclSetRight(aclObj, right, accessBoolean)
    aclSave()

    outputChatBox('Successfully updated the ACL right.', player, 100, 255, 100)
end, true, false)

function giveGun ( thePlayer, commandName, weaponID, ammo ) 
    if tonumber(weaponID) < 1 or tonumber(weaponID) > 46 then
        return outputChatBox('Invalid weapon ID', source, 255, 0, 0 )
    end
    
    local status = giveWeapon ( thePlayer, weaponID, ammo, true )   -- attempt to give the weapon, forcing it as selected weapon
	if ( not status ) then                                          -- if it was unsuccessful
		outputConsole ( "Failed to give weapon.", thePlayer )   -- tell the player
	end
end
addCommandHandler ( "givegun", giveGun )