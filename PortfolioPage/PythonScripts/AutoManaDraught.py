import sys
from System.Collections.Generic import List

Draught = 0x0FFB
AddMana = 18

while True:

    if Player.Mana <= AddMana and Target.HasTarget and Player.Visible:           
        Misc.Pause(300)            
        Items.UseItemByID(Draught)               
        
