data Color = Red | Blue
           deriving Show

winStreaks 0 = []
winStreaks 1 = [[Blue]]
winStreaks n = 
  map ([Blue] ++) (winStreaks (n-1)) ++
  map ([Red, Blue] ++) (winStreaks (n-2)) ++
  map ([Blue, Red] ++) (winStreaks (n-2))

main = print (winStreaks 4)