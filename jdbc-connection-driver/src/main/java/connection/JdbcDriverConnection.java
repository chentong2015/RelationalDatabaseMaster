package connection;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.SQLException;
import java.util.Properties;

public class JdbcDriverConnection {

    public static void main(String[] args) throws Exception {
        String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        String url = "jdbc:sqlserver://localhost:1433;Database=test_db;";

        // 为DB链接字符串添加特定属性(User, Password)
        Properties properties = new Properties();
        properties.put("user", "test");
        properties.put("password", "TCHong20");
        properties.put("trustServerCertificate", "true");

        // TODO. 通过DB Vendor的Driver Impl具体实现连接到特定数据库
        Driver driver = (Driver) Class.forName(driverName).getDeclaredConstructor().newInstance();
        Connection connection = driver.connect(url, properties);

        // TODO. JDBC Connection默认在SQL Statement结束瞬间会立即更新数据库
        connection.setAutoCommit(true);

        // 默认或者设置成true自动提交时不能再显式commit提交
        // connection.commit();

        connection.close();
    }

    // TODO. Driver和URL必须匹配数据库的类型/版本才能建立DB连接
    public void openConnection(Driver driverObject, String url, Properties driverProperties) {
        try {
            Connection connection = driverObject.connect(url, driverProperties);
            if (connection == null) {
                throw new RuntimeException("Can not connect to db of url");
            }
            connection.close();
        } catch (SQLException exception) {
            String driverClassName = driverObject.getClass().getName();
            if (driverClassName.equals("org.h2.driver")) {
                System.out.println("Make sure H2 database is active and accessible");
            }
            System.out.println("Connection can't be created to url");
        }
    }
}
