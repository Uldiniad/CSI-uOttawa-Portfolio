import java.util.Arrays;

public class Performance_Analysis {
    public static void main(String[] args) {
        final int iterations = 10000000;
        PolarPoint polarPoint = null;
        CartesianPoint cartesianPoint = null;
        AbstractPoint abstractCartesianPoint = null;
        AbstractPoint abstractPolarPoint = null;

        long startTime = System.nanoTime() / 1000;

        for (int i = 0; i < iterations; i++) {
            polarPoint = new PolarPoint(1, 90);
            polarPoint.getX();
            polarPoint.getY();
            polarPoint.getDistance(polarPoint);
            polarPoint.getRho();
            polarPoint.getTheta();
            polarPoint.rotatePoint(90);
            polarPoint.convertStorageToCartesian();
            polarPoint.convertStorageToPolar();
            polarPoint.toString();
        }

        long endTime = System.nanoTime() / 1000;

        long totalTime = endTime - startTime;

        System.out.println("Total time taken for design 2: " + totalTime + " microseconds");

        startTime = System.nanoTime() / 1000;

        for (int i = 0; i < iterations; i++) {
            cartesianPoint = new CartesianPoint(1, 1);
            cartesianPoint.getX();
            cartesianPoint.getY();
            cartesianPoint.getDistance(cartesianPoint);
            cartesianPoint.getRho();
            cartesianPoint.getTheta();
            cartesianPoint.rotatePoint(90);
            cartesianPoint.convertStorageToCartesian();
            cartesianPoint.convertStorageToPolar();
            cartesianPoint.toString();
        }

        endTime = System.nanoTime() / 1000;

        totalTime = endTime - startTime;

        System.out.println("Total time taken for design 3: " + totalTime + " microseconds");

        startTime = System.nanoTime() / 1000;

        for (int i = 0; i < iterations; i++) {
            abstractCartesianPoint = new CartesianPoint(1, 1);
            abstractCartesianPoint.getX();
            abstractCartesianPoint.getY();
            abstractCartesianPoint.getDistance(abstractCartesianPoint);
            abstractCartesianPoint.getRho();
            abstractCartesianPoint.getTheta();
            abstractCartesianPoint.rotatePoint(90);
            abstractCartesianPoint.convertStorageToCartesian();
            abstractCartesianPoint.convertStorageToPolar();
            abstractCartesianPoint.toString();
        }

        endTime = System.nanoTime() / 1000;

        totalTime = endTime - startTime;

        System.out.println("Total time taken for design 5 (cartesian): " + totalTime + " microseconds");

        startTime = System.nanoTime() / 1000;

        for (int i = 0; i < iterations; i++) {
            abstractPolarPoint = new PolarPoint(1, 90);
            abstractPolarPoint.getX();
            abstractPolarPoint.getY();
            abstractPolarPoint.getDistance(abstractPolarPoint);
            abstractPolarPoint.getRho();
            abstractPolarPoint.getTheta();
            abstractPolarPoint.rotatePoint(90);
            abstractPolarPoint.convertStorageToCartesian();
            abstractPolarPoint.convertStorageToPolar();
            abstractPolarPoint.toString();
        }

        endTime = System.nanoTime() / 1000;

        totalTime = endTime - startTime;

        System.out.println("Total time taken for design 5 (polar): " + totalTime + " microseconds");

        System.out.println();

        double median;
        double[] runtimes = new double[iterations];

        for (int i = 0; i < iterations; i++) {
            polarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            polarPoint.getX();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 2 getX(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            cartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            cartesianPoint.getX();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 3 getX(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractPolarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            abstractPolarPoint.getX();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (polar) getX(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractCartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            abstractCartesianPoint.getX();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (cartesian) getX(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        System.out.println();

        for (int i = 0; i < iterations; i++) {
            polarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            polarPoint.getY();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 2 getY(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            cartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            cartesianPoint.getY();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 3 getY(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractPolarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            abstractPolarPoint.getY();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (polar) getY(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractCartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            abstractCartesianPoint.getY();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (cartesian) getY(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        System.out.println();

        for (int i = 0; i < iterations; i++) {
            polarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            polarPoint.getRho();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 2 getRho(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            cartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            cartesianPoint.getRho();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 3 getRho(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractPolarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            abstractPolarPoint.getRho();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (polar) getRho(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractCartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            abstractCartesianPoint.getRho();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (cartesian) getRho(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        System.out.println();

        for (int i = 0; i < iterations; i++) {
            polarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            polarPoint.getTheta();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 2 getTheta(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            cartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            cartesianPoint.getTheta();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 3 getTheta(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractPolarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            abstractPolarPoint.getTheta();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (polar) getTheta(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractCartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            abstractCartesianPoint.getTheta();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (cartesian) getTheta(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        System.out.println();

        for (int i = 0; i < iterations; i++) {
            polarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            polarPoint.convertStorageToPolar();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 2 convertStorageToPolar(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            cartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            cartesianPoint.convertStorageToPolar();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 3 convertStorageToPolar(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractPolarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            abstractPolarPoint.convertStorageToPolar();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (polar) convertStorageToPolar(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractCartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            abstractCartesianPoint.convertStorageToPolar();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (cartesian) convertStorageToPolar(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        System.out.println();

        for (int i = 0; i < iterations; i++) {
            polarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            polarPoint.convertStorageToCartesian();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 2 convertStorageToCartesian(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            cartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            cartesianPoint.convertStorageToCartesian();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 3 convertStorageToCartesian(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractPolarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            abstractPolarPoint.convertStorageToCartesian();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (polar) convertStorageToCartesian(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractCartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            abstractCartesianPoint.convertStorageToCartesian();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (cartesian) convertStorageToCartesian(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        System.out.println();

        for (int i = 0; i < iterations; i++) {
            polarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            polarPoint.getDistance(polarPoint);
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 2 getDistance(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            cartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            cartesianPoint.getDistance(cartesianPoint);
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 3 getDistance(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractPolarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            abstractPolarPoint.getDistance(abstractPolarPoint);
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (polar) getDistance(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractCartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            abstractCartesianPoint.getDistance(abstractCartesianPoint);
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (cartesian) getDistance(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        System.out.println();

        for (int i = 0; i < iterations; i++) {
            polarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            polarPoint.rotatePoint(90);
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 2 rotatePoint(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            cartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            cartesianPoint.rotatePoint(90);
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 3 rotatePoint(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractPolarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            abstractPolarPoint.rotatePoint(90);
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (polar) rotatePoint(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractCartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            abstractCartesianPoint.rotatePoint(90);
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (cartesian) rotatePoint(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        System.out.println();

        for (int i = 0; i < iterations; i++) {
            polarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            polarPoint.toString();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 2 toString(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            cartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            cartesianPoint.toString();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 3 toString(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractPolarPoint = new PolarPoint(1, 90);
            startTime = System.nanoTime() / 1000;
            abstractPolarPoint.toString();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (polar) toString(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");

        for (int i = 0; i < iterations; i++) {
            abstractCartesianPoint = new CartesianPoint(1, 1);
            startTime = System.nanoTime() / 1000;
            abstractCartesianPoint.toString();
            endTime = System.nanoTime() / 1000;
            totalTime = endTime - startTime;
            runtimes[i] = totalTime;
        }
        Arrays.sort(runtimes);
        if (runtimes.length % 2 == 0)
            median = (runtimes[runtimes.length / 2] + runtimes[runtimes.length / 2 - 1]) / 2;
        else
            median = runtimes[runtimes.length / 2];

        System.out.println("Minimum, median and maximum time taken for design 5 (cartesian) toString(): (" + runtimes[0] + ',' + median + ',' + runtimes[iterations - 1] + ") microseconds");
    }
}