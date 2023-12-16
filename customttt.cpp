// customttt.cpp
// Anand T. Egan
// 2023-12-15
//
// For CS 301 Fall 2023
// Source Code for NxN Tic Tac Toe (Size up to 10x10 board)
// Many functions written in assembly and called by this main file.
// Final Code

// RULES:
// MAXIMUM BOARD SIZE OF 10 - THE BOARD WILL NOT DISPLAY CORRECTLY OTHERWISE
// PLAYER X ALWAYS GOES FIRST

#include <iostream>
// For user input and game output/display
#include <limits>
// For fail state inputs

// Reasonable size for a board before the board becomes too big to display
const int MAX_SIZE = 10;

extern "C" void buildBoard(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE); // Function written in NASM Assembly

extern "C" int getCharInt(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE, int indexX, int indexY); // Function written in NASM Assembly

extern "C" void modifyChar(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE, int indexX, int indexY, char replaceChar); // Function written in NASM Assembly

char getChar(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE, int indexX, int indexY) // Converts the int of an indexed char that function getCharInt got and converts it into a char for C++ to use
{
    int indexedInt = getCharInt(board,BOARD_SIZE,indexX,indexY); // Calls assembly function to grab the int of an indexed char from the 2D array board
    char indexedChar = static_cast<char>(indexedInt); // Converts the int of the indexed char into a char
    return indexedChar; // Return the indexed char
}

extern "C" void printBoard(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE); // Function written in NASM Assembly

extern "C" void checkHorizontalX(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE); // Function written in NASM Assembly

extern "C" void checkHorizontalO(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE); // Function written in NASM Assembly

extern "C" void checkVerticallyX(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE); // Function written in NASM Assembly

extern "C" void checkVerticallyO(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE); // Function written in NASM Assembly

extern "C" void checkLeftDiagonalX(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE); // Function written in NASM Assembly

extern "C" void checkLeftDiagonalO(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE); // Function written in NASM Assembly

extern "C" void checkRightDiagonalX(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE); // Function written in NASM Assembly

extern "C" void checkRightDiagonalO(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE); // Function written in NASM Assembly

extern "C" void noWinner(char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE, int playerSwitch); // Function written in NASM Assembly

int winConditionMet(int playerSwitch, char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE) 
{
    // If playerSwitch == 1 (X) just played, check if X won.
    // Else, check if O won.
    if(playerSwitch == 1) 
    {
        checkHorizontalX(board, BOARD_SIZE); // Call assembly function to check if X won horizontally
        checkVerticallyX(board, BOARD_SIZE); // Call assembly function to check if X won vertically
        checkLeftDiagonalX(board, BOARD_SIZE); // Call assembly function to check if X won left diagonally
        checkRightDiagonalX(board, BOARD_SIZE); // Call assembly function to check if X won right diagonally
    } 
    else 
    {
        checkHorizontalO(board, BOARD_SIZE); // Call assembly function to check if X won horizontally
        checkVerticallyO(board, BOARD_SIZE); // Call assembly function to check if Y won vertically
        checkLeftDiagonalO(board, BOARD_SIZE); // Call assembly function to check if Y won left diagonally
        checkRightDiagonalO(board, BOARD_SIZE); // Call assembly function to check if Y won right diagonally
    }

    noWinner(board, BOARD_SIZE, playerSwitch); // Call assembly function to check if the whole board is filled with no winner

    return 0; // If the win condition has not been met yet, return 0 (aka: do nothing)
}

