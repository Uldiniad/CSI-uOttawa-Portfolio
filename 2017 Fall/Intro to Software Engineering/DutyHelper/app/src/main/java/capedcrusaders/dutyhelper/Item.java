package capedcrusaders.dutyhelper;

class Item {
    // instance variables
    private String name;
    private String description;
    private String id;

    private Item() {
    } //for firebase

    // constructor
    Item(String name, String description, String id) {
        this.name = name;
        this.description = description;
        this.id = id;
    }

    // getters
    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public String getId() {
        return id;
    }

}
