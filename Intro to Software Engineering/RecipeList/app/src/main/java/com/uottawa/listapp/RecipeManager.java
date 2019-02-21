package com.uottawa.listapp;

import android.os.Debug;
import android.util.Log;

import java.util.ArrayList;

//Simple Recipe Management Singleton
public class RecipeManager {

    public static final String intentIndexTitle = "selectedRecipe";
    private static RecipeManager instance = null;
    private ArrayList<Recipe> recipeList;

    protected RecipeManager() {
        //This Exists to defeat instantiation

        String[] values = new String[]{
                "Burrito", "Pizza", "Latte", "Raclette", "Feijoada", "empty", "empty", "empty", "empty", "Last Supper"
        };

        recipeList = new ArrayList<>();

        for (int i = 0; i < values.length ; i++) {
            Recipe newRecipe = new Recipe(values[i],"Recipe Description has not been defined.");
            recipeList.add(newRecipe);
        }
    }

    public static RecipeManager getInstance() {
        if (instance == null) {
            instance = new RecipeManager();
        }
        return instance;
    }

    public ArrayList<Recipe> getRecipeList() {
        return recipeList;
    }

    public Recipe getRecipeAt(int index) {
        return recipeList.get(index);
    }
}
