module Page.Element exposing (checkbox, radio)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


checkbox : List (Attribute msg) -> String -> Html msg
checkbox =
    labeledElement "checkbox"


radio : List (Attribute msg) -> String -> Html msg
radio =
    labeledElement "radio"


labeledElement : String -> List (Attribute msg) -> String -> Html msg
labeledElement type__ attr labelText =
    label [ class type__ ]
        [ input (type_ type__ :: class type__ :: attr) []
        , text (" " ++ labelText)
        ]
