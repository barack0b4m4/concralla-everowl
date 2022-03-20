pos = Vector2(guiGetScreenSize())
size = Vector2(pos.y/8.5,pos.y/8.5)
font = dxCreateFont("fonts/font.ttf", 25)
cash = dxCreateFont("fonts/cash.ttf", 25)
ammo = dxCreateFont("fonts/ammo.ttf", 25)
addEventHandler("onClientRender",root,function()
    if localPlayer then
        local player = localPlayer
            if getElementHealth(player) then
                dxDrawRectangle(pos.x-size.x*0.02,pos.y-size.y*8.48,size.x*-3,size.y*2.45, tocolor(90, 85, 125, 150)) 
                dxDrawImage(pos.x-size.x*3.1,pos.y-size.y*8.52,size.x*3.1,size.y*1.5,"files/cerce.png",0,0,0, tocolor (90,85,125,255))
                dxDrawImage(pos.x-size.x*3.1,pos.y-size.y*6.97,size.x*3.1,size.y*1,"files/cerce.png",0,0,0, tocolor (90,85,125,255))
                dxDrawImage(pos.x-size.x*0.86,pos.y-size.y*6.85,size.x*0.7,size.y*0.7,"files/healt.png",0,0,0, tocolor (255,255,255,255))
        for i = 0,math.floor(getElementHealth(player)*0.1) do
             dxDrawImage(pos.x-size.x*0.85,pos.y-size.y*6.85,size.x*0.7,size.y*0.7,"files/nokta.png",i*36,0,0,tocolor(255,0,0,255))
        end
if getPedArmor(player) then
    dxDrawImage(pos.x-size.x*1.86,pos.y-size.y*6.85,size.x*0.7,size.y*0.7,"files/armor.png",0,0,0, tocolor (0,255,0,255))
for i = 0,math.floor(getPedArmor(player)*0.1) do
 dxDrawImage(pos.x-size.x*1.85,pos.y-size.y*6.85,size.x*0.7,size.y*0.7,"files/nokta.png",i*36,0,0,tocolor(0,200,0,255))
         end
        end
    end
         if getPedOxygenLevel(player) then
            dxDrawImage(pos.x-size.x*2.68,pos.y-size.y*6.7,size.x*0.35,size.y*0.35,"files/oxygen.png",0,0,0, tocolor (255,255,255,255))
        for i = 0,math.floor(getPedOxygenLevel(player)*0.01) do
         dxDrawImage(pos.x-size.x*2.85,pos.y-size.y*6.85,size.x*0.7,size.y*0.7,"files/nokta.png",i*36,0,0,tocolor(0,150,250,255))
end
    local money = getPlayerMoney (player)
    local arma = getPedWeapon (player)
    local ammoclip = getPedAmmoInClip ( localPlayer )
    local totalammo = getPedTotalAmmo ( localPlayer ) - ammoclip 
        dxDrawImage(pos.x-size.x*1.68,pos.y-size.y*7.99,size.x*0.4,size.y*0.4,"files/dolar.png",0,0,0, tocolor (255,255,255,255))
        dxDrawImage(pos.x-size.x*1.60,pos.y-size.y*7.55,size.x*0.3,size.y*0.3,"files/ammo.png",0,0,0, tocolor (255,255,255,255))
        dxDrawImage(pos.x-size.x*2.9,pos.y-size.y*8.4,size.x*1.2,size.y*1.2, "icons/"..arma..".png", 0, 0, 0, tocolor(255, 255, 255, 255))  
        dxDrawText(""..totalammo.."/"..ammoclip, pos.x-size.x*1.45,pos.y-size.y*13.65,size.x+pos.x-size.x,size.y+pos.y-size.y*2.1, tocolor(255, 155, 0, 255), 0.5, ammo, "center", "center")
        dxDrawText(""..money, pos.x-size.x*1.6,pos.y-size.y*14.44,size.x+pos.x-size.x,size.y+pos.y-size.y*2.1,  tocolor(0, 255, 0, 255), 0.4, cash, "center", "center")
    end
    dxDrawImage(pos.x-size.x*1.68,pos.y-size.y*8.4,size.x*0.4,size.y*0.4,"files/clock.png",0,0,0, tocolor (150,150,150,255))
    local saat , dakika = getTime()
    if dakika < 10 then
        dxDrawText(saat..":0"..dakika, pos.x-size.x*1.65,pos.y-size.y*15.25,size.x+pos.x-size.x,size.y+pos.y-size.y*2.1, tocolor(0, 0, 0, 255), 1, font, "center", "center")
    else
        dxDrawText(saat..":"..dakika, pos.x-size.x*1.65,pos.y-size.y*15.25,size.x+pos.x-size.x,size.y+pos.y-size.y*2.1, tocolor(0, 0, 0, 255), 1, font, "center", "center")
    end
    end
end
)