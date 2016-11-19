module App exposing (..)

import Html exposing (text, div)
import Data exposing (fetchUsers)
import Types exposing (..)


update msg model =
    case msg of
        NewHttpData result ->
            case result of
                Ok users ->
                    ( { model | users = Just users }, Cmd.none )

                Err e ->
                    ( { model | error = Just e }, Cmd.none )


init =
    ( { users = Nothing
      , error = Nothing
      }
    , fetchUsers
    )


view model =
    div []
        [ div [] [ text ("Result: " ++ (toString model.users)) ]
        , div [] [ text ("Error: " ++ (toString model.error)) ]
        ]
