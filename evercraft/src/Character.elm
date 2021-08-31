module Character exposing (Character, empty, name, attack)
import Lens exposing (Lens)
import AbilityScores exposing (AbilityScores, AbilityScore)

type Alignment
  = Good
  | Neutral
  | Evil

type alias Character =
  { name : String
  , maxHp : Int
  , alignment : Alignment
  , armorClass : Int
  , damageTaken : Int
  , abilityScores : AbilityScores
  }

empty : Character
empty =
  { name = ""
  , maxHp = 5
  , alignment = Good
  , armorClass = 10
  , damageTaken = 0
  , abilityScores = AbilityScores.empty
  }

name : Lens Character String
name =
  Lens.lens .name (\b a -> { a | name = b})

maxHp : Lens Character Int
maxHp =
  Lens.lens 
    (\a -> a.maxHp + (AbilityScores.modifier a.abilityScores.constitution))
    (\b a -> { a | maxHp = b})

armorClass : Lens Character Int
armorClass =
  Lens.lens 
    effectiveArmorClass
   (\b a -> { a | armorClass = b})

damageTaken : Lens Character Int
damageTaken =
  Lens.lens .damageTaken (\b a -> { a | damageTaken = b})

strengthModifier : Character -> Int
strengthModifier char = AbilityScores.modifier char.abilityScores.strength
  

takeDamage : Int -> Character -> Character
takeDamage amount character =
  damageTaken.over (\x -> x + amount) character

attack : Character -> Character -> Int -> Character
attack attacker defender roll =
  let
    modifiedRoll = attackRoll roll attacker
  in
  if roll == 20 then
    takeDamage ((calcDamage attacker) * 2) defender
  else if modifiedRoll >= (armorClass.view defender) then
    takeDamage (calcDamage attacker) defender
  else 
    defender

attackRoll : Int -> Character -> Int
attackRoll roll char =
  roll + (strengthModifier char)

calcDamage : Character -> Int
calcDamage char =
  1 + (strengthModifier char)

effectiveArmorClass : Character -> Int
effectiveArmorClass char = 
  char.armorClass + (AbilityScores.modifier char.abilityScores.dexterity)






