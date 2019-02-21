package a5_7931937;
public class Rectangle {
    private int x1;
    private int x2;
    private int y1;
    private int y2;
    private String colour;

    public Rectangle(int x1, int y1, int x2, int y2, String colour) {
        this.x1=x1;
        this.y1=y1;
        this.x2=x2;
        this.y2=y2;
        this.colour=colour;
    }
    public String getColour () {
        return colour;
    }
    public void setColour(String newColour) {
        colour = newColour;
    }
    public int getX1() {
        return x1;
    }
    public int getX2() {
        return x2;
    }
    public int getY1() {
        return y1;
    }
    public int getY2() {
        return y2;
    }
    public void move(int xI, int yI) {
        this.x2=xI+(x2-x1);
        this.y2=yI+(y2-y1);
        this.x1=xI;
        this.y1=yI;
    }
    public void print() {
        System.out.println("The coordinates are (" + x1 + "," + y1 + ") (" + x2 + "," + y2 + ")");
        System.out.println("The colour is " + colour);
    }
    public int getArea() {
        return ((y2 - y1) * (x2 - x1));
    }
    public int getPerimeter() {
        return 2 * ((y2 - y1) + (x2 - x1));
    }
    public boolean contains(int x, int y) {
        if (x <= x2 && x >= x1 && y <= y2 && y >= y1) {
            return true;
        }
        return false;
    }
}
