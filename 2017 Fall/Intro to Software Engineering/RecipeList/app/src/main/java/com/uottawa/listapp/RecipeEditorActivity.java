package com.uottawa.listapp;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class RecipeEditorActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recipe_editor);

        //Getting the incomming intent
        Intent intent = getIntent();
        int recipeIndex = intent.getIntExtra(RecipeManager.intentIndexTitle,0); //0 is a "default return value"

        //Getting TextFields we are about to update
        final TextView recipeName = (TextView) findViewById(R.id.line01);
        final EditText recipeDescriptionline = (EditText) findViewById(R.id.line02);

        //Getting corresponding Recipe
        final Recipe recipe = RecipeManager.getInstance().getRecipeAt(recipeIndex);

        //Updating contents in this screen
        recipeName.setText(recipe.getRecipeName());
        recipeDescriptionline.setText(recipe.getRecipeDescription());

        //Updating Function of OnClick Button (Save)
        Button saveButton = (Button) findViewById(R.id.buttonSave);
        saveButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
            //Updating contents in variable
            recipe.setRecipeName(recipeName.getText().toString());
            recipe.setRecipeDescription(recipeDescriptionline.getText().toString());

            //TODO: Save changed recipe information back in to recipe (I don't do it in the examples as students have to implement their own logic)
            finish();
            }
        });

        //Updating Function of OnClick Button (Cancel)
        Button cancelButton = (Button) findViewById(R.id.buttonCancel);
        cancelButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

    }
}
