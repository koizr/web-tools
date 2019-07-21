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


type Msg
    = Init


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    ul []
        [ li [] [ a [ href "text" ] [ text "テキスト編集" ] ]
        ]
