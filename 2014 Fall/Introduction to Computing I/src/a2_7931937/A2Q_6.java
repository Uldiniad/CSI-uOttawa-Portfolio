import java.util.Scanner;
public class A2Q_6 {
    public static void main(String[] args) {
/*
==================================================
Question 6
==================================================
*/
        // Step 1: Declare variables
        Scanner user_input = new Scanner(System.in);
        System.out.println("Enter a positive integer");
        int m=user_input.nextInt();
        // Step 3: Display result
        System.out.println(draw_tree(m));
    }
    // Step 2: Draw tree
    public static String draw_tree(int m) {
        int x=1;
        String tree = "";
        while (x<=m){
            int y=1;
            while(y<=m-x){
                tree=tree + " ";
                y++;
            }
            y = 1;
            while(y<=(x+x)-1){
                tree=tree + "*";
                y++;
            }
            y=1;
            while(y<=m-x){
                tree=tree + " ";
                y++;
            }
            tree=tree+ "\n";
            x++;
        }
        x=1;
        while (x<=2) {
            int y=1;
            while(y<=m-1)
            {
                tree=tree+" ";
                y++;
            }
            tree=tree+"*";
            y=1;
            while (y<=m-1)
            {
                tree=tree+" ";
                y++;
            }
            tree=tree+"\n";
            x++;
        }
        return tree;
    }
}