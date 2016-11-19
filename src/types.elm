module Types exposing (..)

import Http


type Msg
    = NewHttpData (Result Http.Error (List User))


type alias User =
    { name : String
    , age : Int
    , description : Maybe String
    , languages : List String
    , playsFootball : Bool
    }


type alias Model =
    { users : Maybe (List User)
    , error : Maybe Http.Error
    }
