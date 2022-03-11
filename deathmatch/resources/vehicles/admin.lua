
local addCommandHandler_ = addCommandHandler
addCommandHandler  = function( commandName, fn, restricted, caseSensitive )
-- add the default command handlers
if type( commandName ) ~= "table" then
  commandName = { commandName }
end
for key, value in ipairs( commandName ) do
  if key == 1 then
      addCommandHandler_( value, fn, restricted, caseSensitive )
  else
      addCommandHandler_( value,
          function( player, ... )
              -- check if he has permissions to execute the command, default is not restricted (aka if the command is restricted - will default to no permission; otherwise okay)
              if hasObjectPermissionTo( player, "command." .. commandName[ 1 ], not restricted ) then
                  fn( player, ... )
              end
          end
      )
  end
end
end

addCommandHandler({'getvehicle', 'getcar', 'getveh'}, function (player, command, vehicleId)
    if not vehicleId then 
        outputChatBox('Syntax: /' .. command .. ' [vehicle ID]', player, 255, 255, 255)
    end
    local vehicle = getVehicleFromID(tonumber(vehicleId))
    if not vehicle then 
        outputChatBox("No such vehicle found with that ID.", player, 255, 100, 100)
    end

    local x, y, z, rotX, rotY, rotZ, interior, dimension = getPositioninFrontOf(player)
    setElementPosition(vehicle, x, y, z)
    setElementRotation(vehicle, rotX, rotY, rotZ)
    setElementInterior(vehicle, interior)
    setElementDimension(vehicle, dimension)
end)

addCommandHandler({'createvehicle', 'createveh', 'makeveh'},
    function (player, command, model)
    local db = exports.db:getConnection()
    local x, y, z, rotX, rotY, rotZ, interior, dimension = getPositioninFrontOf(player)

    dbExec(db, 'INSERT INTO vehicles (model, x, y, z, rotation_x, rotation_y, rotation_z) VALUES (?, ?, ?, ?, ?, ?, ?)', model, x, y, z, rotX, rotY, rotZ)

    local vehicleObject = createVehicle(model, x, y, z, rotX, rotY, rotZ)

    dbQuery(function (queryHandle)
        local results = dbPoll(queryHandle, 0)
        local vehicle = results[1]

        setElementData(vehicleObject, 'id', vehicle.id)
        outputChatBox('Successfully created a ' .. getVehicleName(vehicleObject) .. ' with ID ' .. vehicle.id ..'.', player, 100, 255, 100)

    end, db, 'SELECT id FROM vehicles ORDER BY id DESC LIMIT 1')
end, false, false)



addCommandHandler({'fixvehicle', 'fixveh', 'repairvehicle'}, function (player, command, name)
    if not name then 
        outputChatBox('Syntax: /' .. command .. ' [name]', player, 255, 255, 255)
        return 
    end
    local other = exports.players:getPlayerFromAlias(player, name)
    if not other then 
        return
    end
    local vehicle = getPedOccupiedVehicle(other)
    if not vehicle then
        return outputChatBox("Player is not in a vehicle", other, 255, 100, 100)
    end
    fixVehicle(vehicle)
    outputChatBox('Successfully repaired vehicle', other, 100, 255, 100)
end)
