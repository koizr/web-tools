module Page.CharCounter exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Page.Element exposing (..)



-- Model


type alias Model =
    { text : String
    , counter : Int
    }


init : Model
init =
    { text = ""
    , counter = 0
    }


type Msg
    = Input String



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input s ->
            ( { model | text = s, counter = String.length s }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    div []
        [ div [ class "field" ]
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
