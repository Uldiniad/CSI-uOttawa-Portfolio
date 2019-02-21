import java.util.Scanner;
public class A2Q_2 {
    public static void main(String[] args)
    {
/*
==================================================
Question 2
==================================================
*/
        // Step 1: Declare variables
        Scanner user_input = new Scanner(System.in);
        System.out.println("Enter an integer between 1 and 99");
        int x = user_input.nextInt();
        // Step 3: Display result
        boolean safe = isSafe(x);
        if (safe)
        {
            System.out.println("The number is safe (the number doesn't contain a 9 nor is divisible by 9)");
        }
        else
        {
            System.out.println("The number is not safe (the number contains a 9 or is divisible by 9)");
        }
    }
    // Step 2: Verify status
    public static boolean isSafe(int x)
    {
        return !((x%9==0)||(x/10==9)||(x%10==9));
    }
}