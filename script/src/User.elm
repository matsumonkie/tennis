module User exposing (..)

import Alias exposing (ID)
import Json.Decode as Json exposing ((:=))

-- MODEL

type alias Model =
  { id : ID
  , name : String
  }

decodeUser : Json.Decoder Model
decodeUser =
  Json.object2 Model
        ("userId" := Json.int)
        ("name" := Json.string)
