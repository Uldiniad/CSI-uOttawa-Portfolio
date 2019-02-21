import a5_7931937.A5Q1;
import junit.framework.Assert;
import junit.framework.TestCase;

public class A5Q1Test extends TestCase
{
  public void testDigitSum1( )
  {
    int returned = A5Q1.digitSum(1250);
    int expected = 8;
    Assert.assertEquals(expected, returned );
  }
  public void testDigitSum2( )
  {
    int returned = A5Q1.digitSum(35278);
    int expected = 25;
    Assert.assertEquals(expected, returned );
  }
  public void testDigitalRoot1( )
  {
    int returned = A5Q1.digitalRoot(1969);
    int expected = 7;
    Assert.assertEquals(expected, returned );
  }
  public void testDigitalRoot2( )
  {
    int returned = A5Q1.digitalRoot(196987); //1+9+6+9+8+7=40
    int expected = 4;
    Assert.assertEquals(expected, returned );
  }
  public void testDigitalRoot3( )
  {
    int returned = A5Q1.digitalRoot(19); 
    int expected = 1;
    Assert.assertEquals(expected, returned );
  }
}

