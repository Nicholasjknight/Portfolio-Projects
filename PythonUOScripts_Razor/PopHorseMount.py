# Use Faction Horse from backpack
# If Gump press keys if not dclick on horse in backpack
# 0x0076 horse in world
# 0x2124 horse in backpack
from System.Collections.Generic import List
from System import Byte

num = List[int]([1])

def dclick_horse():
    Items.UseItemByID(0x2124,-1)
    Gumps.WaitForGump(9024,750)
    Misc.Pause(600)
    Gumps.SendAdvancedAction(9024,2,num)

    
def useHorse():
    ls = Mobiles.Filter()
    ls.Enabled = True
    ls.RangeMax = 1
    ls.Bodies = List[int]([0x00E2,0x0076,0x0072,0x00CC])
    ls.Notorieties = List[Byte](bytes([1,2,3,6]))
    found = Mobiles.ApplyFilter(ls)
    #Misc.SendMessage(len(found),33)
    for i in found:
        Mobiles.UseMobile(i)
        Mobiles.Message(i,69,'My horse')


if Gumps.HasGump() and Gumps.CurrentGump() == 9024:
    Gumps.SendAdvancedAction(9024,2,num)
    m = Player.GetItemOnLayer('Mount')
    for i in range(5):
        if m:
            break
        Misc.Pause(250)
        Player.ChatSay(59,'all follow me')
        Misc.Pause(250)
        useHorse()
        m = Player.GetItemOnLayer('Mount')
    
else:
    dclick_horse()
    m = Player.GetItemOnLayer('Mount')
    for i in range(5):
        if m:
            break
        Misc.Pause(250)
        Player.ChatSay(59,'all follow me')
        Misc.Pause(250)
        useHorse()
        m = Player.GetItemOnLayer('Mount')
    
    
        