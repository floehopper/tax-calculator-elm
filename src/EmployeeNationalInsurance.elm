module EmployeeNationalInsurance exposing (..)

import TaxBandList exposing (..)
import TaxBand exposing (..)

taxBandsFor2018to2019 : TaxBandList
taxBandsFor2018to2019 =
  let
    config =
      { lowerEarningsLimit = 6032
      , primaryThreshold = 8424
      , upperEarningsLimit = 46350
      }
  in
    [ TaxBand 0 config.lowerEarningsLimit 0.0
    , TaxBand config.lowerEarningsLimit config.primaryThreshold 0.0
    , TaxBand config.primaryThreshold config.upperEarningsLimit 12.0
    , TaxBand config.upperEarningsLimit (1/0) 2.0
    ]

taxFor2018to2019 : Float -> Float
taxFor2018to2019 salary =
  TaxBandList.taxFor taxBandsFor2018to2019 salary
