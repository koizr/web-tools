module Page.MultiLineText exposing (Model, Msg, byLine, init, numOfLine, unique, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List
import Page.Element exposing (..)
import Set
import String
import Util exposing (applyThen, flip)



-- Model


type alias Model =
    { input : String
    , output : String
    , order : Order
    , unique : Bool
    }


type Order
    = Asc
    | Desc


{-| 行ごとに分割したリストに対して関数を適用する。空行は削除される
-}
byLine : (List String -> List String) -> String -> String
byLine f s =
    s
        |> String.lines
        |> List.filter (String.isEmpty >> not)
        |> f
        |> String.join "\n"


init : Model
init =
    { input = ""
    , output = ""
    , order = Asc
    , unique = False
    }



-- Update


type Msg
    = Input String
    | ChangeUnique Bool
    | ChangeOrder Order
    | Convert


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input s ->
            ( { model | input = s }, Cmd.none )

        ChangeUnique enabled ->
            ( { model | unique = enabled }, Cmd.none )

        ChangeOrder ord ->
            ( { model | order = ord }, Cmd.none )

        Convert ->
            let
                sort =
                    case model.order of
                        Asc ->
                            List.sort

                        Desc ->
                            List.sort >> List.reverse

                output =
                    applyThen model.unique (byLine unique) model.input |> byLine sort
            in
            ( { model | output = output }, Cmd.none )


{-| 重複行を削除する
Set の仕様によりソートされてしまう
-}
unique : List String -> List String
unique s =
    s |> Set.fromList |> Set.toList



--  View


view : Model -> Html Msg
view model =
    div [ class "multiline-text" ]
        [ div [ class "field" ]
            [ textarea [ class "textarea", value model.input, cols 60, rows 30, onInput Input ] []
            , div [ style "text-align" "right" ] [ text (numOfLineText model.input) ]
            ]
        , div [ class "multiline-text__control-menu" ]
            [ div [ class "field" ]
                [ checkbox [ onCheck ChangeUnique ] "unique"
                ]
            , div [ class "field" ]
                [ radio [ name "order", onClick (ChangeOrder Asc), checked (model.order == Asc) ] "Sort"
                , br [] []
                , radio [ name "order", onClick (ChangeOrder Desc), checked (model.order == Desc) ] "Sort(DESC)"
                ]
            , div [ class "field" ]
                [ button [ class "button is-primary", onClick Convert ] [ text "Convert" ]
                ]
            ]
        , div []
            [ textarea [ class "textarea", value model.output, cols 60, rows 30, readonly True ] []
            , div [ style "text-align" "right" ] [ text (numOfLineText model.output) ]
            ]
        ]


{-| 行数を返す。 1 文字もないときは 0 行とする
-}
numOfLine : String -> Int
numOfLine s =
    if String.isEmpty s then
        0

    else
        s |> String.lines |> List.length


numOfLineText : String -> String
numOfLineText s =
    s |> numOfLine |> String.fromInt |> (flip (++) <| " lines")
