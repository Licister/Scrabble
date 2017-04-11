scrabble <- function(tiles, word, mode = 1,wordsp) {
  library(stringr)
  tiles <- str_split(tiles, "")[[1]]
  if(mode == 1) {word  <- str_split(word, "")[[1]]}
  else if(mode == 2) {word <- wordsp}
  bool <- c()
  for(i in word) {
    if(!(i %in% tiles) && "?" %in% tiles) {
      bool <- c(bool, TRUE)
      tiles <- tiles[-which(tiles == "?")[1]]
    } else {
      bool <- c(bool, i %in% tiles)
      if(bool[length(bool)] == FALSE) break
      tiles <- tiles[-which(tiles == i)[1]]
    }
  }
  return(all(bool))
}

longest <- function(tiles) {
  library(stringr)
  enable <- readLines("enable1.txt", warn = F)
  trues <- c()
  best <- 0
  for(word in enable) {
    wordsp <- str_split(word, "")[[1]] 
    len  <- length(wordsp)
    if(len > best) {
      if(scrabble(tiles, word, mode = 2, wordsp)) {
        best <- len
        trues <- word
      }  
    }
  }
  return(trues)
}



highest <- function(origtiles) {
  library(stringr)
  origtiles <- str_split(origtiles, "")[[1]]
  enable <- readLines("enable1.txt", warn = F)
  bestword <- c()
  best <- 0
  
  score <- rep(0, length(letters))
  names(score) <- letters
  score[c("l", "s", "u", "n", "r", "t", "o", "a", "i", "e")] <- 1
  score[c("g", "d")] <- 2
  score[c("b", "c", "m", "p")] <- 3
  score[c("f", "h", "v", "w", "y")] <- 4
  score["k"] <- 5
  score[c("j", "x")] <- 8
  score[c("q", "z")] <- 10
  
  for(word in enable) {
    wordsp <- str_split(word, "")[[1]]
	  maxval <- sum(score[wordsp])
	  tiles <- origtiles
	  if(maxval > best) {
	    bool <- c()
	    usedtiles <- c()
	  
	    for(i in wordsp) {
  		
        if(!(i %in% tiles) && "?" %in% tiles) {
			    bool <- c(bool, TRUE)
		  	  tiles <- tiles[-which(tiles == "?")[1]]
	  	
  		  } else {
  	  		bool <- c(bool, i %in% tiles)
  	  		if(bool[length(bool)] == FALSE) {break}
  	  		usedtiles <- c(usedtiles, i)
  	  		tiles <- tiles[-which(tiles == i)[1]]
  	  	}
  	  }
  	  if(all(bool)) {finalscore <- sum(score[usedtiles])}
  	  if(finalscore > best) {
  	    bestword <- word
  	    best <- finalscore
  	  }
  	}
  }
  return(bestword) 
}


##test: 
#highest("dcthoyueorza")
##answer is "zydeco"