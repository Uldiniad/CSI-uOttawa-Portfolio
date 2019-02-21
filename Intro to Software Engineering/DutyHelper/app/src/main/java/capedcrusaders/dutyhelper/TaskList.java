package capedcrusaders.dutyhelper;

import android.app.Activity;
import android.support.annotation.NonNull;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import java.util.List;

class TaskList extends ArrayAdapter<Task> {

    private Activity context;
    private List<Task> tasks;

    TaskList(Activity context, List<Task> tasks) {
        super(context, R.layout.item_layout, tasks);
        this.context = context;
        this.tasks = tasks;
    }

    @NonNull
    @Override
    public View getView(int position, View convertView, @NonNull ViewGroup parent) {
        LayoutInflater inflater = context.getLayoutInflater();
        View listViewItem = inflater.inflate(R.layout.item_layout, null, true);

        TextView taskName = listViewItem.findViewById(R.id.item_name);
        TextView taskNote = listViewItem.findViewById(R.id.item_description);
        TextView taskAssignee = listViewItem.findViewById(R.id.item_assignee);
        TextView taskCompleted = listViewItem.findViewById(R.id.item_completion_status);
        TextView taskResources = listViewItem.findViewById(R.id.item_resources);

        Task task = tasks.get(position);
        taskName.setText(task.getTitle());
        taskNote.setText(task.getNote());
        taskCompleted.setText("completed: " + task.getCompleted());
        if (taskNote.getText().equals("")) {
            taskNote.setVisibility(View.GONE);
        } else {
            taskNote.setVisibility(View.VISIBLE);
        }
        String resources = "";
        if (task.getResources() != null)
            for (Item item : task.getResources().values()) {
                resources += item.getName() + ", ";
            }
        if (resources.length() >= 2)
            resources = resources.substring(0, resources.length() - 2);
        if (resources.equals("")) {
            taskResources.setVisibility(View.GONE);
        } else {
            taskResources.setVisibility(View.VISIBLE);
        }
        taskResources.setText("equipment: " + resources);
        taskAssignee.setText("assignee: " + task.getAssignee());
        return listViewItem;
    }

}
