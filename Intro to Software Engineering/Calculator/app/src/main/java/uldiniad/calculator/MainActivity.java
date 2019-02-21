package uldiniad.calculator;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    private enum Operator {none, add, minus, multiply, divide}

    private double num1 = 0, num2 = 0;
    private Operator operator = Operator.none;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void btn00Click(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        editText.setText(editText.getText() + "0");
    }

    public void btn01Click(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        editText.setText(editText.getText() + "1");
    }

    public void btn02Click(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        editText.setText(editText.getText() + "2");
    }

    public void btn03Click(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        editText.setText(editText.getText() + "3");
    }

    public void btn04Click(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        editText.setText(editText.getText() + "4");
    }

    public void btn05Click(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        editText.setText(editText.getText() + "5");
    }

    public void btn06Click(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        editText.setText(editText.getText() + "6");
    }

    public void btn07Click(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        editText.setText(editText.getText() + "7");
    }

    public void btn08Click(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        editText.setText(editText.getText() + "8");
    }

    public void btn09Click(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        editText.setText(editText.getText() + "9");
    }

    public void btnAddClick(View view) {
        operator = Operator.add;
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        num1 = Double.parseDouble(editText.getText().toString());
        editText.setText("");
    }

    public void btnMinusClick(View view) {
        operator = Operator.minus;
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        num1 = Double.parseDouble(editText.getText().toString());
        editText.setText("");
    }

    public void btnDivideClick(View view) {
        operator = Operator.divide;
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        num1 = Double.parseDouble(editText.getText().toString());
        editText.setText("");
    }

    public void btnMultiplyClick(View view) {
        operator = Operator.multiply;
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        num1 = Double.parseDouble(editText.getText().toString());
        editText.setText("");
    }

    public void btnDotClick(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        editText.setText(editText.getText() + ".");
    }

    public void btnClearClick(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        editText.setText("");
    }

    public void btnResultClick(View view) {
        EditText editText = (EditText) findViewById(R.id.resultEdit);
        num2 = Double.parseDouble(editText.getText().toString());
        double result = 0;
        if (operator == Operator.add) {
            result = num1 + num2;
        } else if (operator == Operator.minus) {
            result = num1 - num2;
        } else if (operator == Operator.divide) {
            result = num1 / num2;
        } else if (operator == Operator.multiply) {
            result = num1 * num2;
        }
        operator = Operator.none;
        num1 = result;
        if (result - (int) result != 0) {
            editText.setText(String.valueOf(result));
        } else {
            editText.setText(String.valueOf((int) result));
        }
    }
}
