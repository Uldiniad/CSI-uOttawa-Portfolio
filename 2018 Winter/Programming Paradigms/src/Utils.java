import javafx.util.Pair;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

import static java.lang.Math.toRadians;

class Utils {
    void preOrderTraversal(Node<Pair<String, Pair<Double, Double>>> node,
                           ArrayList<Node<Pair<String, Pair<Double, Double>>>> preorder) {
        preorder.add(node);
        for (Node<Pair<String, Pair<Double, Double>>> current : node.getChildren()) {
            preOrderTraversal(current, preorder);
        }
    }

    void writeToFile(String solution) {
        try {
            FileWriter fileWriter = new FileWriter("solution.txt", true);
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
            bufferedWriter.write(solution);
            bufferedWriter.newLine();
            bufferedWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    double distance(Pair<String, Pair<Double, Double>> origin, Pair<String, Pair<Double, Double>> destination) {
        return distance(origin.getValue().getKey(), origin.getValue().getValue(), destination.getValue().getKey(), destination.getValue().getValue());
    }

    private double distance(double longitude_1, double latitude_1, double longitude_2, double latitude_2) {
        return 6371 * 2 * Math.asin(Math.sqrt(Math.pow(Math.sin((toRadians(latitude_1) - toRadians(latitude_2)) / 2), 2)
                + Math.cos(toRadians(latitude_1)) * Math.cos(toRadians(latitude_2))
                * Math.pow(Math.sin((toRadians(longitude_1) - toRadians(longitude_2)) / 2), 2)));
    }
}
