package capedcrusaders.dutyhelper;

import android.app.Activity;
import android.graphics.Color;
import android.support.annotation.NonNull;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import java.util.List;

import static capedcrusaders.dutyhelper.TaskEditorActivity.resources;

class ItemList extends ArrayAdapter<Item> {

    private Activity context;
    private List<Item> items;

    ItemList(Activity context, List<Item> items) {
        super(context, R.layout.item_layout, items);
        this.context = context;
        this.items = items;
    }

    @NonNull
    @Override
    public View getView(int position, View convertView, @NonNull ViewGroup parent) {
        LayoutInflater inflater = context.getLayoutInflater();
        View listViewItem = inflater.inflate(R.layout.item_layout, null, true);

        TextView itemName = listViewItem.findViewById(R.id.item_name);
        TextView itemNote = listViewItem.findViewById(R.id.item_description);

        listViewItem.findViewById(R.id.item_assignee).setVisibility(View.GONE);
        listViewItem.findViewById(R.id.item_completion_status).setVisibility(View.GONE);

        Item item = items.get(position);
        itemName.setText(item.getName());
        itemNote.setText(item.getDescription());
        if (resources.containsKey(item.getName())) {
            listViewItem.setBackgroundColor(Color.LTGRAY);
        }
        return listViewItem;
    }

}
