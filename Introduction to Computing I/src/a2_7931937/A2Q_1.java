import java.util.Scanner;
public class A2Q_1 {
    public static void main(String[] args) {
/*
==================================================
Question 1
==================================================
*/
        // Step 1: Declare variables and user input
        Scanner user_input = new Scanner(System.in);
        System.out.println("Enter three positive integers. Do they form a triangle?");
        int s1=user_input.nextInt();
        int s2=user_input.nextInt();
        int s3=user_input.nextInt();
        // Step 3: Display result
        boolean triangle = isTriangle(s1, s2, s3);
        if (triangle){
            System.out.println("The three lengths determine a triangle");
        }
        else {
            System.out.println("There is no triangle whose sides have length " + s1 + ", " + s2 + " and " + s3);
        }
    }
    // Step 2: Triangle inequality
    public static boolean isTriangle(int sa, int sb, int sc){
        return (sa <= (sb + sc)) && (sb <= (sa + sc)) && (sc <= (sa + sb));
    }

}
