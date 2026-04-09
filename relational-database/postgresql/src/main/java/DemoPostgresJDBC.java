import java.sql.*;

public class DemoPostgresJDBC {

    public static void main(String[] args) throws SQLException {
        String url = "jdbc:postgresql://localhost:5432/my_database";
        try (Connection connection = DriverManager.getConnection(url, "postgres", "postgres")) {
            System.out.println(connection.getSchema());  // Default Schema: public
            System.out.println(connection.getAutoCommit());

            Statement statement = connection.createStatement();
            statement.executeUpdate("INSERT INTO t_comment(id, review) values (1002, 'test')");
            System.out.println("Connection Done");
        }
    }
}