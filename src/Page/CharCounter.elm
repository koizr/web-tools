module Page.CharCounter exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Page.Element exposing (..)
import Page.Top exposing (Model)
import StringEx exposing (removeAll)



-- Model


type alias Model =
    { text : String
    , counter : Int
    , ignoreLineBreak : Bool
    }


init : Model
init =
    { text = ""
    , counter = 0
    , ignoreLineBreak = False
    }


setText : String -> Model -> Model
setText s model =
    { model | text = s, counter = length model.ignoreLineBreak s }


setIgnoreLineBreak : Bool -> Model -> Model
setIgnoreLineBreak ignore model =
    { model | ignoreLineBreak = ignore, counter = length ignore model.text }


type Msg
    = Input String
    | CheckIgnoreLineBreak Bool



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input s ->
            ( setText s model, Cmd.none )

        CheckIgnoreLineBreak checked ->
            ( setIgnoreLineBreak checked model, Cmd.none )


length : Bool -> String -> Int
length ignoreLineBreak s =
    if ignoreLineBreak then
        removeAll [ "\n", "\u{000D}" ] s |> String.length

    else
        String.length s



-- View


view : Model -> Html Msg
view model =
    div []
        [ div [ class "field" ]
            [ checkbox [ onCheck CheckIgnoreLineBreak ] "Ignore line break"
            ]
        , div [ class "field" ]
            [ textarea [ class "textarea", value model.text, cols 60, rows 30, onInput Input ] []
            , div [ style "text-align" "right" ] [ viewCounterText model.counter ]
            ]
        ]


viewCounterText : Int -> Html Msg
viewCounterText count =
    let
        unit =
            if count == 1 then
                "character"

            else
                "characters"
    in
    text (String.fromInt count ++ " " ++ unit)
