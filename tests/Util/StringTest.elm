module Util.StringTest exposing (suit)

import Expect
import Test exposing (..)
import Util.String exposing (..)


suit : Test
suit =
    describe "Util.String"
        [ describe "numOfLines"
            [ test "return number of lines in string" <|
                \_ ->
                    numOfLines "aaa\nbbb\nccc"
                        |> Expect.equal 3
            , test "return 0 if string is empty" <|
                \_ ->
                    numOfLines ""
                        |> Expect.equal 0
            ]
        , describe "numOfLinesText"
            [ test "return number of lines in string" <|
                \_ ->
                    numOfLinesText "aaa\nbbb\nccc"
                        |> Expect.equal "3 lines"
            , test "return 0 if string is empty" <|
                \_ ->
                    numOfLinesText ""
                        |> Expect.equal "0 lines"
            ]
        ]
