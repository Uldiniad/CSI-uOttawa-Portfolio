public class Employee {
    private String name;
    private int hours;
    private double rate;
    private Address[] addresses;

    public Employee(String name, int hours, double rate, Address[] addresses) {
        this.name = name;
        this.hours = hours;
        this.rate = rate;
        this.addresses = addresses;
    }

    public static void main(String[] args) {
        Address first = new Address(48, "Queen", "K1P1N2");
        Address second = new Address(800, "King Edward", "K1N6N5");
        Address[] addresses = {first, second};
        Employee falcao = new Employee("Falcao", 40, 15.50, addresses);
    }
}