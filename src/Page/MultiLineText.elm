module Page.MultiLineText exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List
import Page.Element exposing (..)
import Set
import String
import Util exposing (applyThen)



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
    div []
        [ div [ class "left-pane" ]
            [ textarea [ value model.input, cols 100, rows 50, onInput Input ] []
            , div [] [ text (model.input |> numOfLine |> String.fromInt) ]
            , div
                []
                [ checkbox [ onCheck ChangeUnique ] "unique"
                , div []
                    [ radio [ name "oder", onClick (ChangeOrder Asc), checked (model.order == Asc) ] "Sort"
                    , radio [ name "oder", onClick (ChangeOrder Desc), checked (model.order == Desc) ] "Sort(DESC)"
                    ]
                , button [ onClick Convert ] [ text "Convert" ]
                ]
            ]
        , div [ class "right-pane" ]
            [ textarea [ value model.output, cols 100, rows 50, readonly True ] []
            , div [] [ text (model.output |> numOfLine |> String.fromInt) ]
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
