module TaxBand exposing (..)

type alias TaxBand =
  { minimum: Float
  , maximum: Float
  , rateInPercent: Float
  }

taxFor : Float -> TaxBand -> Float
taxFor amount taxBand =
  amountWithinBand amount taxBand * taxBand.rateInPercent / 100.0

amountWithinBand : Float -> TaxBand -> Float
amountWithinBand amount taxBand =
  max (min (amount - taxBand.minimum) (taxBand.maximum - taxBand.minimum)) 0
