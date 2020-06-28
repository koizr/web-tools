module Page.Tree exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List
import Page.MultiLineText exposing (Model)



-- Model


type alias Model =
    { text : String }


inputText : String -> Model -> Model
inputText input model =
    { model | text = input }


init : Model
init =
    { text = "" }


type Msg
    = Input String



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input input ->
            ( inputText input model, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    div [] []
