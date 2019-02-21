import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    public static void main(String[] args) {
        ServerSocket serverSocket = null;
        String message = "";
        try {
            serverSocket = new ServerSocket(2018);
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            assert serverSocket != null;
            Socket socket = serverSocket.accept();
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintStream printStream = new PrintStream(socket.getOutputStream());
            message = bufferedReader.readLine();
            if (message.equals("request to send")) {
                printStream.print("clear to send\n");
            }
            message = bufferedReader.readLine();
            if (message != null) {
                System.out.println("Client: " + message + ". Decoding...");
                printStream.print("input received");
            }
            bufferedReader.close();
            printStream.close();
            socket.close();
            serverSocket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println();
        System.out.println(decode(message));
    }

    private static String decode(String input) {
        if (input != null) {
            input = input.replace("000-+0+-", "00000000");
            input = input.replace("000+-0-+", "00000000");
            input = input.replace('+', '1');
            input = input.replace('-', '1');
        }
        return input;
    }
}