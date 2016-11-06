module Data exposing (fetchUsers)

import Http
import Types exposing (..)
import Task exposing (Task)
import Json.Decode as Decode


makeRequest : Task Http.Error (List User)
makeRequest =
    Http.get usersDecoder "/src/data.json"


fetchUsers : Cmd Msg
fetchUsers =
    Task.perform Error NewData makeRequest


usersDecoder : Decode.Decoder (List User)
usersDecoder =
    Decode.at [ "users" ] (Decode.list userDecoder)


userDecoder : Decode.Decoder User
userDecoder =
    Decode.object5
        User
        (Decode.at [ "name" ] Decode.string)
        (Decode.at [ "age" ] Decode.int)
        (Decode.maybe (Decode.at [ "description" ] Decode.string))
        (Decode.at [ "languages" ] (Decode.list Decode.string))
        (Decode.at [ "sports" ] sportsDecoder)


sportsDecoder : Decode.Decoder Bool
sportsDecoder =
    Decode.map
        (\val ->
            case val of
                Just x ->
                    x

                Nothing ->
                    False
        )
        (Decode.maybe
            (Decode.at [ "football" ] (Decode.oneOf [ Decode.bool, Decode.succeed False ]))
        )
