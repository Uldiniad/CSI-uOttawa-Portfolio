import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

class SecondExercise {
    public static void main(String[] args) {
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://web0.site.uottawa.ca:15432/oscot042",
                    "oscot042", "Arkenst0ne");
            Statement statement = connection.createStatement();
            String[] fields = {"AName","Style"};
            String query = "";
            for (String field : fields) {
                query += field + ",";
            }
            query = query.substring(0,query.length()-1);
            ResultSet resultSet = statement.executeQuery("SELECT " + query + " FROM laboratories.artist");
            while (resultSet.next()) {
                System.out.println(resultSet.getString(1) + " " + resultSet.getString(2));
            }
            resultSet.close();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
