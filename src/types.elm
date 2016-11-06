module Types exposing (..)

import Http


type Msg
    = NewData (List User)
    | Error Http.Error


type alias User =
    { name : String
    , age : Int
    , description : Maybe String
    , languages : List String
    , playsFootball : Bool
    }


type alias Model =
    { users : Maybe User
    , error : Maybe Http.Error
    }
