import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.Socket;
import java.util.Scanner;

public class Client {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter 0s and 1s:");
        String input = scanner.nextLine();
        input = encode(input);
        System.out.println("Your encoded message: " + input + ". Sending to server...");
        Socket socket = null;
        BufferedReader bufferedReader = null;
        DataOutputStream dataOutputStream = null;
        try {
            socket = new Socket("127.0.0.1", 2018);
            bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            dataOutputStream = new DataOutputStream(socket.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (socket != null && dataOutputStream != null) {
            try {
                dataOutputStream.writeBytes("request to send\n");
                if (bufferedReader.readLine().equals("clear to send")) {
                    dataOutputStream.writeBytes(input + "\n");
                }
                if (bufferedReader.readLine().equals("input received")) {
                    System.out.println();
                    System.out.println("Server: input received");
                }
                bufferedReader.close();
                dataOutputStream.close();
                socket.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private static String encode(String input) {
        int oneCount = 0;
        char sign = ' ';
        for (int i = 0; i < input.length(); ++i) {
            if (input.charAt(i) == '1') {
                if ((++oneCount % 2 == 0)) {
                    sign = '-';
                } else {
                    sign = '+';
                }
                input = input.substring(0, i) + sign + input.substring(i + 1);
            } else {
                if (sign == '-') {
                    input = input.replaceFirst("00000000","000-+0+-");
                } else {
                    input = input.replaceFirst("00000000","000+-0-+");
                }
            }
        }
        return input;
    }
}
