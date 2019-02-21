import java.io.IOException;
import java.util.Scanner;
public class GuessingGame {
    public static void main(String[] args) {
        System.out.println();
        args = new String[0];
        Scanner user_input = new Scanner(System.in);
        System.out.println("Welcome to Guessing Game 1. I will guess the number you are thinking of.");
        waitForPlayer();
        System.out.println("1. Pick and remember a number between 1 and 10");
        waitForPlayer();
        System.out.println("2. Multiply this number by 2");
        waitForPlayer();
        System.out.println("3. Multiply this number by 5.");
        waitForPlayer();
        System.out.println("4. Divide the current number by your original number");
        waitForPlayer();
        System.out.println("5. Subtract 7 from your current number");
        waitForPlayer();
        System.out.println("The number you have in mind at this moment is 3");
        System.out.println();
        System.out.println("Welcome to Guessing Game 2. I will guess the number you are thinking of.");
        waitForPlayer();
        System.out.println("1. Pick and remember a number between 1 and 10");
        waitForPlayer();
        System.out.println("2. Multiply this number by 2");
        waitForPlayer();
        System.out.print("3. Add ");
        double rand = (int) (Math.random() * 10) + 1;
        System.out.println(rand +" to this number");
        waitForPlayer();
        System.out.println("4. Divide this number by two");
        waitForPlayer();
        System.out.println("5. Subtract the current number by your original number");
        waitForPlayer();
        if (rand%2==0) {
            System.out.print("The number you have in mind at this moment is " + (rand / 2));
            System.out.println();
        }
        if (rand%2==1) {
            System.out.print("The number you have in mind at this moment is " + ((rand / 2)-0.5));
            System.out.println();
        }
        System.out.println();
        System.out.println("Welcome to Guessing Game 3. I will guess the number you are thinking of.");
        waitForPlayer();
        System.out.println("1. Pick and remember a number between 1 and 10");
        waitForPlayer();
        System.out.println("2. Multiply this number by 9");
        waitForPlayer();
        System.out.println("3. Add the numbers of the current number together");
        waitForPlayer();
        System.out.println("4. Add 4 to the current number");
        waitForPlayer();
        System.out.println("5. The number you are thinking of is 13");
        waitForPlayer();


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
