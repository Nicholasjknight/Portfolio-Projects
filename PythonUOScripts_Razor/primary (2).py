from System.Collections.Generic import List
from System import Byte
def Main():
    eNumber = 0
    lastTarg = Target.GetLast()
    fil = Mobiles.Filter()
    fil.Enabled = True
    fil.RangeMax = 1
    fil.Notorieties = List[Byte](bytes([5]))
    while not Player.IsGhost:
        enemies = Mobiles.ApplyFilter(fil)
        Mobiles.Select(enemies, "last")
        for lastTarg in enemies:
            eNumber += 1
        if eNumber == 1:
            eNumber = 0
            if not Player.HasSpecial:
                Player.WeaponSecondarySA()
            Mobiles.UseMobile(0x04527F7B)
            Player.Attack(lastTarg)
            
        if eNumber > 2 :
            eNumber = 0
            if not Player.HasSpecial:
                Player.WeaponSecondarySA()
            Mobiles.UseMobile(0x04527F7B)
            Player.Attack(lastTarg)      
            Misc.Pause(250)
Main()
