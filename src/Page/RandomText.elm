module Page.RandomText exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Page.Element exposing (..)
import Random
import Random.Char exposing (english)
import Random.String exposing (string)
import String



-- Model


type alias Model =
    { length : Int
    , randomText : String
    }


type Msg
    = InputLength String
    | Shuffle
    | Generate String


init : Model
init =
    { length = 30
    , randomText = ""
    }



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputLength lenString ->
            let
                maybeLength =
                    String.toInt lenString
            in
            case maybeLength of
                Just length ->
                    ( { model | length = length }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        Shuffle ->
            ( model
            , Random.generate Generate (randomTextGenerator model.length)
            )

        Generate randomText ->
            ( { model | randomText = randomText }, Cmd.none )


randomTextGenerator : Int -> Random.Generator String
randomTextGenerator length =
    string length english



-- View


view : Model -> Html Msg
view model =
    div []
        [ section [ class "section" ]
            [ div [ class "field" ]
                [ div [ class "control" ]
                    [ label [ class "label" ] [ text "Length of characters" ]
                    , input
                        [ type_ "number"
                        , step "1"
                        , class "input"
                        , style "width" "10rem"
                        , onInput InputLength
                        , value (String.fromInt model.length)
                        ]
                        []
                    ]
                ]
            , div [ class "field" ]
                [ div [ class "control" ]
                    [ button [ class "button is-primary", onClick Shuffle ] [ text "Generate" ]
                    ]
                ]
            ]
        , section [ class "section" ]
            (case model.randomText of
                "" ->
                    []

                _ ->
                    [ div [ class "list is-hoverable" ]
                        [ a [ class "list-item" ] [ text model.randomText ] ]
                    ]
            )
        ]
