module Util.TupleTest exposing (suit)

import Expect
import Test exposing (..)
import Util.Tuple exposing (..)


suit : Test
suit =
    describe "Util.Tuple"
        [ describe "apply"
            [ test "apply tuple that has two elements to function that needs two arguments" <|
                \_ ->
                    apply String.repeat ( 3, "A" )
                        |> Expect.equal "AAA"
            ]
        ]
