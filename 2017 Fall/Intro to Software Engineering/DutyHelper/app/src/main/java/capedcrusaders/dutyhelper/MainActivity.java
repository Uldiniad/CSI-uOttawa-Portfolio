package capedcrusaders.dutyhelper;

import android.content.ContentUris;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.provider.CalendarContract;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.design.widget.NavigationView;
import android.support.design.widget.TabLayout;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.GravityCompat;
import android.support.v4.view.ViewPager;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Objects;

import static capedcrusaders.dutyhelper.PeopleFragment.listViewPeople;
import static capedcrusaders.dutyhelper.PeopleFragment.userList;
import static capedcrusaders.dutyhelper.ShoppingFragment.shoppingItems;
import static capedcrusaders.dutyhelper.ShoppingFragment.shoppingList;
import static capedcrusaders.dutyhelper.ShoppingFragment.shoppingListViewItems;
import static capedcrusaders.dutyhelper.TasksFragment.listViewTasks;
import static capedcrusaders.dutyhelper.TasksFragment.onlyViewUserTasks;
import static capedcrusaders.dutyhelper.TasksFragment.taskList;

public class MainActivity extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener {

    static GenericUser user;
    static DatabaseReference userReference;
    static FirebaseUser firebaseUser;
    static UserGroup userGroup;
    static DatabaseReference groupReference;
    TabLayout tabLayout;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        SectionsPagerAdapter mSectionsPagerAdapter = new SectionsPagerAdapter(getSupportFragmentManager());

        ViewPager mViewPager = findViewById(R.id.container);
        mViewPager.setAdapter(mSectionsPagerAdapter);
        mViewPager.setCurrentItem(1);
        mViewPager.setOffscreenPageLimit(2);

        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.addDrawerListener(toggle);
        toggle.syncState();

