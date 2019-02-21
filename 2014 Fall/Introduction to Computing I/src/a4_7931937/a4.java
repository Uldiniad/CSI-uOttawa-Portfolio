import java.util.Scanner;
import java.io.IOException;
class a4{
    // main method. DO NOT MODIFY
    public static void main(String args[]) {
        Scanner keyboard = new Scanner( System.in );
        System.out.println("Welcome to Memory Game");
        int board_side;
        //this loop obtains the board size, or more specifically
        // the length of the side of the board
        do{
            System.out.println("\n For 2x2 board game press 2"+
                    "\n For 4x4 board game press 4"+
                    "\n For 6x6 board game press 6");
            board_side=keyboard.nextInt();
        }while(board_side!=2 && board_side!=4 && board_side!=6);
        char[][] board = createBoard(board_side);
        // a call the the shuffle method
        shuffleBoard(board);
        // a call to the game playing method
        playGame(board);
    }
    // The following method should shuffle the input 2D array called board
    public static void shuffleBoard(char[][] board) {
        // This creates a 1D array whose size is equal to the size of the board
        int N = board.length * board.length;
        char[] board1D = new char[N];
        // Copy the elements of 2D array into that 1D array here
        int k = 0;
        for(int i = 0; i < board.length; i ++)
            for(int j = 0; j < board.length; j ++){
                board1D[k] = board[i][j];
                k++;
            }
        // Shuffle 1D array here
        for (int i = 0; i < board1D.length; i++) {
            // Generate an index randomly
            int index = (int) (Math.random() * board1D.length);
            char temp = board1D[i];
            board1D[i] = board1D[index];
            board1D[index] = temp;
        }
            //Copy shuffled 1D array back into 2D array, i.e., back to the board
         k = 0;
         for (int i = 0; i < board.length; i++)
             for (int j = 0; j < board.length; j++) {
                 board[i][j] = board1D[k];
                 k++;
             }
    }
    // a game playing method
    public static void playGame(char[][] board) {
        Scanner keyboard = new Scanner(System.in);
        // this creates a 2D array indicating what locations are paired, i.e., discovered
        // at the begining none are, so default initializaiton to false is ok
        boolean[][] discovered = new boolean[board.length][board[0].length];
        for (int i = 0; i < discovered.length; i++) {
            for (int j = 0; j < discovered.length; j++) {
                discovered[i][j] = false;
            }
        }
        // the code for your game playing goes here
        System.out.print(" ");
        for (int k = 0; k < discovered.length; k++) {
            System.out.print(" " + (k + 1)); // This part prints the numbers of the columns
        }
        System.out.println();
        for (int i = 0; i < discovered.length; i++) {
            System.out.print((i + 1) + " "); // This part prints the numbers of the rows
            for (int j = 0; j < discovered.length; j++) {
                System.out.print("*" + " "); // Since it is the first run, the grid is undiscovered
            }
            System.out.println();
        }
        System.out.println("Enter undiscovered distinct locations on the board that you want revealed. Enter in this format: Row number + spacebar + column number\n" +
                "The entered numbers must be in the range [1," + discovered.length + "]");
        int i;
        int j;
        boolean allDiscovered; // Flag to quit the loop when all the tiles have been discovered
        do {
            allDiscovered=true; // Until proof of the contrary, all tiles are discovered
            System.out.println("Enter the first location");
            do {
                i = keyboard.nextInt();
                j = keyboard.nextInt();
                if (!(((i < (discovered.length + 1)) && (i > 0)) && ((j < (discovered.length + 1)) && (j > 0)))) { // check if the location is within the array
                    System.out.println("The entered location does not exist. Please enter a valid location");
                }
                if (((i-1)>=0&&(i-1)<discovered.length)&&((j-1)>=0&&(j-1)<discovered.length)) { // same as above. Necessary for the following verification
                    if (discovered[i - 1][j - 1] == true) { // check if the location was already discovered
                        System.out.println("The entered location is already discovered. Please enter an undiscovered location");
                    }
                }
            } while ((!((i < discovered.length + 1) && (i > 0)) && ((j < discovered.length + 1) && (j > 0))) || (!(((i-1)>=0&&(i-1)<discovered.length)&&((j-1)>=0&&(j-1)<discovered.length)))||(discovered[i - 1][j - 1] == true)); // if the user entered invalid input, make him repeat
            System.out.println("Enter the second location");
            int x;
            int y;
            do { // same verifications as above
                x = keyboard.nextInt();
                y = keyboard.nextInt();
                if (!(((x < (discovered.length + 1)) && (x > 0)) && ((y < (discovered.length + 1)) && (y > 0)))) {
                    System.out.println("The entered location does not exist. Please enter a valid location");
                }
                if (x == i && y == j) {
                    System.out.println("The location has already been entered, please enter another location"); // verify if the second location entered is the same as the first one
                }
                if (((x-1)>=0&&(x-1)<discovered.length)&&((y-1)>=0&&(y-1)<discovered.length)) {
                    if (discovered[x - 1][y - 1] == true) {
                        System.out.println("The entered location is already discovered. Please enter an undiscovered location");
                    }
                }
            } while (!(((x < discovered.length + 1) && (x > 0)) && ((y < discovered.length + 1) && (y > 0))) || (x == i && y == j) || (!((x-1)>=0&&(x-1)<discovered.length)&&((y-1)>=0&&(y-1)<discovered.length))||(discovered[x - 1][y - 1] == true));
            discovered[i - 1][j - 1] = true;// boolean to display the tile of the first location
            discovered[x - 1][y - 1] = true;// boolean to display the tile of the second location
            System.out.print(" ");
            for (int k = 0; k < discovered.length; k++) {
                System.out.print(" " + (k + 1)); // print number of column
            }
            System.out.println();
            for (int a = 0; a < discovered.length; a++) {
                System.out.print((a + 1) + " "); // print number of row
                for (int b = 0; b < discovered.length; b++) {
                    if (discovered[a][b] == true) {
                        System.out.print(board[a][b] + " "); // display the tiles the user asked to be discovered
                    } else {
                        System.out.print("*" + " "); // hides the tiles the user did not ask to discover
                    }
                }
                System.out.println();
            }
            if (board[x-1][y-1] != board[i-1][j-1]) { // if the tiles do not match, do not display them
                discovered[i - 1][j - 1] = false;
                discovered[x - 1][y - 1] = false;
            }
            for(int m=0;m<discovered.length;m++){// loop to verify if there are any tiles left to match
                for (int n=0;n<discovered.length;n++) {
                    if (discovered[m][n] == false) {
                        allDiscovered = false;
                    }
                }
            }
            waitForPlayer();// allow the player to manually choose when to continue the game (time to memorize)
            for (int o=0; o<200; o++)
            {
              System.out.println();// clear the screen so that the player can't see the previous output
            }
        }while(!allDiscovered); //repeat all the steps until all tiles are discovered
        if (allDiscovered){ // when all tiles are discovered, the player has won!
            System.out.println("Congratulations! You completed the game!");
        }
    }
    // createBoard method. DO NOT MODIFY!
 /* this method, createBoard, creates the board filled with letters of alphabet,
  where each letter appears exactly 2 times
  e.g., for 4 x 4, the returned board would look like:
  A B C D
  E F G H
  A B C D
  E F G H */
    public static char[][] createBoard(int side)
    {
        char[][] tmp = new char[side][side];
        int letter_count=0;
        for (int row = 0; row < tmp.length/2; row++){
            for(int col = 0; col < tmp[row].length; col++)
            {
                tmp[row][col]=(char)('A'+letter_count);
                tmp[row+tmp.length/2 ][col]=tmp[row][col];
                letter_count++;
            }
        }
        return tmp;
    }
    // waitForPlayer method. Do not modify!
    public static void waitForPlayer()
    {
        System.out.print("Press enter to continue");
        try {
            System.in.read();
        }
        catch (IOException e){
            System.out.println("Error reading from user");
        }
    }
}

