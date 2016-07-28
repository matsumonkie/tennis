import Router exposing (init, update, view)
import StartApp
import Task
import Effects exposing (Effects, Never)
import History exposing (..)
import Route exposing (..)
import Graphics.Element exposing (show)
import Time

app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = [ router ]
    }

main =
  app.html

changeRoute : String -> Router.Action
changeRoute route =
  case route of
    "home" -> Router.Follow HomeRoute
    "user" -> Router.Follow UserRoute
    _ -> Router.Follow UserRoute

router : Signal Router.Action
router =
  History.hash -- Signal String
  |> Signal.map changeRoute
