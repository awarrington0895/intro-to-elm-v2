module AbilityScores exposing (AbilityScore, AbilityScores, fromInt, empty, modifier)

type AbilityScore = AbilityScore Int

type alias AbilityScores =
  { strength : AbilityScore
  , dexterity : AbilityScore
  , constitution : AbilityScore
  , intelligence : AbilityScore
  , wisdom : AbilityScore
  , charisma : AbilityScore
  }

upperBound : Int
upperBound = 30

lowerBound : Int
lowerBound = 0

fromInt : Int -> Maybe AbilityScore
fromInt x = 
  if x < lowerBound || x > upperBound then
    Nothing
  else
    Just (AbilityScore x)

empty : AbilityScores
empty = 
  { strength = AbilityScore 10
  , dexterity = AbilityScore 10
  , constitution = AbilityScore 10
  , intelligence = AbilityScore 10
  , wisdom = AbilityScore 10
  , charisma = AbilityScore 10
  }

modifier : AbilityScore -> Int
modifier (AbilityScore score) =
  (score // 2) - 5