package com.hikaricp.monitoring;

import com.zaxxer.hikari.HikariDataSource;
import com.zaxxer.hikari.HikariPoolMXBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;

@Component
public class HikaricpMonitor {

    @Autowired
    private DataSource dataSource;

    @Scheduled(fixedRate = 2000)
    public void monitorConnectionPool() {
        if (dataSource instanceof HikariDataSource hikariDataSource) {
            HikariPoolMXBean poolMXBean = hikariDataSource.getHikariPoolMXBean();
            System.out.println("Active: " + poolMXBean.getActiveConnections());
            System.out.println("Idle: " + poolMXBean.getIdleConnections());
            System.out.println("Total: " + poolMXBean.getTotalConnections());
            System.out.println("Threads Awaiting: " + poolMXBean.getThreadsAwaitingConnection());
            System.out.println("---------------------------------------------------------------");
        }
    }
}
