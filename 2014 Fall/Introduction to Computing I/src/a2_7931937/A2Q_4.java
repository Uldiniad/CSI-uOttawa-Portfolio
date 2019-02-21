import java.util.Scanner;
public class A2Q_4 {
    public static void main(String[] args) {
/*
==================================================
Question 4
==================================================
*/
        // Step 1: Declare variables
        Scanner user_input = new Scanner(System.in);
        System.out.println("Enter a positive integer. 1/(n*n) will be computed");
        double n = user_input.nextInt();
        // Step 3: Display result
        System.out.println(compute_series(n));
    }
        // Step 2: Compute serie
    public static double compute_series(double n){
        double i=1;
        double sum=0;
        while (i<=n)
        {
            sum = sum + (1/(i*i));
            i++;
        }
        return sum;
    }
}
