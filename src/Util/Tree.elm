module Util.Tree exposing (..)

import List
import Parser
    exposing
        ( (|.)
        , (|=)
        , Parser
        , Step(..)
        , backtrackable
        , chompUntilEndOr
        , getChompedString
        , loop
        , oneOf
        , run
        , succeed
        , withIndent
        )


type Node
    = Node String (List Node)


hasChildren : Node -> Bool
hasChildren node =
    case node of
        Node _ children ->
            List.length children < 1


isTerminal : Node -> Bool
isTerminal =
    not << hasChildren


parse : String -> Result String Node
parse =
    Debug.todo "implement"


type alias Context =
    { indent : Int
    }


indent : Context -> Parser ()
indent context =
    succeed ()
        |> withIndent context.indent


name : Parser String
name =
    chompUntilEndOr "\n"
        |> getChompedString


line : Context -> Parser Node
line context =
    succeed (\n -> Node n [])
        |. backtrackable (indent context)
        |= name


nodes : Context -> Parser (List Node)
nodes context =
    loop [] (nodesHelper context)


nodesHelper : Context -> List Node -> Parser (Step (List Node) (List Node))
nodesHelper context reversedNodes =
    oneOf
        [ succeed (\node -> Loop (node :: reversedNodes))
            |= line context
        , succeed ()
            |> Parser.map (\_ -> Done (List.reverse reversedNodes))
        ]


nodeTree : Parser Node
nodeTree =
    Debug.todo "implement"
