-- Part 1 - Validating Credit Card Numbers
toDigits :: Integer -> [Integer]
toDigits 0 = []
toDigits n 
	| n > 0 = (toDigits (n `div` 10)) ++ [n `mod` 10]
	| otherwise = []

toDigitsRev :: Integer -> [Integer]
toDigitsRev 0 = []
toDigitsRev n 
	| n > 0 = [n `mod` 10] ++ (toDigitsRev (n `div` 10))
	| otherwise = []

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther (x:[]) = [x]
doubleEveryOther (x:(y:zs))
	| (length zs) `mod` 2 == 0 = (2*x):y:doubleEveryOther zs
	| otherwise = x:(2*y):doubleEveryOther zs 

sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:[]) = (x `div` 10) + (x `mod` 10)
sumDigits (x:ys) = (x `div` 10) + (x `mod` 10) + sumDigits ys

validate :: Integer -> Bool
validate n = sumDigits (doubleEveryOther (toDigits n)) `mod` 10 == 0

-- Part 2 - Towers of Hanoi
type Peg = String
type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 0 a b c = []
hanoi n a b c = (hanoi (n-1) a c b) ++ [(a, b)] ++ (hanoi (n-1) c b a)
