module Main (..) where

import Html
import Html.Attributes as Attr
import Time
import Http exposing (Response, Error(..), Value(..))
import Task exposing (fail, Task)

url = "http://thecatapi.com/api/images/get?format=src&type=gif"

view : String -> Html.Html
view imgSrc =
  Html.img [Attr.src imgSrc] [Html.text "test"]

everySecond : Signal Time.Time
everySecond =
  Time.every (Time.second * 5)

mb : Signal.Mailbox String
mb =
  Signal.mailbox ""

httpTask : Task.Task Http.RawError String
httpTask =
  let request =
    { verb = "GET"
    , headers = []
    , url = url
    , body = Http.empty
    }
  in
    (Http.send Http.defaultSettings request) `Task.andThen` (handleResponse getImage url)

getImage : String -> Task a b
getImage url =
  Task.succeed

handleResponse : (String -> Task Error a) -> Response -> Task Error a
handleResponse handle response =
  let failure = fail (BadResponse response.status "Response is not 302.")
  in
    if 302 == response.status then
      case response.value of
        Text str ->
          handle str
        _ ->
          failure
    else
      failure

sendToMb : String -> Task.Task a ()
sendToMb result =
  Signal.send mb.address result

runTask : Task.Task Http.RawError ()
runTask =
  httpTask `Task.andThen` sendToMb

daemon : Signal (Task.Task Http.RawError ())
daemon =
  Signal.map (always runTask) everySecond

main : Signal.Signal Html.Html
main =
  Signal.map view mb.signal

port runner : Signal (Task.Task Http.RawError ())
port runner =
  daemon
