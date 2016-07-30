module Users exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Task
import User exposing (Model)
import Json.Decode as Json exposing ((:=))
import Alias exposing (..)

-- MODEL

type alias Model = List User.Model

init : String -> (Model, Cmd Msg)
init whatever =
  ( []
  , getUsers
  )

-- UPDATE

type Msg
  = FetchSucceed (List User.Model)
  | FetchFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of

    FetchSucceed newModel ->
      (newModel, Cmd.none)

    FetchFail _ ->
      (model, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model =
  let inner = Alias.for model <| \user -> h2 [] [ text (user.name) ]
  in div [] inner


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- HTTP

getUsers : Cmd Msg
getUsers =
  let res = Http.get (Json.list User.decodeUser) "http://api.tennis.com/users"
  in Task.perform FetchFail FetchSucceed res
