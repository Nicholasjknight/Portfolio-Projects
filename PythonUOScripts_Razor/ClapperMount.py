myPetSer = 0x04c5fbeb  # SET YOUR MOUNT SERIAL
# anti riding swipe remount for mages
###  by Mourn#8182 discord

Misc.SetSharedValue("havepet","False")
def setpet():
    Misc.SetSharedValue("mypet",0x04c5fbeb)
    Misc.SetSharedValue("havepet","True")

def curemount():
    strpet = Misc.ReadSharedValue('mypet')
    petser = int(strpet) 
    pet = Mobiles.FindBySerial(petser)
    if pet:        
        if pet.Poisoned:
            Spells.CastMysticism("Cleansing Winds")
            Target.WaitForTarget(2000,False)
            Target.TargetExecute(pet.Serial)
        if pet.Hits == pet.HitsMax and not pet.Poisoned:
            Mobiles.UseMobile(pet)    
                
if Misc.ReadSharedValue("havepet") == "False":
    setpet()
if Misc.ReadSharedValue("havepet") == "True":
    Player.ChatSay(30,'all follow me')
    curemount()
    
  