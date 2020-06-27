module StringExTest exposing (testRemoveAll, testReplaceAll)

import Expect
import StringEx exposing (removeAll, replaceAll)
import Test exposing (..)
import Util exposing (flip)


testReplaceAll : Test
testReplaceAll =
    describe "replaceAll"
        [ test "replace all" <|
            \_ ->
                [ ( "a", "A" ), ( "b", "B" ) ]
                    |> flip replaceAll "abcabcaxbycz"
                    |> Expect.equal "ABcABcAxBycz"
        , test "replace all chars" <|
            \_ ->
                [ ( "abc", "ABC" ), ( "def", "xyz" ) ]
                    |> flip replaceAll "oiassdhabclkajolseeeabczlkdeflagselk"
                    |> Expect.equal "oiassdhABClkajolseeeABCzlkxyzlagselk"
        , test "replace sequential" <|
            \_ ->
                [ ( "abc", "ABC" ), ( "ABC", "xyz" ) ]
                    |> flip replaceAll "abc"
                    |> Expect.equal "xyz"
        , test "not replace" <|
            \_ ->
                []
                    |> flip replaceAll "abcabcaxbycz"
                    |> Expect.equal "abcabcaxbycz"
        ]


testRemoveAll : Test
testRemoveAll =
    describe "removeAll"
        [ test "remove all" <|
            \_ ->
                [ "abc", "xyz" ]
                    |> flip removeAll "abcdefghixyzjkl"
                    |> Expect.equal "defghijkl"
        ]
