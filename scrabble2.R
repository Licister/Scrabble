library(stringr)
source("scrabble1.R")
enable <- readLines("enable1.txt", warn = F)

score <- rep(0, length(letters))
names(score) <- letters
score[c("l", "s", "u", "n", "r", "t", "o", "a", "i", "e")] <- 1
score[c("g", "d")] <- 2
score[c("b", "c", "m", "p")] <- 3
score[c("f", "h", "v", "w", "y")] <- 4
score["k"] <- 5
score[c("j", "x")] <- 8
score[c("q", "z")] <- 10
score[c("?")] <- 0

enablescore <- data.frame(word = enable, score = 0, stringsAsFactors = F)

for(i in 1:nrow(enablescore)) {
    wordsp <- str_split(enablescore[i,1], "")[[1]]
	enablescore[i, 2] <- sum(score[wordsp] * 1:length(wordsp))
}


optimal <- function(origtiles) {
  library(stringr)
  origtiles <- str_split(origtiles, "")[[1]]
  bestword <- c()
  best <- 0

    
	for(j in 1:nrow(enablescore)) {
		finalscore <- 0
		if(enablescore[j, 2] > best) {
			wordsp <- str_split(enablescore[j, 1], "")[[1]]
			tiles <- origtiles
			bool <- c()
			usedtiles <- c()
			for(i in wordsp) {
				
				if(!(i %in% tiles) && "?" %in% tiles) {
					bool <- c(bool, TRUE)
					usedtiles <- c(usedtiles, "?")
					tiles <- tiles[-which(tiles == "?")[1]]
			
				} else {
					bool <- c(bool, i %in% tiles)
					if(bool[length(bool)] == FALSE) {break}
					usedtiles <- c(usedtiles, i)
					tiles <- tiles[-which(tiles == i)[1]]
				}
			}
			if(all(bool)) {finalscore <- sum(score[usedtiles] * 1:length(usedtiles)) }
			if(finalscore > best) {
				bestword <- enablescore[j, 1]
				best <- finalscore
			}
		}
	}
	return(cat(bestword, " (", best, ")", sep = "")) 
}


##test: 
#highest("dcthoyueorza") 
##answer is "zydeco"
##test: 
#optimal("dcthoyueorza")
##answer is "coauthored (85)"