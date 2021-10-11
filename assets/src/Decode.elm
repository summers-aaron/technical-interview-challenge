module Decode exposing (..)

import Json.Decode as Decode exposing (Decoder, field, maybe, string)
import Types exposing (Dog)


dog : Decoder Dog
dog =
    Decode.map3 Dog
        (field "id" string)
        (field "breed" string)
        (maybe (field "image" string))
