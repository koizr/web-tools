module UtilTest exposing (suit)

import Expect
import Test exposing (..)
import Util exposing (applyThen, divide, flip, zip)


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
        , describe "zip"
            [ test "zip two lists as tuple" <|
                \_ ->
                    zip [ 2, 3, 4 ] [ "a", "b", "c" ]
                        |> Expect.equal [ ( 2, "a" ), ( 3, "b" ), ( 4, "c" ) ]
            , test "first list is longer than second list then first list's extra elements are dropped" <|
                \_ ->
                    zip [ 2, 3, 4, 5, 6 ] [ "a", "b", "c" ]
                        |> Expect.equal [ ( 2, "a" ), ( 3, "b" ), ( 4, "c" ) ]
            , test "second list is longer than first list then second list's extra elements are dropped" <|
                \_ ->
                    zip [ 2, 3, 4 ] [ "a", "b", "c", "d", "e", "f" ]
                        |> Expect.equal [ ( 2, "a" ), ( 3, "b" ), ( 4, "c" ) ]
            ]
        , describe "divide"
            [ test "divide list by 3 elements" <|
                \_ ->
                    divide 3 [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
                        |> Expect.equal [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ]
            , test "divide list by 3 elements then extra elements are packed as an element" <|
                \_ ->
                    divide 3 [ 1, 2, 3, 4, 5 ]
                        |> Expect.equal [ [ 1, 2, 3 ], [ 4, 5 ] ]
            , test "divide empty list then return empty list" <|
                \_ ->
                    divide 1 []
                        |> Expect.equal []
            ]
        ]
