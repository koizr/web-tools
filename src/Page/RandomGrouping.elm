module Page.RandomGrouping exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Page.Element exposing (..)



-- Model


type alias Model =
    { items : String
    , group : List (List String)
    }


init : Model
init =
    { items = ""
    , group = []
    }



-- Update


type Msg
    = InputItems String
    | Group


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputItems items ->
            Debug.todo "implement"

        Group ->
            Debug.todo "implement"



-- View


view : Model -> Html Msg
view model =
    div []
        [ div [ class "field" ]
            [ textarea [ class "textarea", value model.items, cols 60, rows 30, onInput InputItems ] []
            , div [ style "text-align" "right" ] [ buttonMain "Group" Group ]
            ]
        , div [ class "field" ]
            [ textarea [ class "textarea", value model.items, cols 60, rows 30 ] []
            ]
        ]
