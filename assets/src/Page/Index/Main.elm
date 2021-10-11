module Page.Index.Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, id, placeholder, src, type_, value)
import Html.Events exposing (onClick, onInput)
import List
import Page.Index.Query as Query
import Types exposing (Dog)



-- MODEL


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type alias Flags =
    { title : String
    , apiUrl : String
    }


type alias Model =
    { pageTitle : String
    , search : String
    , selectedDog : Maybe Dog
    , dogs : List Dog
    , apiUrl : String
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { search = ""
      , selectedDog = Nothing
      , pageTitle = flags.title
      , dogs = []
      , apiUrl = flags.apiUrl
      }
    , Query.listDogs DogsLoaded "" flags.apiUrl
    )



-- UPDATE


type Msg
    = SearchInput String
    | SelectDog Dog
    | DogsLoaded Query.DogsResult


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchInput string ->
            let
                newModel =
                    { model | search = string }
            in
            ( newModel
            , Query.listDogs
                DogsLoaded
                newModel.search
                newModel.apiUrl
            )

        SelectDog dog ->
            ( { model | selectedDog = Just dog }, Cmd.none )

        DogsLoaded result ->
            case result of
                Ok dogs ->
                    ( { model | dogs = dogs.dogs }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "Dogs | " ++ model.pageTitle
    , body = body model
    }


body : Model -> List (Html Msg)
body model =
    [ header
        [ class "nav" ]
        [ div
            []
            [ div
                [ class "container" ]
                [ text "Dogs API" ]
            ]
        ]
    , main_
        [ class "container" ]
        [ searchForm model
        , selectedDogImage model.selectedDog model.apiUrl
        , dogsList model.dogs
        ]
    , footer [] []
    ]


selectedDogImage : Maybe Dog -> String -> Html Msg
selectedDogImage maybeDog url =
    case maybeDog of
        Just dog ->
            img
                [ class "main-image"
                , src (url ++ "/images/" ++ dogImageUrl dog)
                ]
                []

        Nothing ->
            img [] []


dogImageUrl : Dog -> String
dogImageUrl dog =
    dog.image |> Maybe.withDefault ""


dogsList : List Dog -> Html Msg
dogsList dogs =
    div
        []
        (List.map dogCard dogs)


dogCard : Dog -> Html Msg
dogCard dog =
    div
        [ class "card" ]
        [ text dog.breed
        , button
            [ onClick (SelectDog dog) ]
            [ text "SHOW" ]
        ]


searchForm : Model -> Html Msg
searchForm model =
    form
        []
        [ fieldset
            []
            [ legend
                [ class "is-size-4" ]
                [ text "Search" ]
            , p
                []
                [ input
                    [ id "search"
                    , type_ "text"
                    , onInput SearchInput
                    , value model.search
                    , placeholder "Searching for..."
                    ]
                    []
                ]
            ]
        ]
