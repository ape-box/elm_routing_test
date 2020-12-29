module Page.Login exposing (renderLoginView)

import Html exposing (Html, h2, p, text)

renderLoginView : List (Html msg)
renderLoginView =
    [ h2 [] [ text "Login" ]
    , p [] [ text "Login Page" ]
    ]
