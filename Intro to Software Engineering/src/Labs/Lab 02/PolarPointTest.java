import java.io.IOException;
import java.util.concurrent.ThreadLocalRandom;

public class PolarPointTest {
    public static void main(String[] args) {
        PolarPoint polarPoint;
        try {
            polarPoint = new PolarPoint(Double.valueOf(args[0]), Double.valueOf(args[1]));
        } catch (Exception e) {
            System.out.println("Invalid arguments on command line");
            System.out.println();
            try {
                polarPoint = getInput();
            } catch (IOException ex) {
                System.out.println("Error getting input. Ending program.");
                return;
            }
        }
        System.out.println();
        System.out.println("You entered: " + polarPoint);
        System.out.println();
        System.out.println("Polar X: " + polarPoint.getX());
        System.out.println("Polar Y: " + polarPoint.getY());
        System.out.println();
        int degrees;
        System.out.println("Distance between the origin point and a point rotated a random number of degrees from it: "
                + polarPoint.getDistance(polarPoint.rotatePoint(degrees = ThreadLocalRandom.current().nextInt(0,361)))); //Test both distance and rotate methods
        System.out.println("Number of degrees the point was rotated: " + degrees);
        System.out.println("Convert to Polar: " + polarPoint.convertStorageToPolar());
        System.out.println("Convert to Cartesian: " + polarPoint.convertStorageToCartesian());
        // I am not explicitly testing toString, getRho, getTheta since they are invoked implicitly in the cases above.
    }

    /**
     * This method obtains input from the user and verifies that
     * it is valid.  When the input is valid, it returns a PointCP
     * object.
     *
     * @return A PointCP constructed using information obtained
     * from the user.
     * @throws IOException If there is an error getting input from
     *                     the user.
     */
    private static PolarPoint getInput() throws IOException {
        byte[] buffer = new byte[1024];  //Buffer to hold byte input
        boolean isOK = false;  // Flag set if input correct
        String theInput = "";  // Input information

        //Information to be passed to the constructor
        double a = 0.0;
        double b = 0.0;

        for (int i = 0; i < 2; i++) {
            while (!(isOK)) {
                isOK = true;  //flag set to true assuming input will be valid
                if (i == 0)
                    System.out.println("Enter the value of Rho");
                else
                    System.out.println("Enter the value of Theta");
                // Initialize the buffer before we read the input
                for (int k = 0; k < 1024; k++)
                    buffer[k] = '\u0020';

                System.in.read(buffer);
                theInput = new String(buffer).trim();

                // Verify the user's input
                try {
                    // Second and third arguments
                    //Convert the input to double values
                    if (i == 0)
                        a = Double.valueOf(theInput);
                    else
                        b = Double.valueOf(theInput);
                } catch (Exception e) {
                    System.out.println("Incorrect input");
                    isOK = false;  //Reset flag as so not to end while loop
                }
            }
            //Reset flag so while loop will prompt for other arguments
            isOK = false;
        }
        return (new PolarPoint(a, b));
    }
}
