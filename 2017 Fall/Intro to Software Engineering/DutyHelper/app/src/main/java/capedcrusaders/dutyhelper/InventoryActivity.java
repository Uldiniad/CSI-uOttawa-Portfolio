package capedcrusaders.dutyhelper;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

import static capedcrusaders.dutyhelper.MainActivity.user;

public class InventoryActivity extends AppCompatActivity {

    static DatabaseReference itemsReference;
    EditText editItemName;
    EditText editItemDescription;
    Button addItemButton;
    List<Item> items;
    ListView listViewItems;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list);

        String inventory = getIntent().getExtras().getString("inventory");

        editItemName = findViewById(R.id.item_name);
        editItemDescription = findViewById(R.id.item_description);
        listViewItems = findViewById(R.id.item_list);
        addItemButton = findViewById(R.id.add_item_button);

        items = new ArrayList<>();
        addItemButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                addItem();
            }
        });

        listViewItems.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long l) {
                Item Item = items.get(i);
                showUpdateDeleteDialog(Item.getId(), Item.getName());
                return true;
            }
        });
        itemsReference = FirebaseDatabase.getInstance().getReference("groups").child(user.groupKey).child(inventory);
        itemsReference.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                items.clear();
                for (DataSnapshot postSnapshot : dataSnapshot.getChildren()) {
                    Item Item = postSnapshot.getValue(Item.class);
                    items.add(Item);
                }
                ItemList ItemsAdapter = new ItemList(InventoryActivity.this, items);
                listViewItems.setAdapter(ItemsAdapter);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }

    private void showUpdateDeleteDialog(final String itemId, String itemName) {
        AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(this);
        LayoutInflater inflater = getLayoutInflater();
        final View dialogView = inflater.inflate(R.layout.update_dialog, null);
        dialogBuilder.setView(dialogView);

        dialogView.findViewById(R.id.update_assignee).setVisibility(View.GONE);
        dialogView.findViewById(R.id.completed_item_button).setVisibility(View.GONE);
        dialogView.findViewById(R.id.incomplete_item_button).setVisibility(View.GONE);
        dialogView.findViewById(R.id.resource_list).setVisibility(View.GONE);
        dialogView.findViewById(R.id.update_resources).setVisibility(View.GONE);

        final EditText editItemName = dialogView.findViewById(R.id.update_title);
        final EditText editItemDescription = dialogView.findViewById(R.id.update_description);
        final Button buttonUpdate = dialogView.findViewById(R.id.save_item_button);
        final Button buttonDelete = dialogView.findViewById(R.id.delete_item_button);
        final Button buttonCancel = dialogView.findViewById(R.id.cancel_button);

        dialogBuilder.setTitle(itemName);
        final AlertDialog b = dialogBuilder.create();
        b.show();

        buttonUpdate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String name = editItemName.getText().toString().trim();
                String description = editItemDescription.getText().toString().trim();
                if (!TextUtils.isEmpty(name)) {
                    updateItem(name, description, itemId);
                    b.dismiss();
                } else {
                    Toast.makeText(InventoryActivity.this, "Enter item name", Toast.LENGTH_SHORT).show();
                }
            }
        });

        buttonDelete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                deleteItem(itemId);
                b.dismiss();
            }
        });

        buttonCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                b.dismiss();
            }
        });
    }

    private void updateItem(String name, String description, String id) {
        Item Item = new Item(name, description, id);
        itemsReference.child(id).setValue(Item);
        Toast.makeText(InventoryActivity.this, "Item updated", Toast.LENGTH_SHORT).show();
    }

    private void deleteItem(String id) {
        itemsReference.child(id).removeValue();
        Toast.makeText(InventoryActivity.this, "Item deleted", Toast.LENGTH_SHORT).show();
    }

    private void addItem() {
        String name = editItemName.getText().toString().trim();
        String description = editItemDescription.getText().toString().trim();
        if (!TextUtils.isEmpty(name)) {
            String id = itemsReference.push().getKey();
            Item Item = new Item(name, description, id);
            itemsReference.child(id).setValue(Item);
            editItemName.setText("");
            editItemDescription.setText("");
            Toast.makeText(InventoryActivity.this, "Item added", Toast.LENGTH_SHORT).show();
        } else {
            Toast.makeText(InventoryActivity.this, "Enter item name", Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        finish();
    }
}