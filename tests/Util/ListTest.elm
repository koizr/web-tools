module Util.ListTest exposing (suit)

import Expect
import Test exposing (..)
import Util.List exposing (..)


suit : Test
suit =
    describe "Util.List"
        [ describe "sortByIndex"
            [ test "sort by index" <|
                \_ ->
                    sortByIndex [ 100, 2, 5 ] [ "a", "b", "c" ]
                        |> Expect.equal [ "b", "c", "a" ]
            , test "if index is longer than target, index's extra elements are ignored" <|
                \_ ->
                    sortByIndex [ 100, 2, 5, 1, 3 ] [ "a", "b", "c" ]
                        |> Expect.equal [ "b", "c", "a" ]
            , test "if target is longer than index, target's extra elements are dropped" <|
                \_ ->
                    sortByIndex [ 100, 2, 5 ] [ "a", "b", "c", "d", "e" ]
                        |> Expect.equal [ "b", "c", "a" ]
            ]
        ]
