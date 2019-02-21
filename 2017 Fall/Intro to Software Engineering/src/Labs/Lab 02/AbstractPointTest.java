import java.io.IOException;
import java.util.concurrent.ThreadLocalRandom;

public class AbstractPointTest {
    public static void main(String[] args) {
        AbstractPoint point = null;
        try {
            point = getInput();
        } catch (IOException ex) {
            System.out.println("Error getting input. Ending program.");
        }
        System.out.println("\nYou entered:\n" + point);
        System.out.println();
        System.out.println("Rho: " + point.getRho());
        System.out.println("Theta: " + point.getTheta());
        System.out.println("X: " + point.getX());
        System.out.println("Y: " + point.getY());
        System.out.println();
        int degrees;
        System.out.println("Distance between the origin point and a point rotated a random number of degrees from it: "
                + point.getDistance(point.rotatePoint(degrees = ThreadLocalRandom.current().nextInt(0,361)))); //Test both getDistance and rotate methods
        System.out.println("Number of degrees the point was rotated: " + degrees);
        System.out.println("Convert to Polar: " + point.convertStorageToPolar());
        System.out.println("Convert to Cartesian: " + point.convertStorageToCartesian());
        // I am not explicitly testing toString since it is done automatically in the cases above.
    }

    private static AbstractPoint getInput() throws IOException {
        byte[] buffer = new byte[1024];  //Buffer to hold byte input
        boolean isOK = false;  // Flag set if input correct
        String theInput = "";  // Input information

        //Information to be passed to the constructor
        char coordType = 'A'; // Temporary default, to be set to P or C
        double a = 0.0;
        double b = 0.0;

        // Allow the user to enter the three different arguments
        for (int i = 0; i < 3; i++) {
            while (!(isOK)) {
                isOK = true;  //flag set to true assuming input will be valid

                // Prompt the user
                if (i == 0) // First argument - type of coordinates
                {
                    System.out.print("Enter the type of Coordinates you "
                            + "are inputting ((C)artesian / (P)olar): ");
                } else // Second and third arguments
                {
                    System.out.print("Enter the value of "
                            + (coordType == 'C'
                            ? (i == 1 ? "X " : "Y ")
                            : (i == 1 ? "Rho " : "Theta "))
                            + "using a decimal point(.): ");
                }

                // Get the user's input      

                // Initialize the buffer before we read the input
                for (int k = 0; k < 1024; k++)
                    buffer[k] = '\u0020';

                System.in.read(buffer);
                theInput = new String(buffer).trim();

                // Verify the user's input
                try {
                    if (i == 0) // First argument -- type of coordinates
                    {
                        if (!((theInput.toUpperCase().charAt(0) == 'C')
                                || (theInput.toUpperCase().charAt(0) == 'P'))) {
                            //Invalid input, reset flag so user is prompted again
                            isOK = false;
                        } else {
                            coordType = theInput.toUpperCase().charAt(0);
                        }
                    } else  // Second and third arguments
                    {
                        //Convert the input to double values
                        if (i == 1)
                            a = Double.valueOf(theInput);
                        else
                            b = Double.valueOf(theInput);
                    }
                } catch (Exception e) {
                    System.out.println("Incorrect input");
                    isOK = false;  //Reset flag as so not to end while loop
                }
            }

            //Reset flag so while loop will prompt for other arguments
            isOK = false;
        }
        //Return a new AbstractPoint object
        if (coordType == 'C') {
            return (new CartesianPoint(a, b));
        } else if (coordType == 'P') {
            return (new PolarPoint(a, b));
        }
        return null;
    }
}
