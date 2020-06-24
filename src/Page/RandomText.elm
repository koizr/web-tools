module Page.RandomText exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List
import Page.Element exposing (..)
import Random
import String
import Util.Clipboard as CB
import Util.Random exposing (Config, randomText)



-- Model


type alias Model =
    { config : Config
    , randomTexts : List String
    }


setLength : Int -> Model -> Model
setLength length model =
    let
        config =
            model.config
    in
    { model | config = { config | length = length } }


setLowerCaseAlphabet : Bool -> Model -> Model
setLowerCaseAlphabet use model =
    let
        config =
            model.config
    in
    { model | config = { config | lowerCaseAlphabet = use } }


setUpperCaseAlphabet : Bool -> Model -> Model
setUpperCaseAlphabet use model =
    let
        config =
            model.config
    in
    { model | config = { config | upperCaseAlphabet = use } }


setNumber : Bool -> Model -> Model
setNumber use model =
    let
        config =
            model.config
    in
    { model | config = { config | number = use } }


setSymbols : String -> Model -> Model
setSymbols symbols model =
    let
        config =
            model.config
    in
    { model | config = { config | symbols = symbols } }


type Msg
    = InputLength String
    | CheckLowerCaseAlphabet Bool
    | CheckUpperCaseAlphabet Bool
    | CheckNumber Bool
    | InputSymbols String
    | Shuffle
    | GenerateRandomTexts (List String)


init : Model
init =
    { config =
        { length = 30
        , lowerCaseAlphabet = True
        , upperCaseAlphabet = True
        , number = True
        , symbols = ""
        }
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
                    ( setLength length model, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        CheckLowerCaseAlphabet checked ->
            ( setLowerCaseAlphabet checked model, Cmd.none )

        CheckUpperCaseAlphabet checked ->
            ( setUpperCaseAlphabet checked model, Cmd.none )

        CheckNumber checked ->
            ( setNumber checked model, Cmd.none )

        InputSymbols symbols ->
            ( setSymbols symbols model, Cmd.none )

        Shuffle ->
            ( model
            , Random.generate GenerateRandomTexts (randomTextsGenerator 10 model.config)
            )

        GenerateRandomTexts randomTexts ->
            ( { model | randomTexts = randomTexts }, Cmd.none )


randomTextsGenerator : Int -> Config -> Random.Generator (List String)
randomTextsGenerator quantity config =
    Random.list quantity (randomText config)



-- View


view : Model -> Html Msg
view model =
    div []
        [ contents
            [ formLabel "Includes"
            , formGroup
                [ checkbox
                    [ onCheck CheckLowerCaseAlphabet
                    , checked model.config.lowerCaseAlphabet
                    ]
                    "lower case alphabet"
                ]
            , formGroup
                [ checkbox
                    [ onCheck CheckUpperCaseAlphabet
                    , checked model.config.upperCaseAlphabet
                    ]
                    "UPPER CASE ALPHABET"
                ]
            , formGroup
                [ checkbox
                    [ onCheck CheckNumber
                    , checked model.config.number
                    ]
                    "Number"
                ]
            , formGroup
                (inputText
                    [ style "width" "20rem"
                    , onInput InputSymbols
                    , value model.config.symbols
                    ]
                    "Symbols"
                )
            , formGroup
                (inputNumber
                    [ step "1"
                    , style "width" "10rem"
                    , onInput InputLength
                    , value (String.fromInt model.config.length)
                    ]
                    "Length of characters"
                )
            , formGroup
                [ buttonMain "Generate" Shuffle
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
