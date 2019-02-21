import a5_7931937.Canvas;
import a5_7931937.Rectangle;

import java.io.* ;
import java.util.Scanner; 

class A5Q2 
{ 
  public static void main (String args[ ]) 
  { 
    // Test Rectangle  
    Rectangle r1 = new Rectangle(10, 20, 50, 60, "red");
    Rectangle r2 = new Rectangle (30, 40, 60, 60, "green");
    
    r1.print();
    r2.print();
    
    r1.setColour("blue");
    r1.move(20, 30);
    
    System.out.println("After moving: ");
    r1.print();
    
    System.out.print("r2 contains the point (50,50): ");
    System.out.println(r2.contains(50,50));
    System.out.print("r2 contains the point 50,100: ");
    System.out.println(r2.contains(50,100));
    System.out.println();
     
    //Comment out the next part till the end if you did not implement the class Canvas yet
    // Test Canvas
    Rectangle r3 = new Rectangle (10, 10, 30, 30, "yellow");
    Rectangle r4 = new Rectangle (20, 10, 50, 50, "yellow");
    Rectangle r5 = new Rectangle (30, 30, 40, 60, "red");
    
    Canvas C1=  new Canvas(4);
    C1.add(r1); 
    C1.add(r2); 
    C1.add(r3); 
    C1.add(r4); 
    C1.add(r5);
    C1.printAll();
    System.out.println("There are " + C1.countRectanglesForColour("yellow") +" yellow rectangles.");
    
    System.out.println("The total perimeter is " + C1.totalPerimeter());
    
    System.out.println("The minimum enclosing rectangle is: ");
    C1.minEnclosingRectangle().print();
   
 }  
}