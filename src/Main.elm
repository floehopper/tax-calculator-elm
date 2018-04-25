module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import EmployeeNationalInsurance as EmployeeNI exposing (..)
import EmployerNationalInsurance as EmployerNI exposing (..)
import TaxBandList exposing (..)

---- MODEL ----


type alias Model =
    { salary: Float }


init : ( Model, Cmd Msg )
init =
    ( { salary = 30000 }, Cmd.none )



---- UPDATE ----


type Msg
    = Change String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      Change newSalary ->
      ( { model | salary = parseValue newSalary 0 }, Cmd.none)

parseValue : String -> Float -> Float
parseValue value default =
    String.toFloat value |> Result.toMaybe |> Maybe.withDefault default


---- VIEW ----


view : Model -> Html Msg
view model =
    let
        employeeContributions =
          roundToNearestPenny (TaxBandList.taxFor (EmployeeNI.taxBandsFor2018to2019 EmployeeNI.configFor2018to2019) model.salary)
        employerContributions =
          roundToNearestPenny (TaxBandList.taxFor (EmployerNI.taxBandsFor2018to2019 EmployerNI.configFor2018to2019) model.salary)
    in
      div []
          [
            h1 [] [ text "Tax Calculator" ],
            input [ type_ "number", placeholder "Salary", value <| toString model.salary, onInput Change ] [],
            p [] [ text "Employee Contributions: £", text <| toString employeeContributions ],
            p [] [ text "Employer Contributions: £", text <| toString employerContributions ]
          ]

roundToNearestPenny : Float -> Float
roundToNearestPenny value =
    (toFloat (round (value * 100.0))) / 100.0


---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
