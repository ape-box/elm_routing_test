module Page.NotFound exposing (renderNotFoundView)

import Html exposing (Html, text)

renderNotFoundView : List (Html msg)
renderNotFoundView =
  [ text "Not found"
  ]
