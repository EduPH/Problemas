module Main where

import Test.Tasty
import Test.Tasty.HUnit

import Bowling

-- Not done yet 

tests :: [(String, [Int], [Frame])]
tests =
      [ ("zeros are open 0 0"
        , replicate 20 0
        , replicate 10 (Open 0 0)
        )
      , ("ones are open 1 1"
        , replicate 20 1
        , replicate 10 (Open 1 1)
        )
      , ("4+5s are open 4 5"
        , take 20 $ cycle [4,5]
        , replicate 10 (Open 4 5)
        )
      ]



bowlingSuite :: TestTree
bowlingSuite = testGroup "Bowling tests"
               [ testGroup "toFrames" $
                 map (\(label, input, expected) ->
                         testCase label $ toFrames input @?= expected) tests
               ]
               

main = defaultMain bowlingSuite