module Util exposing (compose)


compose : (b -> c) -> (a -> b) -> (a -> c)
compose f g =
    \x -> x |> g |> f
