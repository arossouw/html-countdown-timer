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
countDownTimer : Int -> Html msg
countDownTimer count =
    let
        second = 
          count % 60
           |> toString
           |> String.padLeft 2 '0'

        minute = 
          (count % 3600) // 60
           |> toString
           |> String.padLeft 2 '0'

        hour = 
          (count  // 3600)
           |> toString
           |> String.padLeft 2 '0'
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

view : Model -> Html msg
view model =
     countDownTimer model.count
      
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
