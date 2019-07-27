module Util exposing (applyThen)

{-| 便利関数たち
-}


{-| True のときだけ関数を適用するやつ
-}
applyThen : Bool -> (a -> a) -> a -> a
applyThen condition f a =
    if condition then
        f a

    else
        a
