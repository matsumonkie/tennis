import Html.App as App
import Users

main =
  App.program
    { init = Users.init "cats"
    , view = Users.view
    , update = Users.update
    , subscriptions = Users.subscriptions
    }
