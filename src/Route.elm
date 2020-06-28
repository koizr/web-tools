module Route exposing (Route(..), parse, paths)

import Url exposing (Url)
import Url.Parser exposing (..)


type Route
    = Top
    | MultiLineText
    | RandomText
    | CharCounter
    | Tree


type alias Paths =
    { multilineText : String
    , randomText : String
    , charCounter : String
    , tree : String
    }


paths : Paths
paths =
    { multilineText = "sort"
    , randomText = "random"
    , charCounter = "counter"
    , tree = "tree"
    }


parse : Url -> Maybe Route
parse url =
    Url.Parser.parse parser url


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Top top
        , map MultiLineText (s paths.multilineText)
        , map RandomText (s paths.randomText)
        , map CharCounter (s paths.charCounter)
        , map Tree (s paths.tree)
        ]
