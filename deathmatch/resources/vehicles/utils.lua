function getVehicleFromID(vehicleId)
    for _, vehicle in pairs(getElementsByType('vehicle')) do 
        if (getElementData(vehicle, 'id') == vehicleId) then 
            return vehicle
        end
    end

    return nil 
end

function getPositioninFrontOf(player)
    local rotX, rotY, rotZ = getElementRotation(player)
    rotZ = rotZ + 90 -- lets turn the car 90 degrees to the left so the driver door faces us.

    local desiredRelativePosition = Vector3(0, 5, 0)
    local matrix = player.matrix 
    local newPosition = matrix:transformPosition(desiredRelativePosition)

    local interior = getElementInterior(player)
    local dimension = getElementDimension(player)


    return newPosition:getX(), newPosition:getY(), newPosition:getZ(), rotX, rotY, rotZ, interior, dimension
end