module UserDecoderTests exposing (..)

import Test exposing (..)
import Expect
import Types exposing (..)
import String
import Json.Encode as Encode
import Json.Decode as Decode
import UsersDecoder exposing (sportsDecoder, userDecoder)


blogPostTests : Test
blogPostTests =
    describe "Tests for blog post examples"
        [ test "decoding Jack" <|
            \() ->
                let
                    userDecoder : Decode.Decoder { name : String }
                    userDecoder =
                        Decode.object1 (\name -> { name = name })
                            (Decode.at [ "name" ] Decode.string)
                in
                    Expect.equal
                        (Ok { name = "Jack" })
                        (Decode.decodeString userDecoder """{"name": "Jack"}""")
        ]


sportsDecoderTests : Test
sportsDecoderTests =
    describe "SportsDecoderTests"
        [ test "when football is given true it is true" <|
            \() ->
                Expect.equal
                    (Ok True)
                    (Decode.decodeString sportsDecoder """{ "football": true }""")
        , test "when football is given false it is false" <|
            \() ->
                Expect.equal
                    (Ok False)
                    (Decode.decodeString sportsDecoder """{ "football": false }""")
        , test "when football is not given it is false" <|
            \() ->
                Expect.equal
                    (Ok False)
                    (Decode.decodeString sportsDecoder """{}""")
        ]


userDecoderTests : Test
userDecoderTests =
    describe "UserDecoderTests"
        [ test "when given a user with all the fields" <|
            \() ->
                let
                    user =
                        """
                        { "name": "jack", "age": 24,
                        "description": "a person who likes elm",
                        "languages": ["javascript"],
                        "sports": { "football": true }
                        }
                    """
                in
                    Expect.equal
                        (Ok (User "jack" 24 (Just "a person who likes elm") [ "javascript" ] True))
                        (Decode.decodeString userDecoder user)
        , test "a user who does not have a description" <|
            \() ->
                let
                    user =
                        """
                        { "name": "jack", "age": 24,
                        "languages": ["javascript"],
                        "sports": { "football": true }
                        }
                    """
                in
                    Expect.equal
                        (Ok (User "jack" 24 Nothing [ "javascript" ] True))
                        (Decode.decodeString userDecoder user)
        , test "a user with an empty sports object" <|
            \() ->
                let
                    user =
                        """
                        { "name": "jack", "age": 24,
                        "description": "a person who likes elm",
                        "languages": ["javascript"],
                        "sports": {}
                        }

                    """
                in
                    Expect.equal
                        (Ok (User "jack" 24 (Just "a person who likes elm") [ "javascript" ] False))
                        (Decode.decodeString userDecoder user)
        ]


all : Test
all =
    describe "UsersDecoderTests"
        [ sportsDecoderTests
        , userDecoderTests
        , blogPostTests
        ]
