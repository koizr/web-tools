module Page.RandomText exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List
import Page.Element exposing (..)
import Random
import Random.Char exposing (english)
import Random.String exposing (string)
import String
import Util.Clipboard as CB



-- Model


type alias Model =
    { length : Int
    , randomTexts : List String
    }


type Msg
    = InputLength String
    | Shuffle
    | GenerateRandomTexts (List String)


init : Model
init =
    { length = 30
    , randomTexts = []
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
            , Random.generate GenerateRandomTexts (randomTextsGenerator model.length)
            )

        GenerateRandomTexts randomTexts ->
            ( { model | randomTexts = randomTexts }, Cmd.none )


randomTextsGenerator : Int -> Random.Generator (List String)
randomTextsGenerator length =
    Random.list 10 (string length english)



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
            (case model.randomTexts of
                [] ->
                    []

                _ ->
                    [ ul [ class "list is-hoverable" ]
                        (List.map viewRandomText model.randomTexts)
                    ]
            )
        ]


viewRandomText : String -> Html Msg
viewRandomText randomText =
    li
        [ class "list-item"
        , CB.copyToClipboarcOnClick
        , CB.dataClipboardTarget randomText
        ]
        [ span [ id randomText ] [ text randomText ] ]
