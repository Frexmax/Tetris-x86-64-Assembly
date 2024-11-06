# Tetris-x86-64-Assembly
Tetris implemented in x86-64 assembly using the raylib library for the CSE1400 Computer Organisation course at TU Delft.

## Requirements 

## Installation Instructions

## How to run 
Firstly make sure you have the raylib library correctly installed!
Then you can run the game itself by:

| Command          | Description                                                       |
| ---------------- | ----------------------------------------------------------------- | 
| make tetris      | assembles the game to a binary file (prepares the file to be run) | 
| make play        | runs the game                                                     | 
| make clean       | removes the binary file                                           | 
| make reset_score | sets all top 5 scores to 0                                        |

![TetrisGitHubDocs2](https://github.com/user-attachments/assets/3306e353-c06e-499f-98a6-e1adbfb6eb65)

## Controls 

| Key                | Effect                                                                             |
| ------------------ | ---------------------------------------------------------------------------------- | 
| UP arrow           | rotate block                                                                       | 
| RIGHT arrow        | shift block to the right                                                           | 
| LEFT arrow         | shift block to the left                                                            | 
| DOWN arrow         | increase fall rate of the block, increase per press, holding the key has no effect |

## Gameplay 
The overall gameplay has been kept true to the original with some minor changes in the way the level is updated!
In our version the level is updated per 5 blocks, which, like in the original, slightly increases the default 
speed of the blocks.

## Technical Documentation
Interested in the technical details and implementation of the game ? 
Then please explore the [Technical Documentation Section](https://github.com/Frexmax/Tetris-x86-64-Assembly/tree/main/docs)

## Acknoledgments 
This project was the result of great collaboration with [@batm0use](https://github.com/batm0use) 
