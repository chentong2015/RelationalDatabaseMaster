package lock.function;

import java.sql.*;

// MySQL提供Locking方法，用于自定义实现加锁逻辑
// https://dev.mysql.com/doc/refman/8.4/en/locking-functions.html
public class LockingFunction {

    // 创建特定名称的lock, 保证Session执行完毕并释放锁给其它Session
    // Returns 1 if the lock was obtained successfully,
    // Returns 0 if the attempt timed out
    // Returns NULL if an error occurred
    public static void main(String[] args) throws Exception {
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/dbName", "root", "");
        PreparedStatement sth = connection.prepareStatement("SELECT GET_LOCK(?, ?)");
        sth.setString(1, "distributed_lock");
        sth.setInt(2, 2);

        ResultSet resultSet = sth.executeQuery();
        resultSet.next();

        // 执行获取Lock的指令，控制程序的并发执行
        int status = resultSet.getInt(1);
        if (resultSet.wasNull()) {
            throw new Exception("Can not obtain lock");
        }
        if (status == 0) {
            throw new Exception("Already locked `distributed_lock`");
        }
        if (status == 1) {
            System.out.println("Get lock successfully");
        }
    }
}
