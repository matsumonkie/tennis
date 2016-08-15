module Body.View exposing (..)

import Body.Model exposing (Model)
import Msg exposing (Msg)
import Route.Model as Route
import Html exposing (Html, div, text, li, a, span, ul)
import Html.Attributes exposing (id, class, href)
import Alias exposing (for)

view : Model -> Html Msg
view model =
  page model

page : Model -> Html Msg
page model =
  case model.route of
    Route.Home ->
      homeView

    Route.Users ->
      usersView

    Route.NotFound ->
      notFoundView

homeView : Html msg
homeView =
  div []
      [ text "home" ]

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
