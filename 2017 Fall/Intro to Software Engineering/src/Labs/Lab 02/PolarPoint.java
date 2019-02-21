public class PolarPoint extends AbstractPoint { // AKA DESIGN 2
    private double Rho;
    private double Theta;

    public PolarPoint(double Rho, double Theta) {
        this.Rho = Rho;
        this.Theta = Theta;
    }

    @Override
    public double getX() {
        return (Math.cos(Math.toRadians(Theta)) * Rho);
    }

    @Override
    public double getY() {
        return (Math.sin(Math.toRadians(Theta)) * Rho);
    }

    @Override
    public double getRho() {
        return Rho;
    }

    @Override
    public double getTheta() {
        return Theta;
    }

    @Override
    public PolarPoint convertStorageToPolar() {
        return this;
    }

    @Override
    public CartesianPoint convertStorageToCartesian() {
        return new CartesianPoint(getX(), getY());
    }

    @Override
    public double getDistance(AbstractPoint pointB) {
        double deltaX = getX() - pointB.getX();
        double deltaY = getY() - pointB.getY();

        return Math.sqrt((Math.pow(deltaX, 2) + Math.pow(deltaY, 2)));
    }

    @Override
    public PolarPoint rotatePoint(double rotation) {
        double radRotation = Math.toRadians(rotation);
        double X = getX();
        double Y = getY();

        return new PolarPoint(
                (Math.cos(radRotation) * X) - (Math.sin(radRotation) * Y),
                (Math.sin(radRotation) * X) + (Math.cos(radRotation) * Y));
    }

    @Override
    public String toString() {
        return "Polar: (" + getRho() + "," + getTheta() + ")";
    }
}
