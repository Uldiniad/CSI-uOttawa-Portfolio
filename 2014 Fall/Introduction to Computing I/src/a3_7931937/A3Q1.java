import java.util.Arrays;
import java.util.Scanner;
class A3Q1
{
    public static void main(String[] args)
    {
        Scanner user_input = new Scanner(System.in);
        System.out.println("This program will find the median. First, enter the amount of numbers to verify");
        int length=user_input.nextInt();
        int[] median=new int[length];
        System.out.println("Now, enter the numbers one by one");
        for (int number=0;number<median.length;number++)
        {
            median[number]=user_input.nextInt();
        }
        System.out.println(median(median) + " is the median of the following entered numbers:");
        for (int number=0;number<median.length;number++)
        {
            System.out.print(median[number] + "|");
        }
    }
    public static int median(int[] median)
    {
        for (int i = 1; i < median.length; i++){
            int j = i;
            int temp = median[i];
            while ((j > 0) && (median[j-1] > temp)){
                median[j] = median[j-1];
                j--;
            }
            median[j] = temp;
        }
        return (median[(median.length/2)]);
    }
}
