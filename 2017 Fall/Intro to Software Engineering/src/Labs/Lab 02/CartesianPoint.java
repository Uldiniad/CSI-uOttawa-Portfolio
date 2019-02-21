public class CartesianPoint extends AbstractPoint { // AKA DESIGN 3
    private double x, y;

    public CartesianPoint(double x, double y) {
        this.x = x;
        this.y = y;
    }

    @Override
    public double getX() {
        return x;
    }

    @Override
    public double getY() {
        return y;
    }

    @Override
    public double getRho() {
        return (Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2)));
    }

    @Override
    public double getTheta() {
        return Math.toDegrees(Math.atan2(y, x));
    }

    @Override
    public PolarPoint convertStorageToPolar() {
        return new PolarPoint(getRho(), getTheta());
    }

    @Override
    public CartesianPoint convertStorageToCartesian() {
        return this;
    }

    @Override
    public double getDistance(AbstractPoint pointB) {
        double deltaX = getX() - pointB.getX();
        double deltaY = getY() - pointB.getY();

        return Math.sqrt((Math.pow(deltaX, 2) + Math.pow(deltaY, 2)));
    }

    @Override
    public CartesianPoint rotatePoint(double rotation) {
        double radRotation = Math.toRadians(rotation);
        double X = getX();
        double Y = getY();

        return new CartesianPoint(
                (Math.cos(radRotation) * X) - (Math.sin(radRotation) * Y),
                (Math.sin(radRotation) * X) + (Math.cos(radRotation) * Y));
    }

    @Override
    public String toString() {
        return "Cartesian: (" + getX() + "," + getY() + ")";
    }
}
