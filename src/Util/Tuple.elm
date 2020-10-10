module Util.Tuple exposing (apply)


apply : (a -> b -> c) -> ( a, b ) -> c
apply f t =
    f (Tuple.first t) (Tuple.second t)
