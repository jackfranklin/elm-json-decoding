module Main exposing (..)

import App exposing (..)
import Html exposing (program)
import Types exposing (Model, Msg)


main : Program Never Model Msg
main =
    program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
