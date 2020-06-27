module StringEx exposing (removeAll, replaceAll)

import List


{-| replacce all pairs
-}
replaceAll : List ( String, String ) -> String -> String
replaceAll replaces s =
    case replaces of
        [] ->
            s

        ( before, after ) :: xs ->
            replaceAll xs (String.replace before after s)


{-| remove all strings from s
-}
removeAll : List String -> String -> String
removeAll targets s =
    replaceAll (List.map pairWithEmpty targets) s


pairWithEmpty : String -> ( String, String )
pairWithEmpty s =
    ( s, "" )
