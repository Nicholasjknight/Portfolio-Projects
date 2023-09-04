from System.Collections.Generic import List
from System import Byte
fil = Mobiles.Filter()
fil.Enabled = True
fil.RangeMax = 7
fil.Notorieties = List[Byte](bytes([3,4]))

enemies = Mobiles.ApplyFilter(fil)
Mobiles.Select(enemies,'Nearest')
for enemy in enemies:
    Player.Attack(enemy)
    Items.UseItemByID(0x0e9c)
    Misc.Pause(750)
    Spells.CastMastery("Despair")
    Misc.Pause(2200)
    Target.TargetExecute(enemy)
    Target.ClearLast()
    