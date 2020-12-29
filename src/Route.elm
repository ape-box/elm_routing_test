module Route exposing (ApplicationRoute(..), parseUrlToRoute, routeLink)

import Url
import Url.Parser exposing (Parser, (</>), map, oneOf, parse, s, string, top)


type ApplicationRoute
  = Login
  | About
  | Dashboard
  -- | NotFound


parseUrlToRoute : Url.Url -> Maybe ApplicationRoute
parseUrlToRoute url =
  parse routeMapperInternal url


routeMapperInternal : Parser (ApplicationRoute -> a) a
routeMapperInternal =
  oneOf
    [ map Login top
    , map About (s "about")
    , map Dashboard (s "getting-in-touch")
    ]


routeLink : ApplicationRoute -> String
routeLink route =
  case route of
    Login ->
      "/"

    About ->
      "/about"

    Dashboard ->
      "/getting-in-touch"

-- WTF!?
-- toRoute : String -> Route
-- toRoute string =
--   case Url.fromString string of
--     Nothing ->
--       NotFound

--     Just url ->
--       Maybe.withDefault NotFound (parse route url)