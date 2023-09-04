fil = Mobiles.Filter()
fil.Enabled = True
fil.RangeMax = 1
while not Player.IsGhost:
    enemies = Mobiles.ApplyFilter(fil)
    for enemy in enemies:
        if 2 <enemy.Notoriety < 7:
            if not Player.HasSpecial:
                Player.WeaponSecondarySA() # whirlwind in radiant scimitar/double axe
            Player.Attack(enemy.Serial)
            Misc.Pause(1250)
            break