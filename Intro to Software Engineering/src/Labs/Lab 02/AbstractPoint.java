public abstract class AbstractPoint { // AKA DESIGN 5
    // declaring variables here is unnecessary since the subclasses will define their own.
    // declaring a constructor is unnecessary since we will use the constructor of the subclasses to form the correct type of point

    public abstract double getX();

    public abstract double getY();

    public abstract double getRho();

    public abstract double getTheta();

    public abstract AbstractPoint convertStorageToPolar();

    public abstract AbstractPoint convertStorageToCartesian();

    public abstract double getDistance(AbstractPoint pointB);

    public abstract AbstractPoint rotatePoint(double rotation);

    public abstract String toString();
}
