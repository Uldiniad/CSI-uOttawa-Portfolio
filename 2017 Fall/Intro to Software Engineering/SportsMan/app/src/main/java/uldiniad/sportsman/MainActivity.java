package uldiniad.sportsman;

import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void onOpenInGoogleMaps(View view) {
        EditText teamLocation = (EditText) findViewById(R.id.TeamLocation);
        Uri googleMapsIntentUri = Uri.parse("http://maps.google.co.in/maps?q=" + teamLocation.getText());
        Intent mapIntent = new Intent(Intent.ACTION_VIEW, googleMapsIntentUri);
        mapIntent.setPackage("com.google.android.apps.maps");
        startActivity(mapIntent);
    }

    public void OnSetAvatarButton(View view) {
//Application Context and Activity
        Intent intent = new Intent(getApplicationContext(), ProfileActivity.class);
        startActivityForResult(intent, 0);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (resultCode == RESULT_CANCELED) return;
//Getting the Avatar Image we show to our users
        ImageView avatarImage = (ImageView) findViewById(R.id.Logo);
//Figuring out the correct image
        String drawableName = "ic_logo_00";
        switch (data.getIntExtra("imageID", R.id.teamid00)) {
            case R.id.teamid00:
                drawableName = "ic_logo_00";
                break;
            case R.id.teamid01:
                drawableName = "ic_logo_01";
                break;
            case R.id.teamid02:
                drawableName = "ic_logo_02";
                break;
            case R.id.teamid03:
                drawableName = "ic_logo_03";
                break;
            case R.id.teamid04:
                drawableName = "ic_logo_04";
                break;
            case R.id.teamid05:
                drawableName = "ic_logo_05";
                break;
            default:
                drawableName = "ic_logo_00";
                break;
        }
        int resID = getResources().getIdentifier(drawableName, "drawable",
                getPackageName());
        avatarImage.setImageResource(resID);
    }
}
