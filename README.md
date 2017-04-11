#Scrabble-inspired functions
  
This code was done for [Challenge #294: Rack management 1](https://www.reddit.com/r/dailyprogrammer/comments/5go843/20161205_challenge_294_easy_rack_management_1/) and [2](https://www.reddit.com/r/dailyprogrammer/comments/5h40ml/20161207_challenge_294_intermediate_rack/), using the language R.
  
The main functions are:
* `scrabble`: given a set of tiles and a word, return whether the letters in the tile can create the word. There are also wild card characters that can replace any letter in the word;
* `longest`: given a set of tiles, determine the longest word from the `enable1` English word list that can be formed using the tiles;
* `highest`: considering that each tile is worth a certain number of points, determine the highest-scoring word from the `enable1` word list that can be formed using the tiles;
* `optimal`: using pre-processing and different rules for the points, find the highest score possible for a single word from the `enable1` word list that can be made using the tiles.


