module Menu.App exposing (..)

import Html.App as App
import Navigation

import Route.Model exposing (Route)
import Route.Parser as Parser
import Menu.View exposing (view)
import Menu.Model exposing (..)
import Msg exposing (Msg)

urlUpdate : Result String Route -> Model -> (Model, Cmd Msg)
urlUpdate result model =
  let
    currentRoute = Parser.routeFromResult result
  in
    ({ model | route = currentRoute }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

init : Result String Route -> (Model, Cmd Msg)
init result =
  let
    currentRoute = Parser.routeFromResult result
  in
    (init2 currentRoute, Cmd.none)

main : Program Never
main =
  Navigation.program Parser.parser
    { init = init
    , view = view
    , update = update
    , urlUpdate = urlUpdate
    , subscriptions = subscriptions
    }
