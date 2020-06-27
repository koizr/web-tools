module Page.Top exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- Model


type alias Model =
    ()


init : Model
init =
    ()



-- Update


type alias Msg =
    ()


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )



-- View


view : Model -> Html Msg
view _ =
    ul [ class "tool-list" ]
        [ li [ class "tool-list__item" ]
            [ a [ class "tool-list__link", href "text" ] [ text "Sort & Distinct" ]
            , p [ class "tool-list__description" ] [ text "Sorting and de-duplicating strings." ]
            ]
        , li [ class "tool-list__item" ]
            [ a [ class "tool-list__link", href "random" ] [ text "Random text generator" ]
            , p [ class "tool-list__description" ] [ text "Generate some random combinations of any letters, numbers and symbols." ]
            ]
        ]