int turn(int playerSwitch, char board[MAX_SIZE][MAX_SIZE], int BOARD_SIZE) 
{
    // Set up variables for player input
    int input;
    bool validInput = false;
    int xInput = 0;
    int yInput = 0;

    // If it's X's turn, ask for input.
    // Other wise, it's O's turn, thus ask them for input.
    if(playerSwitch == 1) {
        std::cout << "PLAYER 1 TURN!" << std::endl;;
        
        // Check to make sure the player is not inserting in an invalid spot.
        while (!validInput) {
            std::cout << "Type in Coordinates to place an X on that spot!" << std::endl;
            std::cout << "Enter X coordinate: ";
            std::cin >> yInput;
            std::cout << "Enter Y coordinate: ";
            std::cin >> xInput;

            // If the input is a fail state (i.e. user inputted a string or character), then clear the fail state and ask for input again
            if (std::cin.fail()) {
                std::cout << "INVALID INPUT! Please enter valid integer coordinates." << std::endl;
                std::cin.clear(); // Clear the fail state
                std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n'); // Ignore invalid input
            } 
            // Program crashes when the input is very far out of bounds
            // Check if it's far out of bounds 
            else if(xInput > MAX_SIZE || yInput > MAX_SIZE)
            {
                    std::cout << "INVALID INPUT! Out of bounds! Try again." << std::endl;;
            }
            else 
            {
                // Use assembly to check what character is in that coordinate for validity testing
                char checkChar = getChar(board, BOARD_SIZE, yInput, xInput);

                // Check the coordinate to see if there is already a placed piece there.
                // Check if the coordinates are in a valid position as well
                if ((checkChar == 'O' || checkChar == 'X') ||
                        xInput > BOARD_SIZE - 1 || yInput > BOARD_SIZE - 1 ||
                        xInput < 0 || yInput < 0) {
                    std::cout << "INVALID INPUT! Try again." << std::endl;
                } else {
                    validInput = true;
                }
            }
        }


        modifyChar(board,BOARD_SIZE,xInput,yInput,'X'); // Use assembly to place an X in that coordinate
        winConditionMet(playerSwitch, board, BOARD_SIZE); // Check if player X has created a win condition

        playerSwitch = 0;
        return playerSwitch;
    } 
    else 
    {
        std::cout << "PLAYER 2 TURN!" << std::endl;;
        while(!validInput) 
        {
            std::cout << "Type in Coordinates to place an O on that spot!" << std::endl;;
            std::cout << "Enter X coordinate: ";
            std::cin >> yInput;
            std::cout << "Enter Y coordinate: ";
            std::cin >> xInput;

            // If the input is a fail state (i.e. user inputted a string or character), then clear the fail state and ask for input again
            if (std::cin.fail()) {
                std::cout << "INVALID INPUT! Please enter valid integer coordinates." << std::endl;
                std::cin.clear(); // Clear the fail state
                std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n'); // Ignore invalid input
            } 
            // Program crashes when the input is very far out of bounds
            // Check if it's far out of bounds 
            else if(xInput > MAX_SIZE || yInput > MAX_SIZE)
            {
                    std::cout << "INVALID INPUT! Out of bounds! Try again." << std::endl;;
            }
            else 
            {
                // Use assembly to check what character is in that coordinate for validity testing
                char checkChar = getChar(board,BOARD_SIZE,yInput,xInput);

                // Check the coordinate to see if there is already a placed piece there.
                // Check if the coordinates are in a valid position as well
                if((checkChar == 'O' || checkChar == 'X') ||
                    xInput > BOARD_SIZE - 1 || yInput > BOARD_SIZE - 1 ||
                    xInput < 0 || yInput < 0) {
                    std::cout << "INVALID INPUT! Try again." << std::endl;;
                } 
                else 
                {
                    validInput = true;
                }
            }
        }

        modifyChar(board,BOARD_SIZE,xInput,yInput,'O'); // Use assembly to place an O in that coordinate
        winConditionMet(playerSwitch, board, BOARD_SIZE); // Check if player X has created a win condition

        playerSwitch = 1;
        return playerSwitch;
    }
}

int main() {
    // Initialize the game
    int BOARD_SIZE = 3; // Default board size
    char board[MAX_SIZE][MAX_SIZE]; // Create a 2D 10x10 array for the board
    int continueGame = 0;
    int playerSwitch = 1;

    // Welcome message
    std::cout << "Welcome to NxN Tic Tac Toe!" << std::endl;;

    // Ask for player input for board size
    // While doing so, check if their input is valid
    bool validInput = false;
    while(!validInput)
    {
        std::cout << "How big should the board be?" << std::endl;;
        std::cout << "NOTE: Board size cannot be less than 3 or greater than 10" << std::endl;;
        std::cout << "Input board size: ";
        std::cin >> BOARD_SIZE;

        // If the input is a fail state (i.e. user inputted a string or character), then clear the fail state and ask for input again
        if (std::cin.fail()) {
                std::cout << "INVALID INPUT! Please enter a valid integer" << std::endl;
                std::cin.clear(); // Clear the fail state
                std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n'); // Ignore invalid input
        } 
        else 
        {
            if(BOARD_SIZE > 10)
            {
                std::cout << "Sorry! Board size cannot be greater than " << MAX_SIZE << " :(" << std::endl;;
            }
            else if(BOARD_SIZE < 3)
            {
                std::cout << "Sorry! Board size cannot be less than 3 :(" << std::endl;;
            }
            else
            {
                validInput = true;
            }
        }
    }
    std::cout << "Generated board of size " << BOARD_SIZE << std::endl;;

    // Call assembly function to build a blank board
    buildBoard(board, BOARD_SIZE);

    // Game loop
    while(continueGame == 0) 
    {
        // Display the board by calling the printBoard assembly function
        printBoard(board, BOARD_SIZE);
        // Take turns playing, player X plays first
        playerSwitch = turn(playerSwitch, board, BOARD_SIZE);
        // Check if a win condition has been met, if not, continue the game by looping
        continueGame = winConditionMet(playerSwitch, board, BOARD_SIZE);
    }

    return 0;
}