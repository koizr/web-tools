module Util.List exposing (..)

import Util exposing (zip)


sortByIndex : List Int -> List a -> List a
sortByIndex indexes list =
    list
        |> zip indexes
        |> List.sortBy Tuple.first
        |> List.map Tuple.second
