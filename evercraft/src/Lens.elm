module Lens exposing (Lens, lens)

type alias Lens a b = 
  { view : a -> b
  , set : b -> a -> a
  , over : (b -> b) -> a -> a
  }

lens : (a -> b) -> (b -> a -> a) -> Lens a b
lens view set =
  let
      over : (b -> b) -> a -> a
      over fn a = set (fn (view a)) a
  in
  Lens view set over
