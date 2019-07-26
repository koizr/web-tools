module Page.MultiLineText exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List
import Set
import String



-- Model


type alias Model =
    { text : String }


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
    { text = "" }



-- Update


type Msg
    = Input String
    | Unique
    | Sort
    | SortDesc


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input s ->
            ( { text = s }, Cmd.none )

        Unique ->
            let
                uniqued =
                    model.text |> byLine unique
            in
            ( { model | text = uniqued }, Cmd.none )

        Sort ->
            let
                sorted =
                    model.text |> byLine List.sort
            in
            ( { model | text = sorted }, Cmd.none )

        SortDesc ->
            let
                sorted =
                    model.text |> byLine (List.sort >> List.reverse)
            in
            ( { model | text = sorted }, Cmd.none )


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
        [ textarea [ value model.text, cols 100, rows 50, onInput Input ] []
        , div
            []
            [ button [ onClick Unique ] [ text "unique" ]
            , button [ onClick Sort ] [ text "sort" ]
            , button [ onClick SortDesc ] [ text "sort (DESC)" ]
            ]
        ]
