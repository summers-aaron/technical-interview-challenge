module Page.Index.Query exposing (..)

import Decode
import GraphQl as GraphQl exposing (Operation, Query, Variables)
import GraphQl.Http
import Http exposing (Error)
import Json.Decode as D exposing (Decoder, field)
import Json.Encode as Encode
import Types exposing (Dog)


type alias DogsResult =
    Result Error DogsResponse


type alias DogsResponse =
    { dogs : List Dog }


decodeDogs : Decoder DogsResponse
decodeDogs =
    D.map
        DogsResponse
        (field "dogs" (D.list Decode.dog))


listDogs : (DogsResult -> msg) -> String -> String -> Cmd msg
listDogs msg query url =
    GraphQl.query dogsRequest
        |> GraphQl.addVariables [ ( "query", Encode.string query ) ]
        |> GraphQl.Http.send
            { url = url ++ "/api/graphiql", headers = [] }
            msg
            decodeDogs


dogsRequest : Operation Query Variables
dogsRequest =
    GraphQl.named "GetDogs"
        [ GraphQl.field "dogs"
            |> GraphQl.withArgument "query" (GraphQl.variable "query")
            |> GraphQl.withSelectors
                [ GraphQl.field "id"
                , GraphQl.field "breed"
                , GraphQl.field "image"
                ]
        ]
        |> GraphQl.withVariables [ ( "query", "String!" ) ]
