module EmployerNationalInsurance exposing (..)

import TaxBandList exposing (..)
import TaxBand exposing (..)

taxBandsFor2018to2019 : TaxBandList
taxBandsFor2018to2019 =
  let
    config =
      { lowerEarningsLimit = 6032
      , secondaryThreshold = 8424
      , upperEarningsLimit = 46350
      }
  in
    [ TaxBand 0 config.lowerEarningsLimit 0.0
    , TaxBand config.lowerEarningsLimit config.secondaryThreshold 0.0
    , TaxBand config.secondaryThreshold config.upperEarningsLimit 13.9
    , TaxBand config.upperEarningsLimit (1/0) 13.8
    ]

taxFor2018to2019 : Float -> Float
taxFor2018to2019 salary =
  TaxBandList.taxFor taxBandsFor2018to2019 salary
