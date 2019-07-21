module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Page.MultiLineText
import Page.Top
import Route exposing (Route)
import Url
import Url.Builder



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


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    Model key (Top Page.Top.init)
        |> goTo (Route.parse url)



-- Update


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | TopMsg Page.Top.Msg
    | MultiLineTextMsg Page.MultiLineText.Msg


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


goTo : Maybe Route -> Model -> ( Model, Cmd Msg )
goTo maybeRoute model =
    case maybeRoute of
        Nothing ->
            ( { model | page = NotFound }, Cmd.none )

        Just Route.Top ->
            ( { model | page = Top Page.Top.init }, Cmd.none )

        Just Route.MultiLineText ->
            ( { model | page = MultiLineText Page.MultiLineText.init }, Cmd.none )



-- Subscription


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- View


view : Model -> Browser.Document Msg
view model =
    { title = "Web tools"
    , body =
        [ div [] [ a [ href "/" ] [ text "トップへ戻る" ] ]
        , case model.page of
            NotFound ->
                viewNotFound

            Top pageModel ->
                Page.Top.view pageModel |> Html.map TopMsg

            MultiLineText pageModel ->
                Page.MultiLineText.view pageModel |> Html.map MultiLineTextMsg
        ]
    }


viewNotFound : Html msg
viewNotFound =
    text "Page Not Found"
