module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Page.CharCounter
import Page.MultiLineText
import Page.RandomText
import Page.Top
import Route exposing (Route)
import Url



-- Main


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- Model


type alias Model =
    { key : Nav.Key
    , page : Page
    }


type Page
    = NotFound
    | Top Page.Top.Model
    | MultiLineText Page.MultiLineText.Model
    | RandomText Page.RandomText.Model
    | CharCounter Page.CharCounter.Model


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    Model key (Top Page.Top.init)
        |> goTo (Route.parse url)



-- Update


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | TopMsg Page.Top.Msg
    | MultiLineTextMsg Page.MultiLineText.Msg
    | RandomTextMsg Page.RandomText.Msg
    | CharCounterMsg Page.CharCounter.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked request ->
            case request of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            goTo (Route.parse url) model

        TopMsg pageMsg ->
            case model.page of
                Top pageModel ->
                    let
                        ( newModel, newCmd ) =
                            Page.Top.update pageMsg pageModel
                    in
                    ( { model | page = Top newModel }
                    , Cmd.map TopMsg newCmd
                    )

                _ ->
                    ( model, Cmd.none )

        MultiLineTextMsg pageMsg ->
            case model.page of
                MultiLineText pageModel ->
                    let
                        ( newModel, newCmd ) =
                            Page.MultiLineText.update pageMsg pageModel
                    in
                    ( { model | page = MultiLineText newModel }
                    , Cmd.map MultiLineTextMsg newCmd
                    )

                _ ->
                    ( model, Cmd.none )

        RandomTextMsg pageMsg ->
            case model.page of
                RandomText pageModel ->
                    let
                        ( newModel, newCmd ) =
                            Page.RandomText.update pageMsg pageModel
                    in
                    ( { model | page = RandomText newModel }
                    , Cmd.map RandomTextMsg newCmd
                    )

                _ ->
                    ( model, Cmd.none )

        CharCounterMsg pageMsg ->
            case model.page of
                CharCounter pageModel ->
                    let
                        ( newModel, newCmd ) =
                            Page.CharCounter.update pageMsg pageModel
                    in
                    ( { model | page = CharCounter newModel }
                    , Cmd.map CharCounterMsg newCmd
                    )

                _ ->
                    ( model, Cmd.none )


goTo : Maybe Route -> Model -> ( Model, Cmd Msg )
goTo maybeRoute model =
    case maybeRoute of
        Nothing ->
            ( { model | page = NotFound }, Cmd.none )

        Just Route.Top ->
            ( { model | page = Top Page.Top.init }, Cmd.none )

        Just Route.MultiLineText ->
            ( { model | page = MultiLineText Page.MultiLineText.init }, Cmd.none )

        Just Route.RandomText ->
            ( { model | page = RandomText Page.RandomText.init }, Cmd.none )

        Just Route.CharCounter ->
            ( { model | page = CharCounter Page.CharCounter.init }, Cmd.none )



-- Subscription


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- View


view : Model -> Browser.Document Msg
view model =
    { title = "Web tools"
    , body =
        [ div [ class "container" ]
            [ nav [ class "navbar header" ]
                [ div [ class "header__logo" ]
                    [ a [ href "/" ] [ text "Tools" ]
                    ]
                ]
            , section [ class "section" ]
                [ case model.page of
                    NotFound ->
                        viewNotFound

                    Top pageModel ->
                        Page.Top.view pageModel |> Html.map TopMsg

                    MultiLineText pageModel ->
                        Page.MultiLineText.view pageModel |> Html.map MultiLineTextMsg

                    RandomText pageModel ->
                        Page.RandomText.view pageModel |> Html.map RandomTextMsg

                    CharCounter pageModel ->
                        Page.CharCounter.view pageModel |> Html.map CharCounterMsg
                ]
            ]
        ]
    }


viewNotFound : Html msg
viewNotFound =
    text "Page Not Found"
