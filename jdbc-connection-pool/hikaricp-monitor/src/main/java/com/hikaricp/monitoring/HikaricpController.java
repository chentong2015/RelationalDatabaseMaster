package com.hikaricp.monitoring;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;

@RestController
public class HikaricpController {

    // TODO. 默认数据库连接池: 通过.properties文件配置参数
    // com.zaxxer.hikari.HikariDataSource
    @Autowired
    DataSource dataSource;

    String query = "insert into test (id, value) values (20, 'test')";

    // TODO. 通过Endpoint请求模拟连接池中连接的变化
    @GetMapping("/run")
    public String run() throws SQLException {
        try(Connection connection = dataSource.getConnection();
            PreparedStatement statement = connection.prepareStatement(query)) {
            Thread.sleep(10000);
            System.out.println(statement.executeUpdate());
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        return "Hikaricp Monitoring";
    }

    // TODO. 模拟多个以便线程消耗连接池中的连接
    @GetMapping("/run-async")
    public String runAsync() {
        for (int index = 0; index < 10; index++) {
            new Thread(() -> {
                try(Connection connection = dataSource.getConnection();
                    PreparedStatement statement = connection.prepareStatement(query)) {
                    Thread.sleep(10000);
                    System.out.println(statement.executeUpdate());
                } catch (InterruptedException | SQLException e) {
                    throw new RuntimeException(e);
                }
            }).start();
        }
        return "Hikaricp Monitoring Async";
    }

    @GetMapping("/run-async-full")
    public String runAsyncFull() {
        for (int index = 0; index < 200; index++) {
            new Thread(() -> {
                try(Connection connection = dataSource.getConnection();
                    PreparedStatement statement = connection.prepareStatement(query)) {
                    Random random = new Random();
                    Thread.sleep(random.nextInt(5000, 20000));
                    System.out.println(statement.executeUpdate());
                } catch (InterruptedException | SQLException e) {
                    throw new RuntimeException(e);
                }
            }).start();
        }
        return "Hikaricp Monitoring Async Full";
    }
}
