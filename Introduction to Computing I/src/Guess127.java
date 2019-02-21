import java.io.IOException;
import java.util.Scanner;
public class Guess127 {
    public static void main(String[] args) {
        System.out.println();
        args = new String[0];
        Scanner user_input = new Scanner(System.in);
        System.out.println("Welcome to Guess127. I will guess the number you are thinking of if you tell me this: In which boxes can you find it?");
        int[][] boxA = new int[8][8];
        boxA[0][0] = 1;
        boxA[0][1] = 3;
        boxA[0][2] = 5;
        boxA[0][3] = 7;
        boxA[0][4] = 9;
        boxA[0][5] = 11;
        boxA[0][6] = 13;
        boxA[0][7] = 15;
        boxA[1][0] = 17;
        boxA[1][1] = 19;
        boxA[1][2] = 21;
        boxA[1][3] = 23;
        boxA[1][4] = 25;
        boxA[1][5] = 27;
        boxA[1][6] = 29;
        boxA[1][7] = 31;
        boxA[2][0] = 33;
        boxA[2][1] = 35;
        boxA[2][2] = 37;
        boxA[2][3] = 39;
        boxA[2][4] = 41;
        boxA[2][5] = 43;
        boxA[2][6] = 45;
        boxA[2][7] = 47;
        boxA[3][0] = 49;
        boxA[3][1] = 51;
        boxA[3][2] = 53;
        boxA[3][3] = 55;
        boxA[3][4] = 57;
        boxA[3][5] = 59;
        boxA[3][6] = 61;
        boxA[3][7] = 63;
        boxA[4][0] = 65;
        boxA[4][1] = 67;
        boxA[4][2] = 69;
        boxA[4][3] = 71;
        boxA[4][4] = 73;
        boxA[4][5] = 75;
        boxA[4][6] = 77;
        boxA[4][7] = 79;
        boxA[5][0] = 81;
        boxA[5][1] = 83;
        boxA[5][2] = 85;
        boxA[5][3] = 87;
        boxA[5][4] = 89;
        boxA[5][5] = 91;
        boxA[5][6] = 93;
        boxA[5][7] = 95;
        boxA[6][0] = 97;
        boxA[6][1] = 99;
        boxA[6][2] = 101;
        boxA[6][3] = 103;
        boxA[6][4] = 105;
        boxA[6][5] = 107;
        boxA[6][6] = 109;
        boxA[6][7] = 111;
        boxA[7][0] = 113;
        boxA[7][1] = 115;
        boxA[7][2] = 117;
        boxA[7][3] = 119;
        boxA[7][4] = 121;
        boxA[7][5] = 123;
        boxA[7][6] = 125;
        boxA[7][7] = 127;

        int[][] boxB = new int[8][8];
        boxB[0][0] = 2;
        boxB[0][1] = 3;
        boxB[0][2] = 6;
        boxB[0][3] = 7;
        boxB[0][4] = 10;
        boxB[0][5] = 11;
        boxB[0][6] = 14;
        boxB[0][7] = 15;
        boxB[1][0] = 18;
        boxB[1][1] = 19;
        boxB[1][2] = 22;
        boxB[1][3] = 23;
        boxB[1][4] = 26;
        boxB[1][5] = 27;
        boxB[1][6] = 30;
        boxB[1][7] = 31;
        boxB[2][0] = 34;
        boxB[2][1] = 35;
        boxB[2][2] = 38;
        boxB[2][3] = 39;
        boxB[2][4] = 42;
        boxB[2][5] = 43;
        boxB[2][6] = 46;
        boxB[2][7] = 47;
        boxB[3][0] = 50;
        boxB[3][1] = 51;
        boxB[3][2] = 54;
        boxB[3][3] = 55;
        boxB[3][4] = 58;
        boxB[3][5] = 59;
        boxB[3][6] = 62;
        boxB[3][7] = 63;
        boxB[4][0] = 66;
        boxB[4][1] = 67;
        boxB[4][2] = 70;
        boxB[4][3] = 71;
        boxB[4][4] = 74;
        boxB[4][5] = 75;
        boxB[4][6] = 78;
        boxB[4][7] = 79;
        boxB[5][0] = 82;
        boxB[5][1] = 83;
        boxB[5][2] = 86;
        boxB[5][3] = 87;
        boxB[5][4] = 90;
        boxB[5][5] = 91;
        boxB[5][6] = 94;
        boxB[5][7] = 95;
        boxB[6][0] = 98;
        boxB[6][1] = 99;
        boxB[6][2] = 102;
        boxB[6][3] = 103;
        boxB[6][4] = 106;
        boxB[6][5] = 107;
        boxB[6][6] = 110;
        boxB[6][7] = 111;
        boxB[7][0] = 114;
        boxB[7][1] = 115;
        boxB[7][2] = 118;
        boxB[7][3] = 119;
        boxB[7][4] = 122;
        boxB[7][5] = 123;
        boxB[7][6] = 126;
        boxB[7][7] = 127;

        int[][] boxC = new int[8][8];
        boxC[0][0] = 4;
        boxC[0][1] = 5;
        boxC[0][2] = 6;
        boxC[0][3] = 7;
        boxC[0][4] = 12;
        boxC[0][5] = 13;
        boxC[0][6] = 14;
        boxC[0][7] = 15;
        boxC[1][0] = 20;
        boxC[1][1] = 21;
        boxC[1][2] = 22;
        boxC[1][3] = 23;
        boxC[1][4] = 28;
        boxC[1][5] = 29;
        boxC[1][6] = 30;
        boxC[1][7] = 31;
        boxC[2][0] = 36;
        boxC[2][1] = 37;
        boxC[2][2] = 38;
        boxC[2][3] = 39;
        boxC[2][4] = 44;
        boxC[2][5] = 45;
        boxC[2][6] = 46;
        boxC[2][7] = 47;
        boxC[3][0] = 52;
        boxC[3][1] = 53;
        boxC[3][2] = 54;
        boxC[3][3] = 55;
        boxC[3][4] = 60;
        boxC[3][5] = 61;
        boxC[3][6] = 62;
        boxC[3][7] = 63;
        boxC[4][0] = 68;
        boxC[4][1] = 69;
        boxC[4][2] = 70;
        boxC[4][3] = 71;
        boxC[4][4] = 76;
        boxC[4][5] = 77;
        boxC[4][6] = 78;
        boxC[4][7] = 79;
        boxC[5][0] = 84;
        boxC[5][1] = 85;
        boxC[5][2] = 86;
        boxC[5][3] = 87;
        boxC[5][4] = 92;
        boxC[5][5] = 93;
        boxC[5][6] = 94;
        boxC[5][7] = 95;
        boxC[6][0] = 100;
        boxC[6][1] = 101;
        boxC[6][2] = 102;
        boxC[6][3] = 103;
        boxC[6][4] = 108;
        boxC[6][5] = 109;
        boxC[6][6] = 110;
        boxC[6][7] = 111;
        boxC[7][0] = 116;
        boxC[7][1] = 117;
        boxC[7][2] = 118;
        boxC[7][3] = 119;
        boxC[7][4] = 124;
        boxC[7][5] = 125;
        boxC[7][6] = 126;
        boxC[7][7] = 127;

        int[][] boxD = new int[8][8];
        boxD[0][0] = 8;
        boxD[0][1] = 9;
        boxD[0][2] = 10;
        boxD[0][3] = 11;
        boxD[0][4] = 12;
        boxD[0][5] = 13;
        boxD[0][6] = 14;
        boxD[0][7] = 15;
        boxD[1][0] = 24;
        boxD[1][1] = 25;
        boxD[1][2] = 26;
        boxD[1][3] = 27;
        boxD[1][4] = 28;
        boxD[1][5] = 29;
        boxD[1][6] = 30;
        boxD[1][7] = 31;
        boxD[2][0] = 40;
        boxD[2][1] = 41;
        boxD[2][2] = 42;
        boxD[2][3] = 43;
        boxD[2][4] = 44;
        boxD[2][5] = 45;
        boxD[2][6] = 46;
        boxD[2][7] = 47;
        boxD[3][0] = 56;
        boxD[3][1] = 57;
        boxD[3][2] = 58;
        boxD[3][3] = 59;
        boxD[3][4] = 60;
        boxD[3][5] = 61;
        boxD[3][6] = 62;
        boxD[3][7] = 63;
        boxD[4][0] = 72;
        boxD[4][1] = 73;
        boxD[4][2] = 74;
        boxD[4][3] = 75;
        boxD[4][4] = 76;
        boxD[4][5] = 77;
        boxD[4][6] = 78;
        boxD[4][7] = 79;
        boxD[5][0] = 88;
        boxD[5][1] = 89;
        boxD[5][2] = 90;
        boxD[5][3] = 91;
        boxD[5][4] = 92;
        boxD[5][5] = 93;
        boxD[5][6] = 94;
        boxD[5][7] = 95;
        boxD[6][0] = 104;
        boxD[6][1] = 105;
        boxD[6][2] = 106;
        boxD[6][3] = 107;
        boxD[6][4] = 108;
        boxD[6][5] = 109;
        boxD[6][6] = 110;
        boxD[6][7] = 111;
        boxD[7][0] = 120;
        boxD[7][1] = 121;
        boxD[7][2] = 122;
        boxD[7][3] = 123;
        boxD[7][4] = 124;
        boxD[7][5] = 125;
        boxD[7][6] = 126;
        boxD[7][7] = 127;

        int[][] boxE = new int[8][8];
        boxE[0][0] = 16;
        boxE[0][1] = 17;
        boxE[0][2] = 18;
        boxE[0][3] = 19;
        boxE[0][4] = 20;
        boxE[0][5] = 21;
        boxE[0][6] = 22;
        boxE[0][7] = 23;
        boxE[1][0] = 24;
        boxE[1][1] = 25;
        boxE[1][2] = 26;
        boxE[1][3] = 27;
        boxE[1][4] = 28;
        boxE[1][5] = 29;
        boxE[1][6] = 30;
        boxE[1][7] = 31;
        boxE[2][0] = 48;
        boxE[2][1] = 49;
        boxE[2][2] = 50;
        boxE[2][3] = 51;
        boxE[2][4] = 52;
        boxE[2][5] = 53;
        boxE[2][6] = 54;
        boxE[2][7] = 55;
        boxE[3][0] = 56;
        boxE[3][1] = 57;
        boxE[3][2] = 58;
        boxE[3][3] = 59;
        boxE[3][4] = 60;
        boxE[3][5] = 61;
        boxE[3][6] = 62;
        boxE[3][7] = 63;
        boxE[4][0] = 80;
        boxE[4][1] = 81;
        boxE[4][2] = 82;
        boxE[4][3] = 83;
        boxE[4][4] = 84;
        boxE[4][5] = 85;
        boxE[4][6] = 86;
        boxE[4][7] = 87;
        boxE[5][0] = 88;
        boxE[5][1] = 89;
        boxE[5][2] = 90;
        boxE[5][3] = 91;
        boxE[5][4] = 92;
        boxE[5][5] = 93;
        boxE[5][6] = 94;
        boxE[5][7] = 95;
        boxE[6][0] = 112;
        boxE[6][1] = 113;
        boxE[6][2] = 114;
        boxE[6][3] = 115;
        boxE[6][4] = 116;
        boxE[6][5] = 117;
        boxE[6][6] = 118;
        boxE[6][7] = 119;
        boxE[7][0] = 120;
        boxE[7][1] = 121;
        boxE[7][2] = 122;
        boxE[7][3] = 123;
        boxE[7][4] = 124;
        boxE[7][5] = 125;
        boxE[7][6] = 126;
        boxE[7][7] = 127;

        int[][] boxF = new int[8][8];
        boxF[0][0] = 32;
        boxF[0][1] = 33;
        boxF[0][2] = 34;
        boxF[0][3] = 35;
        boxF[0][4] = 36;
        boxF[0][5] = 37;
        boxF[0][6] = 38;
        boxF[0][7] = 39;
        boxF[1][0] = 40;
        boxF[1][1] = 41;
        boxF[1][2] = 42;
        boxF[1][3] = 43;
        boxF[1][4] = 44;
        boxF[1][5] = 45;
        boxF[1][6] = 46;
        boxF[1][7] = 47;
        boxF[2][0] = 48;
        boxF[2][1] = 49;
        boxF[2][2] = 50;
        boxF[2][3] = 51;
        boxF[2][4] = 52;
        boxF[2][5] = 53;
        boxF[2][6] = 54;
        boxF[2][7] = 55;
        boxF[3][0] = 56;
        boxF[3][1] = 57;
        boxF[3][2] = 58;
        boxF[3][3] = 59;
        boxF[3][4] = 60;
        boxF[3][5] = 61;
        boxF[3][6] = 62;
        boxF[3][7] = 63;
        boxF[4][0] = 96;
        boxF[4][1] = 97;
        boxF[4][2] = 98;
        boxF[4][3] = 99;
        boxF[4][4] = 100;
        boxF[4][5] = 101;
        boxF[4][6] = 102;
        boxF[4][7] = 103;
        boxF[5][0] = 104;
        boxF[5][1] = 105;
        boxF[5][2] = 106;
        boxF[5][3] = 107;
        boxF[5][4] = 108;
        boxF[5][5] = 109;
        boxF[5][6] = 110;
        boxF[5][7] = 111;
        boxF[6][0] = 112;
        boxF[6][1] = 113;
        boxF[6][2] = 114;
        boxF[6][3] = 115;
        boxF[6][4] = 116;
        boxF[6][5] = 117;
        boxF[6][6] = 118;
        boxF[6][7] = 119;
        boxF[7][0] = 120;
        boxF[7][1] = 121;
        boxF[7][2] = 122;
        boxF[7][3] = 123;
        boxF[7][4] = 124;
        boxF[7][5] = 125;
        boxF[7][6] = 126;
        boxF[7][7] = 127;

        int[][] boxG = new int[8][8];
        boxG[0][0] = 64;
        boxG[0][1] = 65;
        boxG[0][2] = 66;
        boxG[0][3] = 67;
        boxG[0][4] = 68;
        boxG[0][5] = 69;
        boxG[0][6] = 70;
        boxG[0][7] = 71;
        boxG[1][0] = 72;
        boxG[1][1] = 73;
        boxG[1][2] = 74;
        boxG[1][3] = 75;
        boxG[1][4] = 76;
        boxG[1][5] = 77;
        boxG[1][6] = 78;
        boxG[1][7] = 79;
        boxG[2][0] = 80;
        boxG[2][1] = 81;
        boxG[2][2] = 82;
        boxG[2][3] = 83;
        boxG[2][4] = 84;
        boxG[2][5] = 85;
        boxG[2][6] = 86;
        boxG[2][7] = 87;
        boxG[3][0] = 88;
        boxG[3][1] = 89;
        boxG[3][2] = 90;
        boxG[3][3] = 91;
        boxG[3][4] = 92;
        boxG[3][5] = 93;
        boxG[3][6] = 94;
        boxG[3][7] = 95;
        boxG[4][0] = 96;
        boxG[4][1] = 97;
        boxG[4][2] = 98;
        boxG[4][3] = 99;
        boxG[4][4] = 100;
        boxG[4][5] = 101;
        boxG[4][6] = 102;
        boxG[4][7] = 103;
        boxG[5][0] = 104;
        boxG[5][1] = 105;
        boxG[5][2] = 106;
        boxG[5][3] = 107;
        boxG[5][4] = 108;
        boxG[5][5] = 109;
        boxG[5][6] = 110;
        boxG[5][7] = 111;
        boxG[6][0] = 112;
        boxG[6][1] = 113;
        boxG[6][2] = 114;
        boxG[6][3] = 115;
        boxG[6][4] = 116;
        boxG[6][5] = 117;
        boxG[6][6] = 118;
        boxG[6][7] = 119;
        boxG[7][0] = 120;
        boxG[7][1] = 121;
        boxG[7][2] = 122;
        boxG[7][3] = 123;
        boxG[7][4] = 124;
        boxG[7][5] = 125;
        boxG[7][6] = 126;
        boxG[7][7] = 127;

        System.out.print("Please ");
        waitForPlayer();

        System.out.println("Box A:");
        printMatrix(boxA);
        System.out.println("Box B:");
        printMatrix(boxB);
        System.out.println("Box C:");
        printMatrix(boxC);
        System.out.println("Box D:");
        printMatrix(boxD);
        System.out.println("Box E:");
        printMatrix(boxE);
        System.out.println("Box F:");
        printMatrix(boxF);
        System.out.println("Box G:");
        printMatrix(boxG);
        System.out.print("Please memorize the number of boxes you can find this number in and the name of the boxes before continuing. When you are done, please ");
        waitForPlayer();
        System.out.println();

        int numberOfBoxes;
        do {
                System.out.println("Please enter the number of boxes in which you have found your number");
            while (!user_input.hasNextInt())
            {
                System.out.println("Invalid input (please enter an integer between 1 and 7)");
                user_input.next();
            }
                numberOfBoxes = user_input.nextInt();
                if (numberOfBoxes < 1 || numberOfBoxes > 7) {
                    System.out.println("The number of boxes entered is not possible (there are 7 boxes)");
                }
                System.out.println();
            }while ((numberOfBoxes < 1 || numberOfBoxes > 7));
        int [] arrBox = new int[numberOfBoxes];
        for (int i=0; i<numberOfBoxes; i++) {
            char box;
            do {
                System.out.println("Please enter the name of box " + (i + 1));
                box = user_input.next().charAt(0);
                if (!(box == 'A' || box == 'B' || box == 'C' || box == 'D' || box == 'E' || box == 'F' || box == 'G')) {
                    System.out.println("Invalid box name (capital letters from A to G)");
                }
            }
            while ((!(box == 'A' || box == 'B' || box == 'C' || box == 'D' || box == 'E' || box == 'F' || box == 'G')));
                  if (box == 'A') {
                    arrBox[i] = boxA[0][0];
                } else if (box == 'B') {
                    arrBox[i] = boxB[0][0];
                } else if (box == 'C') {
                    arrBox[i] = boxC[0][0];
                } else if (box == 'D') {
                    arrBox[i] = boxD[0][0];
                } else if (box == 'E') {
                    arrBox[i] = boxE[0][0];
                } else if (box == 'F') {
                    arrBox[i] = boxF[0][0];
                } else {
                    arrBox[i] = boxG[0][0];
                }
        }
        int sum = 0;
        boolean notRepeated = true;
        for (int k = 0; k < arrBox.length && notRepeated; k++) {
            for (int l=k+1; l<arrBox.length && notRepeated; l++) {
                if (arrBox[k] == arrBox[l]) {
                    notRepeated = false;
                    System.out.println("You input more than once the same box name, the game will restart, please ");
                    waitForPlayer();
                    main(args);
                }
            }
        }
        for (int i = 0; i < arrBox.length && notRepeated; i++)
        {
            sum = sum + arrBox[i];
        }
        if (notRepeated) {
            System.out.println("The number you are thinking of is " + sum);
            System.out.println();
            System.out.println("Do you want to play again? (please enter character 'y' for yes or anything else for no)");
            while(!user_input.hasNext()){
                System.out.println("Invalid input, please enter character 'y' for yes or anything else for no");
                user_input.next();
            }
            char playAgain = user_input.next().charAt(0);
            if (playAgain=='y'){
                main(args);
            }
        }
    }

    private static void printMatrix(int[][] matrix) {
        for (int[] aMatrix : matrix) {
            for (int anAMatrix : aMatrix) {
                System.out.printf("%4d", anAMatrix);
            }
            System.out.println();
        }
        System.out.println();
    }

    private static void waitForPlayer()
    {
        System.out.print("press enter to continue");
        try {
            System.in.read();
        }
        catch (IOException e){
            System.out.println("Error reading from user");
        }
    }
}
