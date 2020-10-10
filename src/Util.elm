module Util exposing (applyThen, divide, flip, zip)

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


{-| 2 つのリストを合わせたタプルを返す。
2 つのリストの長さが異なる場合、長い方の余った分は破棄される。
-}
zip : List a -> List b -> List ( a, b )
zip =
    List.map2 Tuple.pair


{-| 一定数ごとに要素を分割する
-}
divide : Int -> List a -> List (List a)
divide n list =
    case n of
        0 ->
            []

        _ ->
            case list of
                [] ->
                    []

                _ ->
                    if n > List.length list then
                        [ list ]

                    else
                        let
                            tail =
                                if List.length list <= n then
                                    []

                                else
                                    divide n (List.drop n list)
                        in
                        List.take n list :: tail
