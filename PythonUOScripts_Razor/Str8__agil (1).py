backpack = Player.Backpack.Serial
while True:
    agility = Items.FindByID(0x0F08,-1,backpack)
    strength = Items.FindByID(0x0F09,0x0000,backpack)
    petal = Items.FindByID(0x1021,-1,backpack)
    Misc.Pause(150)

    if not Player.BuffsExist('Agility'):
        Items.UseItem(agility)
        Misc.Pause(1000)  
    if not Player.BuffsExist('Strength'):
        Items.UseItem(strength)
        Misc.Pause(1000)   
    if not Player.BuffsExist('Orange Petals'):
        Items.UseItem(petal)
        Misc.Pause(1000)