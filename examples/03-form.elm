import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String
-- TODO: Error to import Regex
-- import Regex


-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , age : String
--  , age : Int
  }


init : Model
init =
  Model "" "" "" ""
-- Model "" "" "" 0


-- UPDATE


type Msg
  = Name String
  | Password String
  | PasswordAgain String
  | Age String
--  | Age String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Age age ->
      { model | age = age }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , viewInput "age" "your age" model.age Age
--    , input "age" "your age" model.age Age
    , viewValidation model
    , lengthValidation model
    , passwordValidation model
    , ageValidation model
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
-- viewInputAge : Int -> Int -> Int -> (Int -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
  if model.password == model.passwordAgain then
    div [ style "color" "green" ] [ text "OK" ]
  else
    div [ style "color" "red" ] [ text "Passwords do not match!" ]

lengthValidation : Model -> Html msg
lengthValidation model =
  if String.length model.password > 8 then
    div [ style "color" "green" ] [ text "OK" ]
  else
    div [ style "color" "red" ] [ text "Passwords must over 8 charactors!" ]

passwordValidation : Model -> Html msg
passwordValidation model =
-- if Regex.contains lowerCase model.password then
  if String.length model.password > 8 then
    div [ style "color" "green" ] [ text "OK" ]
  else
    div [ style "color" "red" ] [ text "Passwords must contain lowercase!" ]

ageValidation : Model -> Html msg
ageValidation model =
 -- FIXME: OKの後に文字列を入れてもNGにならない
  if String.all Char.isDigit model.age then
    div [ style "color" "green" ] [ text "OK" ]
  else
    div [ style "color" "red" ] [ text "Age must be Number!" ]
