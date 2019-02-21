import javafx.util.Pair;

import java.io.*;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.StringTokenizer;

class findroute {
    public static void main(String[] args) {
        PrintWriter writer = null;
        try {
            writer = new PrintWriter("solution.txt");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        assert writer != null;
        writer.print("");
        writer.close();
        Utils utils = new Utils();
        ArrayList<Pair<String, Pair<Double, Double>>> pools = new ArrayList<>();
        try {
            FileReader fileReader = new FileReader(args[0]);
            BufferedReader bufferedReader = new BufferedReader(fileReader);
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                String[] split = line.split(" ");
                StringBuilder name = new StringBuilder();
                for (int i = 0; i < split.length-2; i++) {
                    name.append(split[i]);
                    name.append(" ");
                }
                name = new StringBuilder(name.substring(0, name.length() - 1));
                pools.add(new Pair<>(name.toString(), new Pair<>(Double.valueOf(split[split.length - 2]), Double.valueOf(split[split.length - 1]))));
            }
            fileReader.close();
            bufferedReader.close();
        } catch (FileNotFoundException e) {
            System.out.println("can't open");
        } catch (IOException e) {
            System.out.println("can't read");
        }
        pools.sort(Comparator.comparingDouble(longitude -> longitude.getValue().getKey()));
        Node<Pair<String, Pair<Double, Double>>> root = new Node<>(pools.get(0));
        double min = utils.distance(pools.get(0), pools.get(1));
        double newMin;
        int position = 1;
        for (int i = 2; i < pools.size(); i++) {
            if ((newMin = utils.distance(pools.get(0), pools.get(i))) < min) {
                min = newMin;
                position = i;
            }
        }
        Node<Pair<String, Pair<Double, Double>>> rootChild;
        root.addChild(rootChild = new Node<>(pools.get(position)));
        ArrayList<Node<Pair<String, Pair<Double, Double>>>> added = new ArrayList<>();
        added.add(root);
        added.addAll(root.getChildren());
        pools.remove(root.getData());
        pools.remove(rootChild.getData());
        for (Pair<String, Pair<Double, Double>> pool:pools) {
            min = Integer.MAX_VALUE;
            position = -1;
            for (int j = 0; j < added.size(); j++) {
                newMin = utils.distance(pool, added.get(j).getData());
                if (newMin < min) {
                    min = newMin;
                    position = j;
                }
            }
            Node<Pair<String, Pair<Double, Double>>> newChild = new Node<>(pool);
            added.get(position).addChild(newChild);
            added.add(newChild);
        }
        added = new ArrayList<>();
        utils.preOrderTraversal(root, added);
        double sum = 0;
        StringBuilder solution = new StringBuilder(added.get(0).getData().getKey() + " " + sum + System.lineSeparator());
        for (int i = 1; i < added.size(); i++) {
            sum += utils.distance(added.get(i).getData(),added.get(i-1).getData());
            solution.append(added.get(i).getData().getKey()).append(" ").append(sum).append(System.lineSeparator());
        }
        utils.writeToFile(solution.toString());
    }
}

