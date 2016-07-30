import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Navigation

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type Route = HomeRoute
           | UserRoute

type alias Model = Route

init : (Model, Cmd Route)
init =
  (HomeRoute, Cmd.none)

-- UPDATE

update : Route -> Model -> (Model, Cmd Route)
update msg model =
  case msg of
    HomeRoute ->
      (HomeRoute, Cmd.none)

    UserRoute ->
      (UserRoute, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Route
subscriptions model =
  Sub.none

-- VIEW

view : Model -> Html Route
view model =
  case model of
    UserRoute ->
      ul [] [
          li [ onClick (UserRoute) ]
             [text "your are on home"],
          li [ onClick (HomeRoute) ]
             [text "user"]
      ]
    HomeRoute ->
      ul [] [
          li [ onClick (UserRoute) ]
             [text "home"],
          li [ onClick (HomeRoute) ]
             [text "you are on user"]
      ]
