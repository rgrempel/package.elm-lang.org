module Docs.Version
    ( Version
    , one
    , getMajor
    , Dictionary
    , MinorPatch
    , decoder
    , Magnitude(..)
    , magnitude
    , filterInteresting
    , realMax
    , toDict
    , fromString
    , fromStringList
    , vsnToString
    )
    where

import Dict
import Json.Decode as Json exposing (..)
import String



-- REPRESENTATION


type alias Version = (Int, Int, Int)


getMajor : Version -> Int
getMajor (major, _, _) =
  major


one : Version
one =
  ( 1, 0, 0 )



-- JSON DECODER


decoder : Decoder Version
decoder =
  customDecoder string fromString


fromString : String -> Result String Version
fromString str =
  case all (List.map String.toInt (String.split "." str)) of
    Ok [major, minor, patch] ->
        Ok (major, minor, patch)

    _ ->
        Err (str ++ " is not a valid Elm version")


all : List (Result x a) -> Result x (List a)
all list =
  case list of
    [] ->
        Ok []

    x :: xs ->
        Result.map2 (::) x (all xs)


fromStringList : List String -> Result String (List Version)
fromStringList versions =
  all (List.map fromString versions)



-- MAGNITUDE


type Magnitude = Major | Minor | Patch


magnitude : Version -> Version -> Magnitude
magnitude ((major1, minor1, patch1) as v1) (major2, minor2, patch2) =
  if major1 /= major2 then
    Major

  else if minor1 /= minor2 then
    Minor

  else if patch1 /= patch2 then
    Patch

  else
    Debug.crash <| "Why are you trying to get the magnitude between version " ++ vsnToString v1 ++ " and itself?"



-- MAXIMUM


realMax : String -> List String -> Maybe String
realMax rawVsn allRawVsns =
  case Result.map2 (,) (fromString rawVsn) (fromStringList allRawVsns) of
    Ok (version, allVersions) ->
      let
        maxVersion =
          List.foldl max version allVersions
      in
        if version == maxVersion then
            Nothing

        else
            Just (vsnToString maxVersion)

    _ ->
        Nothing



-- TO STRING


vsnToString : Version -> String
vsnToString (major, minor, patch) =
  toString major ++ "." ++ toString minor ++ "." ++ toString patch



-- INTERESTING VERSIONS


filterInteresting : List Version -> List Version
filterInteresting versions =
  List.map (uncurry toLatest) (Dict.toList (toDict versions))


toLatest : Int -> MinorPatch -> Version
toLatest major {latest} =
  let
    (minor, patch) =
      latest
  in
    (major, minor, patch)



-- TO DICTIONARY


type alias Dictionary =
  Dict.Dict Int MinorPatch



type alias MinorPatch =
  { latest : (Int, Int)
  , others : List (Int, Int)
  }


toDict : List Version -> Dictionary
toDict versions =
  List.foldl toDictHelp Dict.empty versions


toDictHelp : Version -> Dictionary -> Dictionary
toDictHelp (major, minor, patch) dict =
  let
    current =
      (minor, patch)

    update maybeMinorPatch =
      case maybeMinorPatch of
        Nothing ->
          Just (MinorPatch current [])

        Just {latest, others} ->
          Just (MinorPatch (max latest current) (insert (min latest current) others))
  in
    Dict.update major update dict


insert : comparable -> List comparable -> List comparable
insert y list =
  case list of
    [] ->
      [y]

    x :: xs ->
      if y > x then
        x :: insert y xs

      else
        y :: list
