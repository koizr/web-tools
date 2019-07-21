module Route exposing (Route(..), parse)

import Url exposing (Url)
import Url.Parser exposing (..)


type Route
    = Top
    | MultiLineText


parse : Url -> Maybe Route
parse url =
    Url.Parser.parse parser url


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Top top
        , map MultiLineText (s "text")
        ]
