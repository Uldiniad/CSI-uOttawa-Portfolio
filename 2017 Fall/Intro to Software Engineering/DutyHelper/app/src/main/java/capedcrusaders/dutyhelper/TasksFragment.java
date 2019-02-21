package capedcrusaders.dutyhelper;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.FloatingActionButton;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.CompoundButton;
import android.widget.ListView;
import android.widget.Switch;

import java.util.ArrayList;
import java.util.Collection;

import static capedcrusaders.dutyhelper.MainActivity.user;
import static capedcrusaders.dutyhelper.MainActivity.userGroup;

public class TasksFragment extends android.support.v4.app.Fragment {

    static ListView listViewTasks;
    static TaskList taskList;
    static boolean onlyViewUserTasks;
    Task task;

    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_tasks, container, false);
        listViewTasks = rootView.findViewById(R.id.task_list);
        listViewTasks.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                if (onlyViewUserTasks) {
                    task = user.getTasksList().get(i);
                } else {
                    ArrayList<Task> tasks = new ArrayList<>();
                    Collection<GenericUser> users = userGroup.users.values();
                    for (GenericUser genericUser : users) {
                        if (genericUser.tasks != null)
                            tasks.addAll(genericUser.tasks.values());
                    }
                    task = tasks.get(i);
                }
                startActivityForResult((new Intent(TasksFragment.this.getActivity(), TaskEditorActivity.class)
                        .putExtra("taskID", task.getId()).putExtra("assignee", task.getAssignee()).putExtra("completed", task.getCompleted())), 0);
            }
        });
        FloatingActionButton addTaskButton = rootView.findViewById(R.id.add_task_button);
        addTaskButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                addTask();
            }
        });
        Switch s = rootView.findViewById(R.id.switch_view_tasks);
        s.setChecked(true);
        onlyViewUserTasks = true;
        s.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                onlyViewUserTasks = b;
                if (user.getTasksList() != null && onlyViewUserTasks) {
                    taskList = new TaskList(TasksFragment.this.getActivity(), user.getTasksList());
                    listViewTasks.setAdapter(taskList);
                }
                if (userGroup != null && !onlyViewUserTasks) {
                    ArrayList<Task> tasks = new ArrayList<>();
                    Collection<GenericUser> users = userGroup.users.values();
                    for (GenericUser genericUser : users) {
                        if (genericUser.tasks != null)
                            tasks.addAll(genericUser.tasks.values());
                    }
                    taskList = new TaskList(TasksFragment.this.getActivity(), tasks);
                    listViewTasks.setAdapter(taskList);
                }
            }
        });
        return rootView;
    }

    private void addTask() {
        startActivityForResult(new Intent(TasksFragment.this.getActivity(), TaskEditorActivity.class).putExtra("taskID", (Bundle) null), 0);
    }
}
