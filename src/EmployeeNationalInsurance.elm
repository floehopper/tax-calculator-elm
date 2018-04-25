module EmployeeNationalInsurance exposing (..)

import TaxBand exposing (..)

type alias Rates =
  { belowLowerEarningsLimit: Float
  , lowerEarningsLimitToPrimaryThreshold: Float
  , primaryThresholdToUpperEarningsLimit: Float
  , aboveUpperEarningsLimit: Float
  }

type alias Config =
  { lowerEarningsLimit: Float
  , primaryThreshold: Float
  , upperEarningsLimit: Float
  , rates: Rates
  }

configFor2018to2019 =
  Config 6032 8424 46350 (Rates 0.0 0.0 12.0 2.0)

taxBandsFor2018to2019 : Config -> List TaxBand
taxBandsFor2018to2019 config =
  [TaxBand 0 config.lowerEarningsLimit config.rates.belowLowerEarningsLimit
  ,TaxBand config.lowerEarningsLimit config.primaryThreshold config.rates.lowerEarningsLimitToPrimaryThreshold
  ,TaxBand config.primaryThreshold config.upperEarningsLimit config.rates.primaryThresholdToUpperEarningsLimit
  ,TaxBand config.upperEarningsLimit (1/0) config.rates.aboveUpperEarningsLimit
  ]

taxFor : List TaxBand -> Float -> Float
taxFor taxBands salary =
  List.foldl (\taxBand total -> TaxBand.taxFor salary taxBand + total ) 0 taxBands
