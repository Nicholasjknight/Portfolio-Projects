backpack = Player.Backpack.Serial
Poison = Items.FindByID(0x0F0A,-1,backpack)
Player.UseSkill("Poisoning")
Misc.Pause(800)
Target.TargetExecute(Poison)
Misc.Pause(800)
Target.TargetExecute(0x46950604)
