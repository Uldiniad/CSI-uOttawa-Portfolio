// Scott, Oliver
// Student Number: 7931937
// Course: ITI1120
// Assignment Number 1
import java.io.* ; //unused???
import java.util.Scanner;
class a1_7931937
{
  public static void main (String args[])
  {
    /* ==========
     * Question 1
       ========== */
      // Step 1: User input
      Scanner user_input = new Scanner (System.in);
      System.out.println("\n Question 1: Enter a temperature in fahrenheit");
      double fahrenheit = user_input.nextDouble();
      // Step 2: Compute conversion
      double kelvin=(5*(fahrenheit-32)/9)+273.15;
      // Step 3: Display result
      System.out.println(fahrenheit + " degrees Fahrenheit is (approximately) equivalent to " + kelvin + " degrees kelvin");
         
     /* ==========
      * Question 2
      * ========== */
      // Step 1: User input
      System.out.println("\n Question 2: Enter a mass in pounds");
      int pounds = user_input.nextInt();
      System.out.println("and ounces");
      int ounces = user_input.nextInt();
      // Step 2: Clear scanner
      user_input.nextLine();
      // Step 3: Compute conversion
      double kilograms=(pounds/2.2046)+(ounces*0.02835);
      // Step 4: Display result
      System.out.println(pounds + " pounds and " + ounces + " ounces is (approximately) equivalent to " + kilograms + " kilograms");
      
     /* ===========
      * Question 3
      * =========== */
      System.out.println("\n Question 3: Give me a quote");
      String quote = user_input.nextLine();
      System.out.println("Who said that?");
      String person = user_input.nextLine();
      System.out.println("What year did he say that?");
      String year = user_input.nextLine();
      System.out.println("In " + year + ", a person called " + person + " said: " + '"' + quote + '"');
      
      /* ===========
       * Question 4
       * =========== */
      // Step 1: User input
      System.out.println("\n Question 4: Enter a positive integer");
      int n = user_input.nextInt();
      // Step 2: Compute equation
      int equation=((n*(n+1))/2);
      // Step 3: Display results
      System.out.println("The sum of all the positive integers up to " + n + " gives " + equation);
      
      /* ===========
       * Question 5
       * =========== */
      System.out.println("\n Question 5: Enter three characters to make your ASCII art (I recommend o.o)");
      char a = user_input.next().charAt(0);
      char b = user_input.next().charAt(0);
      char c = user_input.next().charAt(0);
      System.out.println("(_)(_)");
      System.out.println("("+ a + b + c +")");
      System.out.println("(')(')");
      
      /* ===========
       * Question 6
       * =========== */
      // Step 1: User input (and define variables)
      System.out.println("\n Question 6: Enter an uppercase letter");
      char uppercase = user_input.next().charAt(0);
      // Step 3: Convert to lowercase
      char lowercase = (char)((int)uppercase + 32);
      // Step 4: Display result
      System.out.println(lowercase + " is the lowercase of the uppercase letter you entered");
      
      /* ==========
       * Question 7
       * ========== */      
      // Step 1: User input
      System.out.println("\n Question 7: Enter a positive number (it will be represented like this: x=y+(z/12)");
      double x = user_input.nextDouble();
      int y = (int)x;
      double z;
      // Step 2: Compute conversion
      z = (12*(x - y));
      // Step 3: Display result
      System.out.println(y + ","+ z);
      
     /* ==========
      * Question 8
      * ========== */
      // Step 1: User input
      System.out.println("\n Question 8: Enter three integers and I will find the median");
      int u = user_input.nextInt();
      int v = user_input.nextInt();
      int w = user_input.nextInt();   
      /// Step 2: Compute median
      boolean u1, v1, w1;
      u1=((v<=u)&&(u<=w)||(w<=u)&&(u<=v));
      v1=((u<=v)&&(v<=w)||(w<=v)&&(v<=u));
      w1=((u<=w)&&(w<=v)||(v<=w)&&(w<=u));
      System.out.println("It is " + u1 + " that " + u + " is the median");
      System.out.println("It is " + v1 + " that " + v + " is the median");
      System.out.println("It is " + w1 + " that " + w + " is the median");
      
     /* ==========
      * Question 9
      * ========== */
      // Step 1: User input
      System.out.println("\n Question 9: Enter two numbers. The first number is a coordinate x and the second is a coordinate y. \n These coordinates correspond to the position of the bottom left corner of the square.");
      double ax = user_input.nextDouble();
      double ay = user_input.nextDouble();
      System.out.println("Now, enter the length of the side of the square");
      double length = user_input.nextDouble();
      System.out.println("And, finally enter two other numbers. The first number is a coordinate x and the second is a coordinate y. \n These are the coordinates of a random point (that will be verified to see if it is in the square)");
      double ex = user_input.nextDouble();
      double ey = user_input.nextDouble();
      // Step 2: Compute data (determining the coordinates of all the points of the square and creating triangles between the sides and the point, then calculating the sum of the area of these triangles (base*height)/2 for the four triangles. If the sum is equal to the area of the square then the point is in the square. The reverse is false.
      double bx = ax + length; // = dx
      double by = ay; // redundant but useful for understanding
      double cx = ax; // redundant but useful for understanding
      double cy = ay + length; // = dy
      double areaOfSquare = length*length;
      double areaAEB = (Math.abs(length*(ey-by))/2);
      double areaAEC = (Math.abs(length*(ex-cx))/2);
      double areaBED = (Math.abs(length*(bx-ex))/2);
      double areaCED = (Math.abs(length*(cy-ey))/2);
      double sumAreas = areaAEB + areaAEC + areaBED + areaCED;
      boolean point = sumAreas==areaOfSquare;
      System.out.println("It is " + point + " that the point you entered is in the boundaries of the square");
      
     /* ==========
      * Question 10
      * ========== */
      // Step 1: User input
      System.out.println("\n Question 10: Enter the amount due");
      double due = user_input.nextDouble();
      double change = due*100;
      int quarters = (int)change/25;
      double remainder = change%25;
      int dimes = (int)remainder/10;
      double remainder1 = remainder%10;
      int nickels = (int)remainder1/5;
      int pennies = (int)remainder1%5;
      int coins = quarters + dimes + nickels + pennies;
      System.out.println("The minimum amount of coins (using quarters, dimes, nickels and pennies) we can give back is " + coins);
  }}
