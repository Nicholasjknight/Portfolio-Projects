class AntiDisarmer(object):
    def haveTwoHanded(self):
        if Player.GetItemOnLayer("RightHand"):
            return False
            
        item = Player.GetItemOnLayer("LeftHand")
    
        if not item:
            return False
        
        Items.WaitForProps(item, 1000)
        
        return Items.GetPropValue(item, "Weapon Damage") > 0
    
    def haveDisarm(self):
        for buff in Player.Buffs:
            if buff.lower().find("norearm") >= 0:
                return True
                
        return False        
        
    def getWeapon(self):
        weapon = Player.GetItemOnLayer("RightHand")
        
        if self.haveTwoHanded():
            weapon = Player.GetItemOnLayer("LeftHand")
            
        return weapon    
        
    def Main(self):
        haveDisarm = self.haveDisarm()
        needRearm = False
        weapon = self.getWeapon()
            
        while True:
            Misc.Pause(250)
            
            if Player.IsGhost:
                continue
            
            if not Timer.Check("check-weapon"):
                if not self.haveDisarm():
                    newWeapon = self.getWeapon()
                    
                    if newWeapon:
                        weapon = newWeapon
                    
                Timer.Create("check-weapon", 1000)    
                
            if not haveDisarm and self.haveDisarm():
                haveDisarm = True
                
                Misc.SendMessage("Disarm detected", 38)
                
                continue
                
            if haveDisarm and not self.haveDisarm():
                haveDisarm = False
                needRearm = True
      
            if needRearm and not self.getWeapon():
                Player.EquipItem(weapon)
                continue
                
            if needRearm and self.getWeapon():
                needRearm = False
                    
        
antiDisarmer = AntiDisarmer()
antiDisarmer.Main()        