module Body.Model exposing (..)

import Route.Model exposing (Route)

type alias Model =
  { route : Route
  }

init : Route -> Model
init route =
  { route = route
  }
