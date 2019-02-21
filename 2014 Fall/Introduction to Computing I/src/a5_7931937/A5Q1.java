package a5_7931937;
import java.util.Scanner;
public class A5Q1 {
    public static void main(String[] args) {
        Scanner user_input = new Scanner(System.in);
        System.out.println("Enter a positive integer");
        int n = user_input.nextInt();
        System.out.println("The sum of all the digits in the entered integer is "+digitSum(n));
        System.out.println("The digital root of the entered integer is "+digitalRoot(n));
    }
    public static int digitSum(int n){
        if (n < 10)
            return n;
        else
            return n % 10 + digitSum(n / 10);
    }
    public static int digitalRoot(int n){
        if (n<10)
            return n;
        else
            return digitalRoot(digitSum(n));
    }
}
