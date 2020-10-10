module Util.String exposing (numOfLines, numOfLinesText)

import Util exposing (flip)


numOfLines : String -> Int
numOfLines s =
    if String.isEmpty s then
        0

    else
        s |> String.lines |> List.length


numOfLinesText : String -> String
numOfLinesText s =
    s
        |> numOfLines
        |> String.fromInt
        |> (flip (++) <| " lines")
