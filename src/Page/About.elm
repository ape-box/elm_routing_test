module Page.About exposing (renderAboutView)

import Html exposing (Html, h2, p, text)

renderAboutView : List (Html msg)
renderAboutView =
    [ h2 [] [ text "About" ]
    , p [] [ text "About Page" ]
    ]
