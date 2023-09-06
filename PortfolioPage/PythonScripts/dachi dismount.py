lastTarg = Target.GetLast()
L = 1
while L == 1:
    if Player.InRangeMobile(lastTarg, 0) and Target.HasTarget and Player.Visible:
        Mobiles.UseMobile(0x04527F7B)
        Player.WeaponSecondarySA()
        Player.Attack(lastTarg)
        Misc.Pause(750)
        break
        