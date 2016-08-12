module Main exposing (..)

import Html.App as App
import Navigation

import Route exposing (Route)
import View exposing (view)
import Model exposing (..)
import Msg exposing (Msg)

urlUpdate : Result String Route -> Model -> (Model, Cmd Msg)
urlUpdate result model =
  let
    currentRoute = Route.routeFromResult result
  in
    ({ model | route = currentRoute }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

init : Result String Route -> (Model, Cmd Msg)
init result =
  let
    currentRoute = Route.routeFromResult result
  in
    (init2 currentRoute, Cmd.none)

main : Program Never
main =
  Navigation.program Route.parser
    { init = init
    , view = view
    , update = update
    , urlUpdate = urlUpdate
    , subscriptions = subscriptions
    }
