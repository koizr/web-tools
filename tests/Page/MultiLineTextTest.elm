module Page.MultiLineTextTest exposing (suit)

import Expect
import List
import Page.MultiLineText exposing (byLine, numOfLine, unique)
import Test exposing (..)


suit : Test
suit =
    describe "Page.MultiLineText"
        [ describe "unique"
            [ test "distinct strings" <|
                \_ ->
                    [ "abc", "def", "abc" ]
                        |> unique
                        |> Expect.equal [ "abc", "def" ]
            ]
        , describe "byLine"
            [ test "apply function to by line of string" <|
                \_ ->
                    "abc\ndef\nghi"
                        |> byLine (List.map (\s -> s ++ "!!!"))
                        |> Expect.equal "abc!!!\ndef!!!\nghi!!!"
            ]
        , describe "numOfLine"
            [ test "empty" <|
                \_ ->
                    ""
                        |> numOfLine
                        |> Expect.equal 0
            , test "1 line" <|
                \_ ->
                    "aaa"
                        |> numOfLine
                        |> Expect.equal 1
            , test "3 line" <|
                \_ ->
                    "aaa\nbbb\nccc"
                        |> numOfLine
                        |> Expect.equal 3
            ]
        ]
