# NxN Tic Tac Toe Game

## Overview

This program, `customttt.cpp`, implements a console-based NxN Tic Tac Toe game with a customizable board size (up to 10x10). The game supports two players (X and O) taking turns to place their respective symbols on the board. 

The program is primarily written in NASM Assembly, such as the win conditions and printing the board for display the the players, and C++ as the input and output, as well as calling the functions that were written in Assembly.

## Features

- **Customizable Board Size:** The user can specify the size of the Tic Tac Toe board at the beginning of the game (between 3x3 and 10x10).

- **Two-Player Gameplay:** Players X and O take turns to input coordinates and place their symbols on the board.

- **Win Condition Detection:** The program utilizes NASM Assembly functions to check for win conditions, including horizontal, vertical, and diagonal alignments for both X and O.

## Usage

1. **Board Size Input:**
   - The user is prompted to input the desired size for the Tic Tac Toe board.
   - Board sizes less than 3 or greater than 10 are not allowed.

2. **Gameplay:**
   - Players take turns entering coordinates to place their symbols (X or O) on the board.
   - Invalid inputs (e.g., out-of-bounds or already occupied positions) are handled.

3. **Win Conditions:**
   - The game checks for win conditions after each move.
   - If a player achieves a win condition, the game announces the winner and exits the program.

4. **Display:**
   - The current state of the board is displayed after each move.

## Notes

- **Assembly Functions:** Many core functions, including board building, character retrieval, modification, and win condition checks, are implemented in NASM Assembly and called from the C++ main file.

- **Rules:**
   - The maximum allowed board size is 10x10. Attempting to exceed this size may result in incorrect display.
   - Player X always goes first.

## Dependencies

- The program uses the `<iostream>` and `<limits>` headers for user input, output, and error handling.
