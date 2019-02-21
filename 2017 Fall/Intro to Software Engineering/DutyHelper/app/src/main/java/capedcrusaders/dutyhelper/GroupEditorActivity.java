package capedcrusaders.dutyhelper;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import static capedcrusaders.dutyhelper.MainActivity.user;
import static capedcrusaders.dutyhelper.MainActivity.userGroup;
import static capedcrusaders.dutyhelper.MainActivity.userReference;

public class GroupEditorActivity extends AppCompatActivity {

    DatabaseReference groupsReference;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.update_dialog);

        findViewById(R.id.delete_item_button).setVisibility(View.GONE);
        findViewById(R.id.update_assignee).setVisibility(View.GONE);
        findViewById(R.id.update_description).setVisibility(View.GONE);
        findViewById(R.id.completed_item_button).setVisibility(View.GONE);
        findViewById(R.id.incomplete_item_button).setVisibility(View.GONE);
        findViewById(R.id.resource_list).setVisibility(View.GONE);
        findViewById(R.id.update_resources).setVisibility(View.GONE);

        final EditText groupTitle = findViewById(R.id.update_title);
        Button saveButton = findViewById(R.id.save_item_button);
        saveButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!TextUtils.isEmpty(groupTitle.getText().toString().trim())) {
                    if (groupTitle.getText().toString().trim().equals(user.getGroupKey())) {
                        Toast.makeText(GroupEditorActivity.this, "You already are a member of this group", Toast.LENGTH_SHORT).show();
                    } else {
                        saveGroup(groupTitle);
                        finish();
                    }
                } else {
                    Toast.makeText(GroupEditorActivity.this, "Please enter a group name", Toast.LENGTH_SHORT).show();
                }
            }
        });
        Button cancelButton = findViewById(R.id.cancel_button);
        cancelButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
    }

    private void saveGroup(final EditText title) {
        groupsReference = FirebaseDatabase.getInstance().getReference("groups");
        groupsReference.child(title.getText().toString().trim()).addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                userReference.child("groupKey").setValue(title.getText().toString().trim());
                if (!dataSnapshot.hasChildren()) { //if group doesn't exist
                    userGroup = new UserGroup(title.getText().toString().trim());
                    userGroup.addUser(user = new PrivilegedUser(user));
                    userReference.child("privileged").setValue(true);
                    groupsReference.child(title.getText().toString().trim()).setValue(userGroup);
                } else if (dataSnapshot.hasChildren()) { //if group exists
                    userGroup = dataSnapshot.getValue(UserGroup.class);
                    userGroup.addUser(user = new GenericUser(user));
                    userReference.child("privileged").setValue(false);
                }
                if (user.groupKey != null) {
                    groupsReference.child(user.groupKey).child("users").child(user.username).removeValue();
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }
}