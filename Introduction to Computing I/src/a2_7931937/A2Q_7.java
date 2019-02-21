import java.util.Scanner;
public class A2Q_7 {
    public static void main(String[] args) {
/*
==================================================
Question 7
==================================================
*/
        // Step 1: Declare variables
        Scanner user_input = new Scanner(System.in);
        int level, guesses, random, game;
        guesses=0;//initialize variable since it doesn't compile otherwise
        boolean choice = false; // the choice hasn't been made yet
        System.out.println("Enter choice 1, 2 or 3");
        while(!choice)// while no choice has been made
        {
            System.out.println("1. Easy (between 20 and 30 guesses)");
            System.out.println("2. Medium (between 10 and 15 guesses)");
            System.out.println("3. Hard (between 1 and 5 guesses)");
                level = user_input.nextInt();
                if (level==1)
                {
                    guesses = (int) (Math.random() * 11) + 20;
                    choice=true;// choice has been made
                }
                else if (level==2)
                {
                    guesses = (int) (Math.random() * 6) + 10;
                    choice=true;// choice has been made
                }
                else if (level==3)
                {
                    guesses = (int)(Math.random()*5)+1;
                    choice=true;// choice has been made
                }
                else
                {
                    System.out.println("Incorrect choice. Enter choice 1,2 or 3");
                }
        }
        random = ((int) (Math.random() * 100)) + 1;
        game=guess(guesses, random);
        if (game==-1)
        {
            System.out.println("GAME OVER. The secret number is "+ random);
        }
        else
        {
            System.out.println("You WIN in " + game + " guesses. The secret number is " + random);
        }
        user_input.close();//close scanner
        }

    public static int guess(int guesses, int random) {
        Scanner user_input = new Scanner(System.in); //new scanner
        {
            int guessesLeft = guesses; //At the beginning, the number of guesses left is the same as the total number of allowed guesses.
            while (guessesLeft > 0) {//While the player hasn't run out of guesses
                guessesLeft--; //use a guess
                System.out.println("Guess " + (guesses - guessesLeft) + " of " + guesses);//Say what guess we're at
                    int guessNum = user_input.nextInt();//The guessed number input by the user.
                    if (guessNum > 100 || guessNum < 0) {//verify if the number is within the range
                        System.out.println("The number is not within the range 0-100");
                        guessesLeft++;//restore guess if invalid input
                    }
                    else if (guessNum==random)
                    {
                        int guessesTotal = (guesses - guessesLeft);//win in how many guesses?
                        return guessesTotal;
                    }
                    else if (guessNum<random)
                    {
                        System.out.println("< Your guess is too low");
                    }
                    else if (guessNum>random)
                    {
                        System.out.println("> Your guess is too high");
                    }
                }
            System.out.println("You have run out of guesses");
            return -1;// lose
        }
    }
}