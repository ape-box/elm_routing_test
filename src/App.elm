module App exposing (AppCommand(..), PageModel, initAppState, renderAppView, updateAppState)


import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, h1, li, p, text, ul)
import Html.Attributes exposing (class, href, value)
import Page.About
import Page.Dashboard
import Page.Login
import Page.NotFound
import Route exposing (routeLink)
import Url exposing (Url)


type AppCommand
  = ClickedLink Browser.UrlRequest
  | ChangedUrl Url


type AppPage
  = Login
  | About
  | Dashboard
  | NotFound


type alias PageModel =
  { url : Url
  , key : Nav.Key
  , title : String
  , page : AppPage
  }


initAppState : () -> Url -> Nav.Key -> (PageModel, Cmd AppCommand)
initAppState _ url navKey =
  mapUrlToPage url
    |> Tuple.mapFirst (PageModel url navKey "Page Title - App Title")

-- NOTE for Tuple.mapFirst
-- as per https://package.elm-lang.org/packages/elm/core/latest/Tuple#mapFirst
-- (PageModel url key String) is actually a ctor which generate a PageModel alias hence (a -> x)
-- (fromUrl url) results in a tuple of (AppPage, Cmd AppCommand) resulting in the ( a, b )
-- which is mapFirst (PageModel, Cmd AppCommand) as in the ( x, b )
-- where x is PageModel and b is Cmd AppCommand


renderAppView : PageModel -> Document AppCommand
renderAppView model =
  { title = model.title
  , body =
      [ h1 [] [ text model.title ]
      , ul []
        [ li [] [ a [ href (routeLink Route.Login) ] [ text "Login"] ]
        , li [] [ a [ href (routeLink Route.Dashboard) ] [ text "Dashboard"] ]
        , li [] [ a [ href (routeLink Route.About) ] [ text "About"] ]
        ]
      , div [] <|
        case model.page of
          Login ->
            Page.Login.renderLoginView

          About ->
            Page.About.renderAboutView

          Dashboard ->
            Page.Dashboard.renderDashboardView

          NotFound ->
            Page.NotFound.renderNotFoundView
      ]
  }


updateAppState : AppCommand -> PageModel -> ( PageModel, Cmd AppCommand )
updateAppState command model =
  case command of
    ClickedLink urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model
          , Nav.pushUrl model.key (Url.toString url)
          )
        Browser.External url ->
          ( model
          , Nav.load url
          )

    ChangedUrl url ->
      mapUrlToPage url
        |> Tuple.mapFirst (PageModel url model.key model.title)


mapUrlToPage : Url -> (AppPage, Cmd AppCommand)
mapUrlToPage url =
  case Route.parseUrlToRoute url of
    Just Route.Login ->
      ( Login
      , Cmd.none
      )

    Just Route.About ->
      ( About
      , Cmd.none
      )

    Just Route.Dashboard ->
      ( Dashboard
      , Cmd.none
      )

    Nothing ->
      ( NotFound
      , Cmd.none
      )
