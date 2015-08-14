import Data.Char

x :: [Char]
x = "abc" ++ "def"

func :: [Char] -> [Char]
func a = a ++ " the end"

append = (++)

-- starts with [a-z], prefix by default, infix surrounded by `backticks`
-- else, infix by default, prefix surround by ()
-- eg: ++ vs append

-- lowercase in type position -> poly
-- parentheses below are neccessary to left associate
func2 :: ([Char] ->a) -> a
func2 f = f "xyz"

name1 = func2 reverse

-- given list, ignore it and return 798
name2 = func2 (\list -> 789)

-- lambda: \ ->
name3 = func2 (\list -> map toUpper list)

func3 :: (Int -> Int -> a) -> a
func3 f = f 7 8

func4 :: (Int -> Int -> a) -> a
func4 = \f -> f 7 8 

res3 = func3 (\x y -> (3*x) + (4*y))


-- data types
-- data <Name> [0 or more typevars] =
--    <Ctor1> [0 or more args]
--    | <Ctor2> [0 or more args]

data Person = 
    PersonA 
        String --name
        Int --age

    deriving(Eq,Show)

-- data types/ctors always start with Uppercase (if alpha numeric)
-- functions always lowercase (if alpha numeric)

data Shape = 
    Circle Int
    | Rectangle Int Int

pie :: Int
pie = 3

perimeter :: Shape -> Int

perimeter (Circle r) = 
    r * 2 * pie
perimeter (Rectangle w h) = 
    2 * w + 2 * h

-- inline pattern match
area s =
    case s of 
        Circle r -> pie * r * r
        Rectangle w h -> w * h


doubleShape :: Shape -> Shape

doubleShape (Circle r) = Circle (2*r)

doubleShape (Rectangle w h) = Rectangle (2*w) (2*h)

