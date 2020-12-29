module Page.Dashboard exposing (renderDashboardView)

import Html exposing (Html, h2, p, text)

renderDashboardView : List (Html msg)
renderDashboardView =
    [ h2 [] [ text "Dashboard" ]
    , p [] [ text "Dashboard Page" ]
    ]
