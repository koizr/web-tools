module Util.Random exposing (Config, randomLetter, randomText)

import Array
import Random
import Util exposing (applyThen, flip)


type alias Config =
    { length : Int
    , lowerCaseAlphabet : Bool
    , upperCaseAlphabet : Bool
    , number : Bool
    , symbols : String
    , excludeSimilarLetters : Bool
    }


randomText : Config -> Random.Generator String
randomText config =
    let
        chars =
            ""
                |> applyThen config.lowerCaseAlphabet ((++) lowerCaseAlphabet)
                |> applyThen config.upperCaseAlphabet ((++) upperCaseAlphabet)
                |> applyThen config.number ((++) number)
                |> applyThen config.excludeSimilarLetters (removeSimilar similarLetters)
                |> (++) config.symbols
    in
    Random.map String.concat (Random.list config.length (randomLetter chars))


randomLetter : String -> Random.Generator String
randomLetter s =
    let
        getAt : Int -> Maybe Char
        getAt =
            String.toList s
                |> Array.fromList
                |> flip Array.get

        getAtOrEmpty : Int -> String
        getAtOrEmpty i =
            case getAt i of
                Just c ->
                    String.fromChar c

                Nothing ->
                    ""

        randomIndex : Random.Generator Int
        randomIndex =
            Random.int 0 (String.length s - 1)
    in
    Random.map getAtOrEmpty randomIndex


lowerCaseAlphabet : String
lowerCaseAlphabet =
    String.toLower upperCaseAlphabet


upperCaseAlphabet : String
upperCaseAlphabet =
    "ABCDEFGHIJKLMNOPQRLTUVWXYZ"


number : String
number =
    "1234567890"


similarLetters : List String
similarLetters =
    List.concatMap identity [ [ "1", "l", "I" ], [ "0", "o", "O" ], [ "9", "q" ] ]


removeSimilar : List String -> String -> String
removeSimilar letters s =
    case letters of
        [] ->
            s

        x :: xs ->
            removeSimilar xs (String.replace x "" s)