        NavigationView navigationView = findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);

        tabLayout = findViewById(R.id.tabs);
        tabLayout.setupWithViewPager(mViewPager);

        firebaseUser = FirebaseAuth.getInstance().getCurrentUser();

        View headerView = navigationView.getHeaderView(0);
        final TextView userName = headerView.findViewById(R.id.user_name);
        userName.setText(firebaseUser.getEmail());

        userReference = FirebaseDatabase.getInstance().getReference("users").
                child(firebaseUser.getEmail().substring(0, firebaseUser.getEmail().indexOf('@')).replace(".", ""));
        userReference.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                if (!dataSnapshot.hasChildren()) {  //if first time a user logs in, create a database reference for him
                    user = new GenericUser(firebaseUser.getEmail().substring(0, firebaseUser.getEmail().indexOf('@')));
                    userReference.setValue(user);
                } else if (dataSnapshot.hasChildren()) {
                    if (dataSnapshot.hasChild("privileged") && Objects.equals(dataSnapshot.child("privileged").getValue(Boolean.class), true)) {
                        user = dataSnapshot.getValue(PrivilegedUser.class);
                    } else {
                        user = dataSnapshot.getValue(GenericUser.class);
                    }
                }
                if (user.groupKey != null) {
                    groupReference = FirebaseDatabase.getInstance().getReference("groups").child(user.groupKey);
                    groupReference.child("users").child(user.username).setValue(user);
                    initializeGroupReferenceListener();
                }
                if (user.getTasksList() != null && onlyViewUserTasks) {
                    taskList = new TaskList(MainActivity.this, user.getTasksList());
                    listViewTasks.setAdapter(taskList);
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });

        FirebaseDatabase.getInstance().getReference("groups").addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot group : dataSnapshot.getChildren()) {
                    if (!group.child("users").hasChildren()) {
                        FirebaseDatabase.getInstance().getReference("groups").child(group.getKey()).removeValue();
                    }
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }


    void initializeGroupReferenceListener() {
        groupReference.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                if (user.groupKey != null)
                    userGroup = dataSnapshot.getValue(UserGroup.class);
                if (userGroup != null) {
                    userList = new UserList(MainActivity.this, userGroup.getUsersList());
                    if (!onlyViewUserTasks && userGroup.users != null) {
                        ArrayList<Task> tasks = new ArrayList<>();
                        Collection<GenericUser> users = userGroup.users.values();
                        for (GenericUser genericUser : users) {
                            if (genericUser.tasks != null)
                                tasks.addAll(genericUser.tasks.values());
                        }
                        taskList = new TaskList(MainActivity.this, tasks);
                        listViewTasks.setAdapter(taskList);
                    }
                    listViewPeople.setAdapter(userList);
                    shoppingItems = FirebaseDatabase.getInstance().getReference("groups").child(userGroup.title).child("shopping");
                    initializeShoppingItemsListener();
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }

    void initializeShoppingItemsListener() {
        shoppingItems.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                shoppingList = new ArrayList<>();
                for (DataSnapshot postSnapshot : dataSnapshot.getChildren()) {
                    Item Item = postSnapshot.getValue(Item.class);
                    shoppingList.add(Item);
                }
                ItemList ItemsAdapter = new ItemList(MainActivity.this, shoppingList);
                shoppingListViewItems.setAdapter(ItemsAdapter);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }

    @Override
    public void onBackPressed() {
        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();

        if (id == R.id.nav_tasks) {
            tabLayout.getTabAt(1).select();
        } else if (id == R.id.nav_shopping) {
            tabLayout.getTabAt(0).select();
        } else if (id == R.id.nav_calendar) {
            Uri.Builder builder = CalendarContract.CONTENT_URI.buildUpon();
            builder.appendPath("time");
            ContentUris.appendId(builder, System.currentTimeMillis());
            Intent intent = new Intent(Intent.ACTION_VIEW)
                    .setData(builder.build());
            startActivity(intent);
        } else if (id == R.id.nav_people) {
            tabLayout.getTabAt(2).select();
        } else if (id == R.id.nav_food) {
            if (user.groupKey == null)
                Toast.makeText(MainActivity.this, "Join a group to enable this feature", Toast.LENGTH_SHORT).show();
            else
                startActivity(new Intent(MainActivity.this, InventoryActivity.class).putExtra("inventory", "food"));
        } else if (id == R.id.nav_tools) {
            if (user.groupKey == null)
                Toast.makeText(MainActivity.this, "Join a group to enable this feature", Toast.LENGTH_SHORT).show();
            else
                startActivity(new Intent(MainActivity.this, InventoryActivity.class).putExtra("inventory", "tools"));
        } else if (id == R.id.nav_about) {
            showAboutDialog();
        } else if (id == R.id.nav_logout) {
            user = null;
            userGroup = null;
            userReference = null;
            groupReference = null;
            shoppingItems = null;
            FirebaseAuth.getInstance().signOut();
            finish();
        }

        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }

    private void showAboutDialog() {
        AlertDialog.Builder aboutDialog = new AlertDialog.Builder(this);
        final TextView textView = new TextView(this);
        textView.setText("About\n\n" +
                "• To create a task, visit the TASKS tab and press the plus sign at the bottom-right corner." +
                " You can store your personal task list without a group, but with limited functionality." +
                " To edit the task simply click on it once created.\n" +
                "• Tools in your group's inventory will appear at the bottom of the screen when creating or editing a task. Tap them to attach them to the task.\n" +
                "• If you do not yet have a group, visit the PEOPLE tab and SAVE a distinct group key as your title." +
                " You will automatically have administrative privileges when you create a group." +
                " If you want to join an existing group, ask its members what their group title is to SAVE it." +
                " You will automatically be set as a generic user. To gain administrative privileges, you must be promoted by another user with administrative privileges.\n" +
                "• If you have administrative privileges and would like to promote another user in your group, visit the PEOPLE tab and long click their name.\n" +
                "• If you have administrative privileges, you can assign and unassign tasks of your group." +
                " To assign, enter the user's username in the assignee field of the task. To unassign, leave blank.\n" +
                "• The Shopping list can be accessed at the SHOPPING tab. To access Food and Tools inventories, access the navigation drawer by clicking the three horizontal lines at the top-left corner.\n" +
                "• To edit or delete Shopping, Food or Tools items, long click on the item in the list. Remember that everyone in your group can see these lists.\n" +
                "• If you have completed a Task, mark it as complete to receive 5 points. Visit the PEOPLE tab to keep track of how many points each group member has.");
        aboutDialog.setView(textView);
        aboutDialog.show();
    }

    /**
     * A {@link FragmentPagerAdapter} that returns a fragment corresponding to
     * one of the sections/tabs/pages.
     */
    class SectionsPagerAdapter extends FragmentPagerAdapter {

        SectionsPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
            switch (position) {
                case 0:
                    return new ShoppingFragment();
                case 1:
                    return new TasksFragment();
                case 2:
                    return new PeopleFragment();
            }
            return null;
        }

        @Override
        public int getCount() {
            // Show 3 total pages.
            return 3;
        }

        @Nullable
        @Override
        public CharSequence getPageTitle(int position) {
            switch (position) {
                case 0:
                    return "Shopping";
                case 1:
                    return "Tasks";
                case 2:
                    return "People";
            }
            return null;
        }
    }
}
