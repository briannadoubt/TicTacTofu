# TicTacTofu

Tic-Tac-Toe built with SwiftUI and GameplayKit

Made a super simple Tic-Tac-Toe game for a job interview. Themed it after a block of tofu that I have in my fridge. Thought of a silly pun regarding Tic-Tacs and Tofu.

The question remains: ***But, why tofu?***

This is a question I have grappled with over the course of developing this game. This semi-satirical exostential rabbit hole has been short-lived and petty in nature, but somehow, I find it poetic in it's simplicity.

## Anyways...

Tic-Tacs & Tofu is just like Tic-Tac-Toe, except that one player drops Tic-Tacs, and the other player drops blocks of Tofu.

Each player takes turns placing their respective objects. The first player to completely fill a column, a row, or a diagonal slice through the center of the board, wins! If neither player manages to do accomplish any of these, and there are no more possible winning paths, the game results in a tie.

The game picker allows a maximum board size of 25x25, but the implementation is NxN and scales to whatever the \"boardSize\" variable is set to in the source code.

I've also set up a simple algorithm for the computer to choose it's next move, which has a commented explaination in the source code.

Thanks for reading!
