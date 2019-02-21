package a5_7931937;

import a5_7931937.Canvas;
import a5_7931937.Rectangle;
import junit.framework.Assert;
import junit.framework.TestCase;

public class CanvasTest extends TestCase
{
  public void testInitializeAdd( )
  {
   Canvas C1 = new Canvas(3);
   Rectangle r1 = new Rectangle(20, 30, 40, 50, "red");
   Rectangle r2 = new Rectangle(30, 50, 50, 70, "green");
   Rectangle r3 = new Rectangle(10, 10, 30, 60, "green");
   Rectangle r4 = new Rectangle(25, 25, 30, 45, "brown");
   C1.add(r1);   C1.add(r2);
   C1.add(r3);   C1.add(r4);
   int expected = 3;
   int returned = C1.getNumRectangles();
   Assert.assertEquals( expected, returned );
  }
 
  public void testCountForColour1( )
   { 
   Canvas C1 = new Canvas(3);
   Rectangle r1 = new Rectangle(20, 30, 40, 50, "red");
   Rectangle r2 = new Rectangle(30, 50, 50, 70, "green");
   Rectangle r3 = new Rectangle(10, 10, 30, 60, "green");
   C1.add(r1);   C1.add(r2);
   C1.add(r3);   
    int expected = 2;
    int returned = C1.countRectanglesForColour("green");
    Assert.assertEquals( expected, returned );
  }
 
  public void testCountForColour2( )
   { 
   Canvas C1 = new Canvas(3);
   Rectangle r1 = new Rectangle(20, 30, 40, 50, "red");
   Rectangle r2 = new Rectangle(30, 50, 50, 70, "green");
   Rectangle r3 = new Rectangle(10, 10, 30, 60, "green");
   C1.add(r1);   C1.add(r2);
   C1.add(r3);  
    int expected = 1;
    int returned = C1.countRectanglesForColour("red");
    Assert.assertEquals( expected, returned );
  }
  
  public void testCountForColour3( )
   { 
   Canvas C1 = new Canvas(3);
   Rectangle r1 = new Rectangle(20, 30, 40, 50, "red");
   Rectangle r2 = new Rectangle(30, 50, 50, 70, "green");
   Rectangle r3 = new Rectangle(10, 10, 30, 60, "green");
   Rectangle r4 = new Rectangle(25, 25, 30, 45, "brown");
   C1.add(r1);   C1.add(r2);
   C1.add(r3);   C1.add(r4);
    int expected = 0;
    int returned = C1.countRectanglesForColour("brown");
    Assert.assertEquals( expected, returned );
  }
  public void testTotalPerimeter( )
   { 
   Canvas C1 = new Canvas(3);
   Rectangle r1 = new Rectangle(20, 30, 40, 50, "red");
   Rectangle r2 = new Rectangle(30, 50, 50, 70, "green");
   Rectangle r3 = new Rectangle(10, 10, 30, 60, "green");
   C1.add(r1);   C1.add(r2);
   C1.add(r3);   
    int expected = 300;
    int returned = C1.totalPerimeter();
    Assert.assertEquals( expected, returned );
  }
  
   public void testMinEnclosing( )
   { 
    Canvas C1 = new Canvas(3);
    Rectangle r1 = new Rectangle(20, 30, 40, 50, "red");
    Rectangle r2 = new Rectangle(30, 50, 50, 70, "green");
    Rectangle r3 = new Rectangle(10, 10, 30, 60, "green");
    C1.add(r1);   
    C1.add(r2);
    C1.add(r3);   
    int expected = 10;
    Rectangle returned = C1.minEnclosingRectangle();
    Assert.assertEquals( expected, returned.getX1() );
    expected = 10;
    Assert.assertEquals( expected, returned.getY1() );
    expected = 50;
    Assert.assertEquals( expected, returned.getX2() );
    expected = 70;
    Assert.assertEquals( expected, returned.getY2() );
  }
  
    public void testIntersect2_1( )
    { 
      Rectangle r1 = new Rectangle(20,20,40,40, "red");
      Rectangle r2 = new Rectangle(30,25,60,70, "black");
      boolean returned = Canvas.intersect2(r1,r2); 
      boolean expected = true;
      Assert.assertEquals( expected, returned );
    }
    public void testIntersect2_2( )
    { 
      Rectangle r1 = new Rectangle(20,20,40,40, "red");
      Rectangle r2 = new Rectangle(50,50,60,70, "black");
      boolean returned = Canvas.intersect2(r1,r2); 
      boolean expected = false;
      Assert.assertEquals( expected, returned );
    } 
    public void testIntersect2_3( )
    { 
      Rectangle r1 = new Rectangle(20,20,40,40, "red");
      Rectangle r2 = new Rectangle(10,25,20,30, "black");
      boolean returned = Canvas.intersect2(r2,r1); 
      boolean expected = true;
      Assert.assertEquals( expected, returned );
    }
    
    public void testIntersect2_4( )
    { 
      Rectangle r1 = new Rectangle(20,20,40,40, "red");
      Rectangle r2 = new Rectangle(20,25,20,25, "black");
      boolean returned = Canvas.intersect2(r2,r1); 
      boolean expected = true;
      Assert.assertEquals( expected, returned );
    }
     public void testIntersectAll( )
    { 
      Canvas C1 = new Canvas(3);
      Rectangle r1 = new Rectangle(20, 30, 40, 50, "red");
      Rectangle r2 = new Rectangle(30, 50, 50, 70, "green");
      Rectangle r3 = new Rectangle(10, 10, 30, 60, "green");
      C1.add(r1);   C1.add(r2);
      C1.add(r3);   
      boolean returned = C1.intersectAll(); 
      boolean expected = true;
      Assert.assertEquals( expected, returned );
    }
}
