module EmployerNationalInsurance exposing (..)

import TaxBand exposing (..)

type alias Rates =
  { belowLowerEarningsLimit: Float
  , lowerEarningsLimitToSecondaryThreshold: Float
  , secondaryThresholdToUpperEarningsLimit: Float
  , aboveUpperEarningsLimit: Float
  }

type alias Config =
  { lowerEarningsLimit: Float
  , secondaryThreshold: Float
  , upperEarningsLimit: Float
  , rates: Rates
  }

configFor2018to2019 =
  Config 6032 8424 46350 (Rates 0.0 0.0 13.8 13.8)

taxBandsFor2018to2019 : Config -> List TaxBand
taxBandsFor2018to2019 config =
  [TaxBand 0 config.lowerEarningsLimit config.rates.belowLowerEarningsLimit
  ,TaxBand config.lowerEarningsLimit config.secondaryThreshold config.rates.lowerEarningsLimitToSecondaryThreshold
  ,TaxBand config.secondaryThreshold config.upperEarningsLimit config.rates.secondaryThresholdToUpperEarningsLimit
  ,TaxBand config.upperEarningsLimit (1/0) config.rates.aboveUpperEarningsLimit
  ]

taxFor : List TaxBand -> Float -> Float
taxFor taxBands salary =
  List.foldl (\taxBand total -> TaxBand.taxFor salary taxBand + total ) 0 taxBands
