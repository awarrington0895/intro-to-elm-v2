module Character exposing (Character, empty, name, maxHp, armorClass, damageTaken, attack)
import Lens exposing (Lens)

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
  }

empty : Character
empty =
  { name = ""
  , maxHp = 5
  , alignment = Good
  , armorClass = 10
  , damageTaken = 0
  }

name : Lens Character String
name =
  Lens.lens .name (\b a -> { a | name = b})

maxHp : Lens Character Int
maxHp =
  Lens.lens .maxHp (\b a -> { a | maxHp = b})

armorClass : Lens Character Int
armorClass =
  Lens.lens .armorClass (\b a -> { a | armorClass = b})

damageTaken : Lens Character Int
damageTaken =
  Lens.lens .damageTaken (\b a -> { a | damageTaken = b})

takeDamage : Int -> Character -> Character
takeDamage amount character =
  damageTaken.over (\x -> x + amount) character

attack : Character -> Character -> Int -> Character
attack attacker defender roll =
  if roll >= (armorClass.view defender) then
    takeDamage 1 defender
  else if roll == 20 then
    takeDamage 1 defender
  else 
    defender






