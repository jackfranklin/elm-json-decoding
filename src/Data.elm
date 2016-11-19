module Data exposing (fetchUsers)

import Http
import Types exposing (..)
import UsersDecoder exposing (usersDecoder)


getData : Http.Request (List User)
getData =
    Http.get "/src/data.json" usersDecoder


fetchUsers : Cmd Msg
fetchUsers =
    Http.send NewHttpData getData
