module Page.Element exposing (buttonMain, checkbox, contents, formGroup, formLabel, inputNumber, inputText, radio)

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


{-| メインのボタン
-}
buttonMain : String -> msg -> Html msg
buttonMain labelText msg =
    button [ class "button is-primary", onClick msg ] [ text labelText ]


{-| 入力項目のまとまり
-}
formGroup : List (Html msg) -> Html msg
formGroup children =
    div [ class "field" ]
        [ div [ class "control" ] children ]


{-| コンテンツの塊
-}
contents : List (Html msg) -> Html msg
contents =
    section [ class "section" ]


inputText : List (Attribute msg) -> String -> List (Html msg)
inputText attr labelText =
    [ formLabel labelText
    , input (type_ "text" :: class "input" :: attr) []
    ]


inputNumber : List (Attribute msg) -> String -> List (Html msg)
inputNumber attr labelText =
    [ formLabel labelText
    , input (type_ "number" :: class "input" :: attr) []
    ]


formLabel : String -> Html msg
formLabel labelText =
    label [ class "label" ] [ text labelText ]
