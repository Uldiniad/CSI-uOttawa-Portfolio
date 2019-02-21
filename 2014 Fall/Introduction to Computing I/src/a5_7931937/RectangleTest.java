package a5_7931937;

import junit.framework.Assert;
import junit.framework.TestCase;

public class RectangleTest extends TestCase
{
  public void testGetX1( )
  {
   Rectangle r = new Rectangle(20, 30, 40, 50, "red");
   int expected = 20;
   int returned = r.getX1( );
   Assert.assertEquals( expected, returned );
  }
  
  public void testGetY1( )
  {
   Rectangle r = new Rectangle(20, 30, 40, 50, "red");
   int expected = 30;
   int returned = r.getY1( );
   Assert.assertEquals( expected, returned );
  }
  
  public void testGetX2( )
  {
   Rectangle r = new Rectangle(20, 30, 40, 50, "red");
   int expected = 40;
   int returned = r.getX2( );
   Assert.assertEquals( expected, returned );
  }
  public void testGetY2( )
  {
   Rectangle r = new Rectangle(20, 30, 40, 50, "red");
   int expected = 50;
   int returned = r.getY2( );
   Assert.assertEquals( expected, returned );
  }
  public void testGetColour( )
  {
   Rectangle r = new Rectangle(20, 20, 40, 40, "red");
   String expected = "red";
   String returned = r.getColour( );
   Assert.assertEquals( expected, returned );
  }

  public void testSetColour( )
  {
    Rectangle r = new Rectangle(20, 20, 40, 40, "red");
    
    String expected = "red";
    String returned = r.getColour();  
    Assert.assertEquals(expected, returned);
    
    r.setColour("pink");
    
    expected = "pink";
    returned = r.getColour();  
    Assert.assertEquals(expected, returned);
  }
  public void testMove( )
  {
   Rectangle r = new Rectangle(20, 30, 40, 50, "red");
   r.move(10,5);
   Assert.assertEquals(10, r.getX1());
   Assert.assertEquals(5, r.getY1());
   Assert.assertEquals(30, r.getX2());
   Assert.assertEquals(25, r.getY2());
  }
  public void testGetArea1( )
  {
   Rectangle r = new Rectangle(20, 30, 40, 40, "red");
   int expected = 200;
   int returned = r.getArea( );
   Assert.assertEquals( expected, returned );
  }
  public void testGetArea2( )
  {
   Rectangle r = new Rectangle(20, 30, 20, 35, "red");
   int expected = 0;
   int returned = r.getArea( );
   Assert.assertEquals( expected, returned );
  }
  
  public void testGetPerimenter1( )
  {
   Rectangle r = new Rectangle(20, 30, 40, 40, "red");
   int expected = 60;
   int returned = r.getPerimeter( );
   Assert.assertEquals( expected, returned );
  }
  
   public void testGetPerimenter2( )
  {
   Rectangle r = new Rectangle(-20, -20, -10, -10, "red");
   int expected = 40;
   int returned = r.getPerimeter( );
   Assert.assertEquals( expected, returned );
  }
  
  public void testGetPerimenter3( )
  {
   Rectangle r = new Rectangle(-20, -20, -20, -20, "red");
   int expected = 0;
   int returned = r.getPerimeter( );
   Assert.assertEquals( expected, returned );
  }
    
  public void testContains1( )
  {
   Rectangle r = new Rectangle(20, 30, 40, 40, "red");
   boolean expected = true;
   boolean returned = r.contains( 30, 35);
   Assert.assertEquals( expected, returned );
  }
   public void testContains2( )
  {
   Rectangle r = new Rectangle(20, 30, 40, 40, "red");
   boolean expected = false;
   boolean returned = r.contains( 10, 60);
   Assert.assertEquals( expected, returned );
  }
    public void testContains3( )
  {
   Rectangle r = new Rectangle(20, 30, 40, 40, "red");
   boolean expected = false;
   boolean returned = r.contains( 30, 60);
   Assert.assertEquals( expected, returned );
  }
    public void testContains4( )
  {
   Rectangle r = new Rectangle(20, 30, 40, 40, "red");
   boolean expected = true;
   boolean returned = r.contains( 20, 35);
   Assert.assertEquals( expected, returned );
  }
     public void testContains5( )
  {
   Rectangle r = new Rectangle(20, 30, 40, 40, "red");
   boolean expected = false;
   boolean returned = r.contains( 100, 30);
   Assert.assertEquals( expected, returned );
  }
}
