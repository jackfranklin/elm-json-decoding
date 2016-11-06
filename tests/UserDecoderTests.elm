module UserDecoderTests exposing (..)

import Test exposing (..)
import Expect
import String
import Json.Encode as Encode
import Json.Decode as Decode
import UsersDecoder exposing (sportsDecoder)


sportsFootballTrue =
    Encode.encode 0
        (Encode.object
            [ ( "sports"
              , Encode.object
                    [ ( "football", Encode.bool True )
                    ]
              )
            ]
        )


all : Test
all =
    describe "UsersDecoderTests"
        [ describe "SportsDecoderTests"
            [ test
                "when football is given true it is true"
              <|
                \() ->
                    Expect.equal (Ok True) (Decode.decodeString sportsDecoder sportsFootballTrue)
            ]
        ]
