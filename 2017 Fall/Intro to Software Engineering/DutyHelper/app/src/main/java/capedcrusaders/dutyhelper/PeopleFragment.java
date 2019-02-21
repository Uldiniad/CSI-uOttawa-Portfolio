package capedcrusaders.dutyhelper;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;

import com.google.firebase.database.FirebaseDatabase;

import static capedcrusaders.dutyhelper.MainActivity.groupReference;
import static capedcrusaders.dutyhelper.MainActivity.user;
import static capedcrusaders.dutyhelper.MainActivity.userGroup;

public class PeopleFragment extends android.support.v4.app.Fragment {

    static ListView listViewPeople;
    static UserList userList;

    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_people, container, false);
        Button joinGroupButton = rootView.findViewById(R.id.change_group_button);
        listViewPeople = rootView.findViewById(R.id.people_list);
        listViewPeople.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long l) {
                if (user instanceof PrivilegedUser) {
                    if (!userGroup.getUsersList().get(i).username.equals(user.username)) {
                        PrivilegedUser temp = ((PrivilegedUser) user).promote(userGroup.getUsersList().get(i));
                        groupReference.child("users").child(userGroup.getUsersList().get(i).username).setValue(temp);
                        FirebaseDatabase.getInstance().getReference("users").child(userGroup.getUsersList().get(i).username).setValue(temp);
                    } else {
                        Toast.makeText(PeopleFragment.this.getActivity(), "You cannot promote yourself", Toast.LENGTH_SHORT).show();
                    }
                } else {
                    Toast.makeText(PeopleFragment.this.getActivity(), "You must be a privileged user to promote other users", Toast.LENGTH_SHORT).show();
                }
                return true;
            }
        });
        listViewPeople.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Toast.makeText(PeopleFragment.this.getActivity(), "Long click to promote users", Toast.LENGTH_SHORT).show();
            }
        });
        joinGroupButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivityForResult(new Intent(PeopleFragment.this.getActivity(), GroupEditorActivity.class), 0);
            }
        });
        return rootView;
    }
}