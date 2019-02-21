package capedcrusaders.dutyhelper;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import com.google.firebase.database.DatabaseReference;

import java.util.List;

import static capedcrusaders.dutyhelper.MainActivity.user;

public class ShoppingFragment extends Fragment {

    static DatabaseReference shoppingItems;
    static List<Item> shoppingList;
    static ListView shoppingListViewItems;
    EditText editItemName;
    EditText editItemDescription;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.activity_list, container, false);
        editItemName = rootView.findViewById(R.id.item_name);
        editItemDescription = rootView.findViewById(R.id.item_description);
        shoppingListViewItems = rootView.findViewById(R.id.item_list);
        Button addItemButton = rootView.findViewById(R.id.add_item_button);
        addItemButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (user.groupKey == null) {
                    Toast.makeText(ShoppingFragment.this.getActivity(), "Join a group to enable this feature", Toast.LENGTH_SHORT).show();
                } else {
                    addItem();
                }
            }
        });

        shoppingListViewItems.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long l) {
                Item Item = shoppingList.get(i);
                showUpdateDeleteDialog(Item.getId(), Item.getName());
                return true;
            }
        });
        return rootView;
    }

    private void showUpdateDeleteDialog(final String itemId, String itemName) {
        AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(this.getActivity());
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
                    Toast.makeText(ShoppingFragment.this.getActivity(), "Enter item name", Toast.LENGTH_SHORT).show();
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
        shoppingItems.child(id).setValue(Item);
        Toast.makeText(this.getActivity(), "Item updated", Toast.LENGTH_SHORT).show();
    }

    private void deleteItem(String id) {
        shoppingItems.child(id).removeValue();
        Toast.makeText(this.getActivity(), "Item deleted", Toast.LENGTH_SHORT).show();
    }

    private void addItem() {
        String name = editItemName.getText().toString().trim();
        String description = editItemDescription.getText().toString().trim();
        if (!TextUtils.isEmpty(name)) {
            String id = shoppingItems.push().getKey();
            Item Item = new Item(name, description, id);
            shoppingItems.child(id).setValue(Item);
            editItemName.setText("");
            editItemDescription.setText("");
            Toast.makeText(this.getActivity(), "Item added", Toast.LENGTH_SHORT).show();
        } else {
            Toast.makeText(this.getActivity(), "Enter item name", Toast.LENGTH_SHORT).show();
        }
    }
}