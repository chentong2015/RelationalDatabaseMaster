package com.h2.database;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class BaseH2Database {

    public static void main(String[] a) throws Exception {
        ClassLoader classLoader = BaseH2Database.class.getClassLoader();
        InputStream inputStream = classLoader.getResourceAsStream("h2-db.properties");
        Properties properties = new Properties();
        properties.load(inputStream);
        System.out.println(properties.getProperty("jdbc.url"));

        String url = "jdbc:h2:./relational-databases/embedded/h2-db/src/main/resources/sample;DB_CLOSE_DELAY=-1;DATABASE_TO_UPPER=true;";
        Connection conn = DriverManager.getConnection(url, "admin", "admin");
        String sql = "CREATE TABLE t_test2 (id INT NOT NULL, title VARCHAR(50) NOT NULL);";
        conn.createStatement().executeUpdate(sql);
        conn.close();
    }

    private void testLocalServer() throws Exception {
        Class.forName("org.h2.Driver");
        Connection conn = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
        String sql = "Insert into t_test (id, name) values (9, 'item09');";
        // String sql = "Insert into t_cpu values (default, '70d0c37e', 'CPU',
        //   'Intel Core i7-8809G', 'Intel', 150.0 , 25, 'Core i7', 4, '3.10 GHz', '1.20 GHz');";
        conn.createStatement().execute(sql);
        conn.close();
    }
}
