package a5_7931937;
public class Canvas {
    private Rectangle[] rectangles;
    private int numRectangles;
    public Canvas(int size) {
        this.rectangles=new Rectangle[size];
    }
    public void add(Rectangle aRectangle) {
        if (numRectangles<rectangles.length){
            this.rectangles[numRectangles]=aRectangle;
            numRectangles++;
        }
        else System.out.println("The canvas is full. Unable to add a new rectangle");
    }
    public int getNumRectangles() {
        return numRectangles;
    }
    public void printAll() {
        for (int i =0; i<rectangles.length; i++) {
            System.out.println("Information of rectangle " + (i+1));
            rectangles[i].print();
            System.out.println();
        }
    }
    public int countRectanglesForColour(String colour) {
        int sum=0;
        for (int i =0; i<rectangles.length; i++){
            if(colour==rectangles[i].getColour())
                sum++;
        }
        return sum;
    }
    public int totalPerimeter() {
        int sum=0;
        for (int i =0; i<rectangles.length; i++) {
            sum+=rectangles[i].getPerimeter();
        }
        return sum;
    }
    public static boolean intersect2(Rectangle r2, Rectangle r1) {
        if(((r2.getX1() >= r1.getX1()) && (r2.getX1() <= r1.getX2())||(r2.getX2() <= r1.getX2()) && (r2.getX2() >= r1.getX1()))&&((r2.getY1() >= r1.getY1()) && (r2.getY1() <= r1.getY2())||(r2.getY2() <= r1.getY2()) && (r2.getY2() >= r1.getY1())))
            return true;
        else return false;
    }
    public boolean intersectAll() {
        for(int i=0; i<rectangles.length-1; i++) {
            for (int j=1;j<rectangles.length&&j>i; j++)
            {
                if(intersect2(rectangles[i],rectangles[j])==false)
                    return false;
            }
        }
        return true;
    }
    public Rectangle minEnclosingRectangle() {
        int[]a=new int[rectangles.length];
        int[]b=new int[rectangles.length];
        int[]c=new int[rectangles.length];
        int[]d=new int[rectangles.length];
        for (int i = 0; i < rectangles.length; i++) {
            a[i]=rectangles[i].getX1();
            b[i]=rectangles[i].getY1();
            c[i]=rectangles[i].getX2();
            d[i]=rectangles[i].getY2();
        }
        int x1,y1,x2,y2;
        if (min(a)<min(c))
            x1=min(a);
        else x1=min(c);
        if (max(a)>max(c))
            x2=max(a);
        else x2=max(c);
        if (min(b)<min(d))
            y1=min(b);
        else y1=min(d);
        if (max(b)>max(d))
            y2=max(b);
        else y2=max(d);
        Rectangle wreckTangle = new Rectangle(x1,y1,x2,y2,"black");
        return wreckTangle;
    }
    private static int max(int[] a) {
        int currentMax = a[0], max;
        for(int i=0; i<a.length; i++){
            if(currentMax<a[i])
            currentMax=a[i];
        }
        max=currentMax;
        return max;
    }
    private static int min(int[] a) {
        int currentMin=a[0], min;
        for(int i=0; i<a.length; i++){
            if(currentMin>a[i])
                currentMin=a[i];
        }
        min=currentMin;
        return min;
    }
}
