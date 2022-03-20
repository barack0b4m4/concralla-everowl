addEventHandler ( "onPlayerJoin", root, 
    function () 
        setPlayerHudComponentVisible ( source, "all", false ) 
        setPlayerHudComponentVisible ( source, "radar", true )  
        setPlayerHudComponentVisible ( source, "area_name", true )  
        setPlayerHudComponentVisible ( source, "vehicle_name", true )  
        setPlayerHudComponentVisible ( source, "crosshair", true )  

    end 
) 