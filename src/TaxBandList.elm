module TaxBandList exposing (TaxBandList, taxFor)

import TaxBand exposing (..)

type alias TaxBandList =
  List TaxBand

taxFor : TaxBandList -> Float -> Float
taxFor taxBands salary =
  List.foldl (\taxBand total -> TaxBand.taxFor salary taxBand + total ) 0 taxBands
