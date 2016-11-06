module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import UserDecoderTests


all : Test
all =
    concat [ UserDecoderTests.all ]
