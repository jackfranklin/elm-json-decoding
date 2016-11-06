module Data exposing (fetchUsers)

import Http
import Types exposing (..)
import Task exposing (Task)
import UsersDecoder exposing (usersDecoder)


makeRequest : Task Http.Error (List User)
makeRequest =
    Http.get usersDecoder "/src/data.json"


fetchUsers : Cmd Msg
fetchUsers =
    Task.perform Error NewData makeRequest
