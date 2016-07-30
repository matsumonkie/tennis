import Html.App as App
import Router

main =
  App.program
    { init = Router.init
    , view = Router.view
    , update = Router.update
    , subscriptions = Router.subscriptions
    }
