module Util.Clipboard exposing (..)

import Html
import Html.Attributes


{-| この属性をつけた要素をクリックするとコピーが発生する。
何をコピーするかは dataClipboardTarget で指定する
-}
copyToClipboarcOnClick : Html.Attribute msg
copyToClipboarcOnClick =
    Html.Attributes.attribute "data-copy-to-clipboard" ""


{-| 指定した ID の要素のテキストをクリップボードにコピーできるようにするための属性
copyToClipboardOnClick と同時に指定しないとコピーが発生しない
-}
dataClipboardTarget : String -> Html.Attribute msg
dataClipboardTarget id =
    Html.Attributes.attribute "data-clipboard-target" ("#" ++ id)
