module View exposing (..)

import Model exposing (Model)
import Msg exposing (Msg)
import Route exposing (Route)
import Html exposing (Html, div, text, li, a, span, ul)
import Html.Attributes exposing (id, class, href)
import Alias exposing (for)

view : Model -> Html Msg
view model =
  ul [ id "menu-items", class "nav navbar-nav"]
     (htmlMenu model)

type alias Menu = List MenuItem
type MenuItem = MenuItem Route

menuItems : Menu
menuItems =
  [ MenuItem Route.Home
  , MenuItem Route.Users
  ]

menuItemToHtml : Model -> MenuItem -> Html Msg
menuItemToHtml model menuItem =
  let
    (MenuItem route) = menuItem
    menuClass =
      if model.route == route
      then "active"
      else "unactive"
  in
    li []
      [ a [ class menuClass, href <| Route.toHref route ]
          [ text <| Route.toText route ]
      ]

htmlMenu : Model -> List (Html Msg)
htmlMenu model =
  List.map (menuItemToHtml model) menuItems

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
      []

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
