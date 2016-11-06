module UserDecoderTests exposing (..)

import Test exposing (..)
import Expect
import String
import Json.Encode as Encode
import Json.Decode as Decode
import UsersDecoder exposing (sportsDecoder)


createSportsObject footballValue =
    Encode.encode 0
        (Encode.object
            [ ( "football", Encode.bool footballValue )
            ]
        )


noFootballGivenObject =
    Encode.encode 0 (Encode.object [])


sportsDecoderTests : Test
sportsDecoderTests =
    describe "SportsDecoderTests"
        [ test "when football is given true it is true" <|
            \() ->
                Expect.equal
                    (Ok True)
                    (Decode.decodeString sportsDecoder (createSportsObject True))
        , test "when football is given false it is false" <|
            \() ->
                Expect.equal
                    (Ok False)
                    (Decode.decodeString sportsDecoder (createSportsObject False))
        , test "when football is not given it is false" <|
            \() ->
                Expect.equal
                    (Ok False)
                    (Decode.decodeString sportsDecoder noFootballGivenObject)
        ]


all : Test
all =
    describe "UsersDecoderTests"
        [ sportsDecoderTests
        ]
