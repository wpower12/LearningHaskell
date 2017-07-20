{-# OPTIONS_GHC -Wall -fno-warn-tabs#-}
module LogAnalysis where

import Log

-- Parsing the Actual Log
parseMessage :: String -> LogMessage
parseMessage m = makeLog (words m)

makeLog :: [String] -> LogMessage
makeLog (x:xs)
	| x == "E" = LogMessage (Error (read (head xs))) (read (xs !! 1)) (unwords (tail (tail xs)))
	| x == "W" = LogMessage Warning (read (head xs)) (unwords (tail xs))
	| x == "I" = LogMessage Info (read (head xs)) (unwords (tail xs))
	| otherwise = Unknown (unwords (tail xs))
makeLog [] = Unknown "unknown"

parse :: String -> [LogMessage]
parse logs = map parseMessage (lines logs)

-- Creating an ordered BST from the array of Log Messages
insert :: LogMessage -> MessageTree -> MessageTree
insert lmsg@(LogMessage _ ts _) (Node l lmsgn@(LogMessage _ tsn _) r) 
	| ts < tsn = Node (insert lmsg l) lmsgn r
	| otherwise = Node l lmsgn (insert lmsg r)
insert lmsg@(LogMessage _ _ _) Leaf = Node Leaf lmsg Leaf
insert (Unknown _) n@(Node _ _ _) = n
insert (Unknown _) n@(Leaf) = n
insert (LogMessage _ _ _) (Node _ (Unknown _) _) = Leaf -- To shut up the warning.

build :: [LogMessage] -> MessageTree
build (x:xs) = insert x (build xs)
build [] = Leaf

inOrder :: MessageTree -> [LogMessage]
inOrder (Node l n r) = (inOrder l) ++ [n] ++ (inOrder r)
inOrder (Leaf) = []

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong ((LogMessage (Error sev) _ str):xs) 
	| sev > 50 = [str] ++ (whatWentWrong xs)
	| otherwise = whatWentWrong xs
whatWentWrong ((LogMessage _ _ _):xs) = whatWentWrong xs
whatWentWrong ((Unknown _ ):xs) = whatWentWrong xs
whatWentWrong [] = []