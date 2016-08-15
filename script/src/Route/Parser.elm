module Route.Parser exposing (..)

import String
import Navigation
import UrlParser exposing (..)
import Route.Model as Route exposing (Route)

toHref : Route -> String
toHref route =
  case route of
    Route.Home -> "#"
    Route.Users -> "#users"
    Route.NotFound -> "#not-found"

toText : Route -> String
toText route =
  case route of
    Route.Home -> "Home"
    Route.Users -> "Users"
    Route.NotFound -> ""

matchers : Parser (Route -> a) a
matchers =
  oneOf
    [ format Route.Home (s "")
    , format Route.Users (s "users")
    ]

hashParser : Navigation.Location -> Result String Route
hashParser location =
  location.hash
    |> String.dropLeft 1
    |> parse identity matchers

parser : Navigation.Parser (Result String Route)
parser = Navigation.makeParser hashParser

routeFromResult : Result String Route -> Route
routeFromResult result =
  case result of
    Ok route ->
      route

    Err string ->
      Route.NotFound
