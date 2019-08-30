module Util exposing (applyThen, flip)

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


{-| 2 つの引数を取る関数の 1 つ目の引数と 2 つ目の引数を入れ替える
-}
flip : (a -> b -> c) -> (b -> a -> c)
flip f =
    \a b -> f b a
