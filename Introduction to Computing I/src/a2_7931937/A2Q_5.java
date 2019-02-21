import java.util.Scanner;
public class A2Q_5 {
    public static void main(String[] args) {
/*
==================================================
Question 5
==================================================
*/
        // Step 1: Declare variables
        Scanner user_input = new Scanner(System.in);
        System.out.println("Enter a positive integer");
        int length = user_input.nextInt();
        //Step 3: Display result
        System.out.println(draw_rectangle(length));
    }
        // Step 2: Draw rectangle
    public static String draw_rectangle(int length)
    {
        int i=1;
        String rectangle="";
        while (i<=length)
        {
            rectangle=rectangle+"*";
            i++;
        }
        rectangle=rectangle+("\n*");
        int j=2;
        while (j <= (length - 1))
        {
            rectangle = rectangle + " ";
            j++;
        }
        rectangle=rectangle+"*\n";
        int k=1;
        while (k<=length)
        {
            rectangle=rectangle+("*");
            k++;
        }
        return rectangle;
}
}