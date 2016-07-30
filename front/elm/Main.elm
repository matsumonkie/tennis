import Html.App as App
import User

main =
  App.program
    { init = User.init "cats"
    , view = User.view
    , update = User.update
    , subscriptions = User.subscriptions
    }
