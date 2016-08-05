module App.Model exposing (..)

import Route exposing (Route)

type alias Model =
  { route : Route
  }

init2 : Route -> Model
init2 route =
  { route = route
  }
