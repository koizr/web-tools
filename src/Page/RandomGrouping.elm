module Page.RandomGrouping exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Page.Element exposing (..)
import Random
import Util exposing (divide)
import Util.List exposing (sortByIndex)
import Util.String exposing (numOfLines, numOfLinesText)
import Util.Tuple



-- Model


type alias Model =
    { numberOfItemsInGroup : String
    , items : String
    , group : List (List String)
    }


init : Model
init =
    { numberOfItemsInGroup = "3"
    , items = ""
    , group = []
    }



-- Update


type Msg
    = InputNumberOfItemsInGroup String
    | InputItems String
    | Shuffle
    | GenerateRandomOrder (List Int)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputNumberOfItemsInGroup num ->
            ( { model | numberOfItemsInGroup = num }, Cmd.none )

        InputItems items ->
            ( { model | items = items }, Cmd.none )

        Shuffle ->
            ( model
            , model.items
                |> numOfLines
                |> randomOrder
                |> Random.generate GenerateRandomOrder
            )

        GenerateRandomOrder order ->
            let
                numberOfItems =
                    String.toInt model.numberOfItemsInGroup

                sortedItems =
                    if String.isEmpty model.items then
                        []

                    else
                        model.items
                            |> String.lines
                            |> sortByIndex order
            in
            case numberOfItems of
                Just num ->
                    ( { model | group = divide num sortedItems }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )


randomOrder : Int -> Random.Generator (List Int)
randomOrder len =
    Random.list len (Random.int 0 (len * 100))



-- View


view : Model -> Html Msg
view model =
    div [ class "random-grouping" ]
        [ div []
            [ formGroup
                [ textarea [ class "textarea", value model.items, cols 60, rows 30, onInput InputItems ] []
                , div [ style "text-align" "right" ] [ text (numOfLinesText model.items) ]
                ]
            , formGroup
                (inputNumber
                    [ onInput InputNumberOfItemsInGroup
                    , value model.numberOfItemsInGroup
                    , style "width" "100px"
                    ]
                    "Number of items in one group"
                )
            , formGroup [ buttonMain "Group" Shuffle ]
            ]
        , div [ class "random-grouping__groups" ]
            (viewGroupHeader model.group ++ (numbered model.group |> List.map (Util.Tuple.apply viewGroup)))
        ]


viewGroupHeader : List a -> List (Html Msg)
viewGroupHeader group =
    if List.isEmpty group then
        []

    else
        [ div [ class "random-grouping__group-header" ] [ text "Groups" ] ]


viewGroup : Int -> List String -> Html Msg
viewGroup groupNo items =
    div [ class "random-grouping__group" ]
        [ div [ class "random-grouping__group-no" ] [ text (String.fromInt groupNo) ]
        , ul [ class "random-grouping__group-items" ]
            (List.map
                (\item -> li [] [ text item ])
                items
            )
        ]


numbered : List a -> List ( Int, a )
numbered =
    List.indexedMap (\i x -> ( i + 1, x ))
