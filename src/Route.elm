module Route exposing (Route(..), parse, paths)

import Url exposing (Url)
import Url.Parser exposing (..)


type Route
    = Top
    | MultiLineText
    | RandomText
    | CharCounter
    | RandomGrouping


type alias Paths =
    { multilineText : String
    , randomText : String
    , charCounter : String
    , randomGrouping : String
    }


paths : Paths
paths =
    { multilineText = "sort"
    , randomText = "random-text"
    , charCounter = "counter"
    , randomGrouping = "random-group"
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
        , map RandomGrouping (s paths.randomGrouping)
        ]
