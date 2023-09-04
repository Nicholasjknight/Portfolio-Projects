healHits = 35

while True:

    if Player.Hits <= healHits and Player.Visible:      
        Misc.Pause(300)            
        Items.UseItemByID(0x1727)               
        
