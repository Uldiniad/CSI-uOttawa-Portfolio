package capedcrusaders.dutyhelper;

import java.util.HashMap;

class Task {
    // instance variables
    private String title;
    private String note;
    private String id;
    private String creator;
    private String assignee;
    private boolean completed;
    private HashMap<String, Item> resources;

    public Task() {
    } //for firebase

    // constructor
    Task(String title, String note, String id, String creator, String assignee, HashMap<String, Item> resources) {
        this.title = title;
        this.note = note;
        this.id = id;
        this.creator = creator;
        this.assignee = assignee;
        this.completed = false;
        this.resources = resources;
    }

    // getters
    public String getTitle() {
        return title;
    }

    public String getNote() {
        return note;
    }

    public String getId() {
        return id;
    }

    public String getCreator() {
        return creator;
    }

    public String getAssignee() {
        return assignee;
    }

    public boolean getCompleted() {
        return completed;
    }

    public HashMap<String, Item> getResources() {
        return resources;
    }
}