{-
   Thanks to janiczek, Peter Damoc
   for contributions to code
-}
module Main exposing (main)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class, id)
import Time

type alias Model =
    { count: Int }


initialModel : Model
initialModel =
     { count = 500 }

type Msg = Tick

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick ->
            if model.count == 0 then
                ( initialModel, Cmd.none )
            else
                ( { model | count = model.count - 1 }, Cmd.none )

{-
Peter Damoc, elm slack channel
view model = 
    let 
        hour   = model.count  // 3600
        minute = (model.count % 3600) // 60 
        second = model.count % 60
    in 
    text (String.join ":" (List.map toString [hour, minute, second]))
-}


view : Model -> Html msg
view model =
    let
        hour   = if (model.count  // 3600) < 10 then
                    "0" ++ toString (model.count  // 3600)
                 else
                     toString (model.count  // 3600)
        minute = if ((model.count % 3600) // 60) < 10 then
                    "0" ++ toString ((model.count % 3600) // 60)
                 else
                    toString ((model.count % 3600) // 60)
        second = if (model.count % 60) < 10 then
                    "0" ++ toString (model.count % 60)
                 else
                    toString (model.count % 60)
    in
        div [ class "countDown" ]
          [ span [ id "hours" ]
            [ text hour ]
          , span [ id "minutes" ]
            [ text minute ]
          , span [ id "seconds" ]
             [ text second ]
          , text ""
    ]

main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every Time.second (always Tick)
