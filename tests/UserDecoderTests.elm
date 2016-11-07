module UserDecoderTests exposing (..)

import Test exposing (..)
import Expect
import Types exposing (..)
import String
import Json.Encode as Encode
import Json.Decode as Decode
import UsersDecoder exposing (sportsDecoder, userDecoder)


createSportsObject footballValue =
    Encode.encode 0
        (Encode.object
            [ ( "football", Encode.bool footballValue )
            ]
        )


noFootballGivenObject =
    Encode.encode 0 (Encode.object [])


createNormalUser =
    Encode.encode 0
        (Encode.object
            [ ( "name", Encode.string "jack" )
            , ( "age", Encode.int 24 )
            , ( "description", Encode.string "a person who likes elm" )
            , ( "languages", Encode.list [ Encode.string "javascript" ] )
            , ( "sports", Encode.object [ ( "football", Encode.bool True ) ] )
            ]
        )


createUserWithNoDescription =
    Encode.encode 0
        (Encode.object
            [ ( "name", Encode.string "jack" )
            , ( "age", Encode.int 24 )
            , ( "languages", Encode.list [ Encode.string "javascript" ] )
            , ( "sports", Encode.object [ ( "football", Encode.bool True ) ] )
            ]
        )


createUserWithNoSports =
    Encode.encode 0
        (Encode.object
            [ ( "name", Encode.string "jack" )
            , ( "age", Encode.int 24 )
            , ( "description", Encode.string "a person who likes elm" )
            , ( "languages", Encode.list [ Encode.string "javascript" ] )
            , ( "sports", Encode.object [] )
            ]
        )


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


userDecoderTests : Test
userDecoderTests =
    describe "UserDecoderTests"
        [ test "when given a user with all the fields" <|
            \() ->
                Expect.equal
                    (Ok (User "jack" 24 (Just "a person who likes elm") [ "javascript" ] True))
                    (Decode.decodeString userDecoder createNormalUser)
        , test "a user who does not have a description" <|
            \() ->
                Expect.equal
                    (Ok (User "jack" 24 Nothing [ "javascript" ] True))
                    (Decode.decodeString userDecoder createUserWithNoDescription)
        , test "a user with an empty sports object" <|
            \() ->
                Expect.equal
                    (Ok (User "jack" 24 (Just "a person who likes elm") [ "javascript" ] False))
                    (Decode.decodeString userDecoder createUserWithNoSports)
        ]


all : Test
all =
    describe "UsersDecoderTests"
        [ sportsDecoderTests
        , userDecoderTests
        ]
