fil = Mobiles.Filter()
fil.Enabled = True
fil.RangeMax = 2
while not Player.IsGhost:
    enemies = Mobiles.ApplyFilter(fil)
    Mobiles.Select(enemies, "Nearest")
    for enemy in enemies:
        if 2 <enemy.Notoriety < 7:
            if not Player.HasSpecial:
                Player.WeaponPrimarySA()
            Player.Attack(enemy.Serial)
            Misc.Pause(1250)
            break