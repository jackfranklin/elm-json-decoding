module UsersDecoder exposing (usersDecoder, userDecoder, sportsDecoder)

import Json.Decode as Decode
import Types exposing (..)


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
        (Maybe.withDefault False)
        footballValueDecoder


footballValueDecoder : Decode.Decoder (Maybe Bool)
footballValueDecoder =
    Decode.maybe
        (Decode.at [ "football" ] (Decode.oneOf [ Decode.bool, Decode.succeed False ]))
