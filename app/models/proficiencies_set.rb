class ProficienciesSet < Codex
  self.groups = {
    simple_weapons: %i(club dagger greatclub handaxe javelin light_hammer mace quarterstaff
                       sickle spear unarmed_strike light_crossbow dart shortbow sling),
    martial_weapons: %i(battleaxe flail glaive greataxe greatsword halberd lance longsword maul 
                        morningstar pike rapier scimitar shortsword trident war_pick warhammer whip 
                        blowgun hand_crossbow heavy_crossbow longbow net)
  }.freeze
end
