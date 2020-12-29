module ElmMain exposing (main)

import App exposing (AppCommand, PageModel, initAppState, renderAppView, updateAppState)
import Browser


main : Program () PageModel AppCommand
main =
  Browser.application
    { init = initAppState
    , view = renderAppView
    , update = updateAppState
    , subscriptions = always Sub.none
    , onUrlRequest = App.ClickedLink
    , onUrlChange = App.ChangedUrl
    }

