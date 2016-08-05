module App.View exposing (..)

import App.Model exposing (Model)
import App.Msg exposing (Msg)
import Route exposing (Route)
import Html exposing (Html, div, text)

view : Model -> Html Msg
view model =
  div []
      [ page model ]

page : Model -> Html Msg
page model =
  case model.route of
    Route.Home ->
      homeView

    Route.Users ->
      usersView

    Route.User id ->
      userView

    Route.NotFound ->
      notFoundView

homeView : Html msg
homeView =
  div []
      [ text "home"
      ]

userView : Html msg
userView =
  div []
      [ text "user"
      ]

usersView : Html msg
usersView =
  div []
      [ text "users"
      ]

notFoundView : Html msg
notFoundView =
  div []
      [ text "Not found"
      ]
