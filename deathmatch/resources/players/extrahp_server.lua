local validTypes =
	{
		[ "player" ] = true,
		[ "ped" ] = true,
		[ "vehicle" ] = true
	}

function setElementInvulnerable ( theElement, theState )
	if ( not theElement or not isElement ( theElement ) ) then
		return false, "Invalid element"
	end

	if ( not validTypes [ getElementType ( theElement ) ] ) then
		return false, "Invalid element type"
	end

	return setElementData ( theElement, "extraHealth:invulnerable", theState )
end

function isElementInvulnerable ( theElement )
	if ( not theElement or not isElement ( theElement ) ) then
		return false, "Invalid element"
	end

	if ( not validTypes [ getElementType ( theElement ) ] ) then
		return false, "Invalid element type"
	end

	return getElementData ( theElement, "extraHealth:invulnerable" )
end


addEvent( "damage:damageReport" , true )

function reportDamageType ( weapon, bodypart, loss ) --when a player is damaged
	-- bullet wounds
	local bulletType = (22 or 23 or 24 or 25 or 26 or 27 or 28 or 29 or 32 or 30 or 31 or 33 or 34 or 38)

	if ( bodypart == 9 and weapon == bulletType ) then 
        outputChatBox ( "You have been shot in the head", source, 255, 100, 0 ) 
	end
	if ( bodypart == 3 and weapon == bulletType ) then 
		outputChatBox ( "You have been shot in the chest", source, 255, 100, 0 ) 
	end
	if ( bodypart == 4 and weapon == bulletType ) then 
		outputChatBox ( "You have been shot in the ass", source, 255, 100, 0 ) 
	end
	if ( bodypart == 5 and weapon == bulletType ) then 
		outputChatBox ( "You have been shot in the left arm", source, 255, 100, 0 ) 
	end
	if ( bodypart == 6 and weapon == bulletType ) then 
		outputChatBox ( "You have been shot in the right arm", source, 255, 100, 0 ) 
	end
	if ( bodypart == 7 and weapon == bulletType ) then 
		outputChatBox ( "You have been shot in the left leg", source, 255, 100, 0 ) 
	end
	if ( bodypart == 8 and weapon == bulletType ) then 
		outputChatBox ( "You have been shot in the right leg", source, 255, 100, 0 ) 
	end
	-- direct explosion damage
	local explosionType = ( 35 or 36 or 19 or 51 or 59 or 63 or 16 or 18 or 39 )

	if ( bodypart == 9 and weapon == explosionType ) then 
            outputChatBox ( "An explosion has sent shrapnel into your face", source, 255, 100, 0 ) 
	end
	if ( bodypart == 3 and weapon == explosionType ) then 
		outputChatBox ( "An explosion has damaged your torso", source, 255, 100, 0 ) 
	end
	if ( bodypart == 4 and weapon == explosionType ) then 
		outputChatBox ( "An explosion has sent shrapnel into your ass", source, 255, 100, 0 ) 
	end
	if ( bodypart == 5 and weapon == explosionType ) then 
		outputChatBox ( "Your left arm has been damaged by an explosion", source, 255, 100, 0 ) 
	end
	if ( bodypart == 6 and weapon == explosionType ) then 
		outputChatBox ( "Your right arm has been damaged by an explosion", source, 255, 100, 0 ) 
	end
	if ( bodypart == 7 and weapon == explosionType ) then 
		outputChatBox ( "Your left leg has been damaged by an explosion", source, 255, 100, 0 ) 
	end
	if ( bodypart == 8 and weapon == explosionType ) then 
		outputChatBox ( "Your right leg has been damaged by an explosion", source, 255, 100, 0 ) 
	end

	--local flameType = 
	if ( bodypart == 9 and weapon == flameType ) then 
		outputChatBox ( "You have suffered burns to your head and face", source, 255, 100, 0 ) 
	end
	if ( bodypart == 3 and weapon == flameType ) then 
		outputChatBox ( "You have suffered burns to your upper body", source, 255, 100, 0 ) 
	end
	if ( bodypart == 4 and weapon == flameType ) then 
		outputChatBox ( "You have suffered burns to your ass", source, 255, 100, 0 ) 
	end
	if ( bodypart == 5 and weapon == flameType ) then 
		outputChatBox ( "You have suffered burns to your left arm", source, 255, 100, 0 ) 
	end
	if ( bodypart == 6 and weapon == flameType ) then 
		outputChatBox ( "You have suffered burns to your right arm", source, 255, 100, 0 ) 
	end
	if ( bodypart == 7 and weapon == flameType ) then 
		outputChatBox ( "You have suffered burns to your left leg", source, 255, 100, 0 ) 
	end
	if ( bodypart == 8 and weapon == flameType ) then 
		outputChatBox ( "You have suffered burns to your right leg", source, 255, 100, 0 ) 
	end

	local fallType = ( 54 )
	if ( weapon == fallType ) then 
		outputChatBox ( "You have been severely hurt by a fall", source, 255, 100, 0 ) 
	end

	local vehicleType = ( 50 and 49 )
	if ( weapon == vehicleType ) then 
		outputChatBox ( "You have been struck by a vehicle", source, 255, 100, 0 ) 
	end
end

addEventHandler ( "damage:damageReport", source, reportDamageType ) --add an event handler for the onPlayerDamage event