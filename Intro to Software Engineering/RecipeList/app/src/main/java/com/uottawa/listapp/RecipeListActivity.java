package com.uottawa.listapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

public class RecipeListActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recipe_list);

        // Get ListView object from xml layout
        ListView listView = (ListView) findViewById(R.id.list);

        //Getting RecipeManager Instance
        RecipeManager manager = RecipeManager.getInstance();

        //Defining Array values to show in ListView
        RecipeArrayAdapter adapter = new RecipeArrayAdapter(this, manager.getRecipeList());
        listView.setAdapter(adapter);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, final View view, int position, long id) {
            Intent launchTeamEditorIntent = new Intent(getApplicationContext(), RecipeEditorActivity.class);
            launchTeamEditorIntent.putExtra(RecipeManager.intentIndexTitle,position);
            startActivityForResult(launchTeamEditorIntent, 0);
            }
        });
    }

    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        // Get ListView object from xml layout
        ListView listView = (ListView) findViewById(R.id.list);

        //TODO: Recycle the layout to display updated information

        //Refresh the contents of the screen
        listView.refreshDrawableState();
    }
}
