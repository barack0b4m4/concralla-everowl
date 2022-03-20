local FPSLimit, lastTick, framesRendered, FPS = 100, getTickCount(), 0, 0
local sX, sY = guiGetScreenSize()
addEventHandler("onClientRender",root,
function()
    local currentTick = getTickCount()
    local elapsedTime = currentTick - lastTick
    if elapsedTime >= 1000 then
        FPS = framesRendered
        lastTick = currentTick
        framesRendered = 2
    else
        framesRendered = framesRendered + 1
   end
 if FPS > FPSLimit then
    FPS = FPSLimit
   end
            
	local playerPing = getPlayerPing ( localPlayer ) 
           local hours = getRealTime().hour
           local minutes = getRealTime().minute
           local seconds = getRealTime().second
  
    dxDrawText("  #000000Time: "..hours..":"..minutes..":"..seconds.."  |  FPS: "..tostring(FPS).."  |  Ping: "..playerPing.." ms ",sX-328,sY,10,sY-16,tocolor(0,0,0,255),1.01,"default-bold","left","center",false,false,true,true)
    
	dxDrawText("  #0087f7Time: #EEFFEE"..hours..":"..minutes..":"..seconds.."  #bb0000|  #0087f7FPS: #EEFFEE"..tostring(FPS).."  #bb0000|  #0087f7Ping: #EEFFEE"..playerPing.." ms ",sX-328,sY,10,sY-16,tocolor(0,153,255,255),1,"default-bold","left","center",false,false,true,true)   
end
)
