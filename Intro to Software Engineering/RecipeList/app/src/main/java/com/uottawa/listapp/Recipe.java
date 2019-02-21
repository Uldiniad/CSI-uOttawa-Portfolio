package com.uottawa.listapp;

/**
 * Created by felipe on 2016-11-01.
 */

public class Recipe {
    private String recipeName = "Name Not Defined";
    private String recipeDescription = "Description Not Defined";

    public Recipe(String name, String description) {
        this.recipeName = name;
        this.recipeDescription = description;
    }

    //Here would go some code to manage the information in this class
    public String getRecipeName() {
        return recipeName;
    }

    public void setRecipeName(String newName) {
        recipeName = newName;
    }

    public String getRecipeDescription() {
        return recipeDescription;
    }

    public void setRecipeDescription(String newDescription) {
        recipeDescription = newDescription;
    }

}
