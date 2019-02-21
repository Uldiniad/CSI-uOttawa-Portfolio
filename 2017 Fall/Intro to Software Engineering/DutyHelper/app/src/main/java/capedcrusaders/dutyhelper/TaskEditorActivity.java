package capedcrusaders.dutyhelper;

import android.graphics.Color;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.TextUtils;
import android.view.View;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.util.HashMap;

import static capedcrusaders.dutyhelper.MainActivity.groupReference;
import static capedcrusaders.dutyhelper.MainActivity.user;
import static capedcrusaders.dutyhelper.MainActivity.userGroup;

public class TaskEditorActivity extends AppCompatActivity {

    static final HashMap<String, Item> resources = new HashMap<>();
    DatabaseReference userReference;
    String assignee;
    String taskID;
    boolean completed;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.update_dialog);

        taskID = getIntent().getExtras().getString("taskID");
        assignee = getIntent().getExtras().getString("assignee");
        completed = getIntent().getExtras().getBoolean("completed");

        if (!TextUtils.isEmpty(assignee))
            userReference = FirebaseDatabase.getInstance().getReference("users").child(assignee);
        else
            userReference = MainActivity.userReference;

        final EditText editTextTitle = findViewById(R.id.update_title);
        final EditText editTextNote = findViewById(R.id.update_description);
        final EditText editTextAssignee = findViewById(R.id.update_assignee);
        Button buttonSave = findViewById(R.id.save_item_button);
        Button buttonDelete = findViewById(R.id.delete_item_button);
        Button buttonCancel = findViewById(R.id.cancel_button);
        Button buttonCompleted = findViewById(R.id.completed_item_button);
        Button buttonIncomplete = findViewById(R.id.incomplete_item_button);
        final ListView listViewResources = findViewById(R.id.resource_list);
        findViewById(R.id.update_resources).setVisibility(View.GONE);

        listViewResources.setChoiceMode(AbsListView.CHOICE_MODE_MULTIPLE);
        if (taskID != null && !taskID.equals("") && user.tasks != null && user.tasks.get(taskID) != null
                && user.tasks != null && user.tasks.get(taskID).getResources() != null) {
            resources.putAll(user.tasks.get(taskID).getResources());
        }
        if (userGroup != null && userGroup.getToolsList() != null) {
            listViewResources.setAdapter(new ItemList(this, userGroup.getToolsList()));
            findViewById(R.id.update_resources).setVisibility(View.VISIBLE);
        }
        listViewResources.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
                if (resources.containsKey(userGroup.getToolsList().get(position).getName())) {
                    resources.remove(userGroup.getToolsList().get(position).getName());
                    view.setBackgroundColor(0xfffafafa);
                } else {
                    resources.put(userGroup.getToolsList().get(position).getName(), userGroup.getToolsList().get(position));
                    view.setBackgroundColor(Color.LTGRAY);
                }
            }
        });

        buttonIncomplete.setVisibility(View.GONE);
        buttonCompleted.setVisibility(View.GONE);
        if (taskID != null && !taskID.equals("") && !completed && !TextUtils.isEmpty(assignee)) {
            buttonCompleted.setVisibility(View.VISIBLE);
        }
        if (taskID != null && !taskID.equals("") && completed && !TextUtils.isEmpty(assignee) && user instanceof PrivilegedUser) {
            buttonIncomplete.setVisibility(View.VISIBLE);
        }

        buttonIncomplete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (completed) {
                    FirebaseDatabase.getInstance().getReference("users").child(assignee).child("tasks").child(taskID).
                            child("completed").setValue(false);
                    groupReference.child("users").child(assignee).child("tasks").child(taskID).child("completed").setValue(false);
                    if (user.points >= 5) {
                        MainActivity.userReference.child("points").setValue(user.points - 5);
                        FirebaseDatabase.getInstance().getReference("groups").child(user.groupKey).child("users").child(user.getUsername()).child("points").setValue(user.points - 5);
                    }
                    Toast.makeText(TaskEditorActivity.this, "Marked as incomplete. You lost 5 points", Toast.LENGTH_SHORT).show();
                }
                finish();
            }
        });
        buttonCompleted.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!completed) {
                    FirebaseDatabase.getInstance().getReference("users").child(assignee).child("tasks").child(taskID).
                            child("completed").setValue(true);
                    if (groupReference != null)
                        groupReference.child("users").child(assignee).child("tasks").child(taskID).child("completed").setValue(true);
                    if (user.groupKey == null)
                        Toast.makeText(TaskEditorActivity.this, "Marked as complete. Join a group to enable point system features", Toast.LENGTH_SHORT).show();
                    else {
                        MainActivity.userReference.child("points").setValue(user.points + 5);
                        FirebaseDatabase.getInstance().getReference("groups").child(user.groupKey).child("users").child(user.getUsername()).child("points").setValue(user.points + 5);
                        Toast.makeText(TaskEditorActivity.this, "Marked as complete. You gained 5 points!", Toast.LENGTH_SHORT).show();
                    }
                }
                finish();
            }
        });
        buttonSave.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String title = editTextTitle.getText().toString().trim();
                String note = editTextNote.getText().toString().trim();
                String assignedEmail = editTextAssignee.getText().toString().trim();
                if (!TextUtils.isEmpty(title)) {
                    saveTask(title, note, assignedEmail, taskID, resources);
                    finish();
                } else {
                    Toast.makeText(TaskEditorActivity.this, "Enter task title", Toast.LENGTH_SHORT).show();
                }
            }
        });
        buttonDelete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (taskID != null && !taskID.equals("")) {
                    deleteTask(taskID);
                    finish();
                } else {
                    Toast.makeText(TaskEditorActivity.this, "Task has not been created yet", Toast.LENGTH_SHORT).show();
                }
            }
        });
        buttonCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
        if (!(user instanceof PrivilegedUser)) {
            editTextAssignee.setVisibility(View.GONE);
            buttonDelete.setVisibility(View.GONE);
        }
        if (TextUtils.isEmpty(taskID) || TextUtils.isEmpty(assignee)) {
            buttonDelete.setVisibility(View.GONE);
        }
        if (taskID == null) {
            buttonCompleted.setVisibility(View.GONE);
        }
    }

    private void saveTask(String title, String note, String assigeedUsername, String id, HashMap<String, Item> resources) {
        if (TextUtils.isEmpty(assigeedUsername) && !(user instanceof PrivilegedUser)) {
            assigeedUsername = user.username;
        }
        if (id == null) {
            id = userReference.child("tasks").push().getKey();
        }
        if (!assigeedUsername.equals(assignee) && taskID != null) {
            FirebaseDatabase.getInstance().getReference("users").child(assignee).child("tasks").child(taskID).removeValue();
            if (groupReference != null)
                groupReference.child("users").child(assignee).child("tasks").child(taskID).removeValue();
        }
        Task task = new Task(title, note, id, user.username, assigeedUsername, resources);
        if (!TextUtils.isEmpty(assigeedUsername)) {
            FirebaseDatabase.getInstance().getReference("users").child(assigeedUsername).child("tasks").child(id).setValue(task);
            if (groupReference != null)
                groupReference.child("users").child(assigeedUsername).child("tasks").child(id).setValue(task);
        } else {
            FirebaseDatabase.getInstance().getReference("users").child(user.getUsername()).child("tasks").child(id).setValue(task);
        }
    }

    private void deleteTask(String id) {
        userReference.child("tasks").child(id).removeValue();
        groupReference.child("users").child(assignee).child("tasks").child(id).removeValue();
    }
}