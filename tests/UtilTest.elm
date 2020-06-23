module UtilTest exposing (suit)

import Expect
import Test exposing (..)
import Util exposing (applyThen, flip)


suit : Test
suit =
    describe "Util"
        [ describe "applyThen"
            [ test "condition is True then, apply function" <|
                \_ ->
                    applyThen True ((+) 10) 1
                        |> Expect.equal 11
            , test "condition is False then, return value" <|
                \_ ->
                    applyThen False ((+) 10) 1
                        |> Expect.equal 1
            ]
        , describe "flip"
            [ test "flip two args function's args" <|
                \_ ->
                    flip (++) "abc" "def"
                        |> Expect.equal "defabc"
            ]
        ]
