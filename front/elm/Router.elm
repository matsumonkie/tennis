module Router where

import Alias exposing (..)
import Route exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List exposing (..)
import Array exposing (..)
import Task
import History
import Effects as Fx exposing (Effects, Never)

{-
-- MODEL

type alias Model = Route

init : (Model, Effects Action)
init =
  let noOp =
        Task.succeed NoOp
          |> Fx.task
  in
    HomeRoute => noOp


-- UPDATE

type Action = NoOp
            | Follow Route

setHash : String -> Effects Action
setHash path =
  History.setHash "coucou"
    |> Task.map (\_ -> NoOp)
    |> Fx.task

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp ->
      model => Fx.none

    Follow route ->
      case route of
        HomeRoute ->
          HomeRoute => setHash "home"

        UserRoute ->
          UserRoute => setHash "user"


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  case model of
    UserRoute ->
      div [] [
          a [ onClick address <| Follow UserRoute ]
            [text "home "],
          a [ onClick address <| Follow HomeRoute ]
            [text "you are on user"]
      ]
    HomeRoute ->
      div [] [
          a [ onClick address <| Follow UserRoute ]
            [text "you are on home "],
          a [ onClick address <| Follow HomeRoute ]
            [text "user"]
      ]
-}
