import Window
import Graphics.Element as Element
import Signal
import Task
import History exposing (..)

modelInit =
  { route = "init" }

main =
  Signal.map Element.show model

model =
  let lambda = \signal acc -> { acc | route = signal }
  in
    Signal.foldp lambda modelInit currentHash

currentHash =
  Signal.merge History.hash firstHash

firstHash : Signal String
firstHash =
  Signal.sampleOn appStartMailbox.signal History.hash

appStartMailbox : Signal.Mailbox ()
appStartMailbox =
  Signal.mailbox ()

port appStart : Signal (Task.Task error ())
port appStart =
  Signal.constant (Signal.send appStartMailbox.address ())
