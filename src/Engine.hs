module Engine where

import Data.List (elemIndices, intersect)
import HoldEm (Hand, PHand, Table)
import qualified HoldEm (bestHand)

type Game = (HoldEm.Table, [HoldEm.PHand])

playHand :: [Bool] -> Either a Game -> ([Int], [Int])
playHand allIns game =
  (elemIndices False allIns, elemIndices True allIns `intersect` win)
  where
    (win, _) = best game

best :: Either a Game -> ([Int], Game)
best (Right game@(table, hands)) = (winners table hands, game)

winners :: Table -> [PHand] -> [Int]
winners table hands = elemIndices (maximum a) a
  where
    a = bestHands table hands

bestHands :: Table -> [PHand] -> [Hand]
bestHands table = map (`bestHand` table)

bestHand :: PHand -> Table -> Hand
bestHand hand table = fst (HoldEm.bestHand hand table)
