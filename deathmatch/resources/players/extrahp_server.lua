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

function reportDamageType ( attacker, weapon, bodypart, loss ) --when a player is damaged
	-- bullet wounds
	local bulletType = (22 or 23 or 24 or 25 or 26 or 27 or 28 or 29 or 32 or 30 or 31 or 33 or 34 or 38)

	if ( bodypart == 9 and weapon == bulletType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
        outputChatBox ( "You have been shot in the head", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 3 and weapon == bulletType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have been shot in the chest", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 4 and weapon == bulletType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have been shot in the ass", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 5 and weapon == bulletType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have been shot in the left arm", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 6 and weapon == bulletType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have been shot in the right arm", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 7 and weapon == bulletType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have been shot in the left leg", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 8 and weapon == bulletType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have been shot in the right leg", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	-- direct explosion damage
	local explosionType = ( 35 or 36 or 19 or 51 or 59 or 63 or 16 or 18 or 39 )

	if ( bodypart == 9 and weapon == explosionType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
            outputChatBox ( "An explosion has sent shrapnel into your face", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 3 and weapon == explosionType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "An explosion has damaged your torso", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 4 and weapon == explosionType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "An explosion has sent shrapnel into your ass", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 5 and weapon == explosionType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "Your left arm has been damaged by an explosion", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 6 and weapon == explosionType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "Your right arm has been damaged by an explosion", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 7 and weapon == explosionType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "Your left leg has been damaged by an explosion", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 8 and weapon == explosionType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "Your right leg has been damaged by an explosion", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end

	--local flameType = 
	if ( bodypart == 9 and weapon == flameType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have suffered burns to your head and face", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 3 and weapon == flameType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have suffered burns to your upper body", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 4 and weapon == flameType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have suffered burns to your ass", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 5 and weapon == flameType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have suffered burns to your left arm", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 6 and weapon == flameType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have suffered burns to your right arm", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 7 and weapon == flameType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have suffered burns to your left leg", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
	if ( bodypart == 8 and weapon == flameType ) then -- if the body part is 9 (head) and there is an attacker and it wasn't self damage
		outputChatBox ( "You have suffered burns to your right leg", source, 255, 100, 0 ) --output "Headshot" into the chatbox
	end
end

addEventHandler ( "damage:damageReport", resourceRoot, reportDamageType ) --add an event handler for the onPlayerDamage event