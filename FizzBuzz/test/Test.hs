module Main where

import Test.Tasty
import Test.Tasty.HUnit

import FizzBuzz


lessThan20Answers = words ("one two three four five six seven eight nine ten " ++
                           "eleven twelve thirteen fourteen fifteen sixteen " ++
                           "seventeen eighteen nineteen")
tensAnswers = words "twenty thirty forty fifty sixty seventy eighty ninety"

fizzBuzzSuite :: TestTree
fizzBuzzSuite = testGroup "FizzBuzz tests"
                [ testGroup "fizzbuzz" $            
                  [ testCase "1 is one!" $ fizzbuzz 1 @?= "one!"
                  , testCase "2 is two!" $ fizzbuzz 2 @?= "two!"
                  , testCase "5 is buzz!" $ fizzbuzz 5 @?= "buzz!"
                  ]
                , testGroup "lessThan20" $
                  map ( \(n,t) -> testCase (show n ++ " is " ++ t ) $ lessThan20 n @?= t)
                      (zip [1..] lessThan20Answers)
                , testGroup "tens" $
                  map ( \(n,t) -> testCase (show n ++ " is " ++ t ) $ tens n @?= t)
                      (zip [2..] tensAnswers)
                , testGroup "number"
                  [ testCase "1 is one" $ number 1 @?= "one"
                  , testCase "5 is five" $ number 5 @?= "five"
                  , testCase "10 is ten" $ number 10 @?= "ten"
                  ]
                ]

main = defaultMain fizzBuzzSuite