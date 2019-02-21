import java.util.Scanner;
public class A2Q_3 {
    public static void main(String[] args) {
/*
==================================================
Question 3
==================================================
*/
        // Step 1: Declare variables
        Scanner user_input = new Scanner(System.in);
        System.out.println("Lets see if you need an emission test. Enter your car's model year");
        int modelYear=user_input.nextInt();
        System.out.println("Enter the current year");
        int year=user_input.nextInt();
        // Step 3: Display result
        boolean test=test_needed(modelYear, year);
        if (test)
        {
            System.out.println("An emission test is needed");
        }
        else
        {
            System.out.println("An emission test is not needed");
        }
    }
    // Step 2: Verify status
    public static boolean test_needed(int modelYear, int year)
    {
        return ((((modelYear % 2) == 1) && ((year % 2) == 0)) || (((modelYear % 2) == 0) && ((year % 2) == 1))) && ((year - modelYear) >= 3) && ((year - modelYear) <= 20);
    }
}