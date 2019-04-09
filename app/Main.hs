module Main where

import Engine
import HoldEm (deal)
import Lib
import System.Random

main :: IO ()
main = do
  randomGen <- getStdGen
  print (best (deal randomGen 9))
