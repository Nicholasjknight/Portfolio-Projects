Misc.SendMessage("Starting trap box script", 67)
Journal.Clear()
L = 1
while L == 1:
    if Player.BuffsExist("Paralyze") or Player.BuffsExist("Paralyzed"):
        Box = Items.FindByID(0x09A9, 0x0000, Player.Backpack.Serial)
        Misc.SendMessage("Using Trap Box", 67)
        Misc.Pause(150)
        Items.UseItem(Box)
        Misc.Pause(150)
        Items.Hide(Box)
    NerveStriked = Journal.Search("Your attacker dealt a crippling nerve strike!")
    if NerveStriked == True:
        Box = Items.FindByID(0x09A9, 0x0000, Player.Backpack.Serial)
        Misc.SendMessage("Using Trap Box", 67)
        Misc.Pause(500)
        Items.UseItem(Box)
        Misc.Pause(150)
        Items.Hide(Box)
        Journal.Clear()