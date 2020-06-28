module Page.Top exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List
import Route exposing (paths)



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
        (List.map viewToolListItem <|
            [ { path = paths.multilineText
              , title = "Sort & Distinct"
              , description = "Sorting and de-duplicating strings."
              }
            , { path = paths.randomText
              , title = "Random text generator"
              , description = "Generate some random combinations of any letters, numbers and symbols."
              }
            , { path = paths.charCounter
              , title = "Charcters counter"
              , description = "Count characters in a text."
              }
            , { path = paths.tree
              , title = "File tree generator"
              , description = "Generate tree diagram."
              }
            ]
        )


type alias ToolListItem =
    { path : String
    , title : String
    , description : String
    }


viewToolListItem : ToolListItem -> Html Msg
viewToolListItem item =
    li [ class "tool-list__item" ]
        [ a [ class "tool-list__link", href item.path ] [ text item.title ]
        , p [ class "tool-list__description" ] [ text item.description ]
        ]
