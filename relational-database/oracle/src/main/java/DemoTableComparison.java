import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// Test Comparing two tables from different oracle databases
public class DemoTableComparison {

    private static String database1 = "jdbc:oracle:thin:@//localhost:1560/orclcdb";
    private static String database2 = "jdbc:oracle:thin:@//localhost:1561/orclcdb";

    // Oracle空字段值的判断
    private static String queryDb1 = "select id from FOFUTI_MAIN where natid_normalized != '\u0001 NULL' and id not LIKE 'WCZ%'";
    private static String queryDb2 = "select * from FOFUTI_MAIN where natid_normalized = '\u0001 NULL' and id = ";

    public static void main(String[] args) throws SQLException {
        List<String> idList = new ArrayList<>();
        try(Connection connection = DriverManager.getConnection(database1, "fmm", "hello00")) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(queryDb1);
            while (resultSet.next()) {
                idList.add(resultSet.getString("id"));
            }
            statement.close();
        }

        System.out.println(idList.size());
        try(Connection connection = DriverManager.getConnection(database2, "fmm", "hello00")) {
            Statement statement = connection.createStatement();
            for (String id: idList) {
                String queryCheck = queryDb2.concat("'").concat(id).concat("'");
                ResultSet resultSet = statement.executeQuery(queryCheck);
                if (resultSet.next()) {
                    System.out.println("Error:" + id);
                }
            }
            statement.close();
        }
    }
}
