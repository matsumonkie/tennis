module Router exposing (..)

import Route exposing (Route)
import Html.Events exposing (..)
import Navigation
import Html exposing (..)

-- MODEL

type alias Model = Route

init : (Model, Cmd Route)
init =
  (Route.Home, Cmd.none)

-- UPDATE

update : Route -> Model -> (Model, Cmd Route)
update msg model =
  case msg of
    Route.Home ->
      (Route.Home, Cmd.none)

    Route.User ->
      (Route.User, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Route
subscriptions model =
  Sub.none

-- VIEW

view : Model -> Html Route
view model =
  case model of
    Route.User ->
      ul [] [
          li [ onClick (Route.User) ]
             [text "your are on home"],
          li [ onClick (Route.Home) ]
             [text "user"]
      ]
    Route.Home ->
      ul [] [
          li [ onClick (Route.User) ]
             [text "home"],
          li [ onClick (Route.Home) ]
             [text "you are on user"]
      ]
