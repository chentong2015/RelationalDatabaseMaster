package com.sqllite.main;

import java.sql.*;

// SQLite 默认使用transaction和auto commit来执行对数据库的更新
//
// 案列 1：
// 在banking账号转账时，需要执行以下两个操作, 如果第一个statement执行成功，但是第二个失败，将会造成数据错误 !!
// 出现错误时，需要将之前操作的数据撤销，回滚到之前的状态，但是如果撤销操作无法顺利执行，则错误无法解决 !!
// 1. update the source account with the new balance
// 2. update the destination account with the new balance
//
// 案列 2：
// 在music数据库中添加一首歌曲需要执行的操作和数据的关联: 添加之前需要对已经存储的信息进行验证
// 1. Add the artist to the artist table (_id, name)
// 2. Add the album the song is on to the albums table (_id, name, artist)
// 3. Add the song to songs table
public class DemoTransaction {

    private Connection connection;

    public void openConnection() throws SQLException {
        connection = DriverManager.getConnection("url");
    }

    /**
     * TODO. 指令执行步骤:
     * 1. Turn off auto-commit: Connection.setAutoCommit(false);
     * 2. Perform the SQL Operations
     * 3. If OK, Connection.commit(); else Connection.rollback();
     * 4. Turn on the auto-commit: Connection.setAutoCommit(true);
     */
    public void insertSongByTitle(String title, String artistName, String album, int track) throws SQLException {
        Savepoint savepoint = null;

        // 在添加song之前也需要判断是否已经存在相同的数据 !!
        String insertSongs = "INSERT INTO songs (track, title, album) VALUES (?, ?, ?)";
        try (PreparedStatement insertIntoSongs = connection.prepareStatement(insertSongs);) {
            connection.setAutoCommit(false);
            int artistId = insertArtistByName(artistName); // Execute series of sql statements
            int albumId = insertAlbum(album, artistId);

            // 设置指定回滚到的位置点 connection.rollback(savepoint);
            savepoint = connection.setSavepoint();
            insertIntoSongs.setInt(1, track);
            insertIntoSongs.setString(2, title);

            /**
             * 隐藏错误: throw ArrayIndexOutOfBoundsException
             * 1. 抛出该异常没有办法被后面catch捕获，造成数据没有办法回滚
             * 2. 最后的finally语句块.setAutoCommit(true)会产生side effect of commit, 导致前面执行的sql statement保存到数据库 !!!
             * ---------------------------------------------
             * 解决方案：捕获Exception任何的异常, 在任何异常产生之后都执行数据回滚，避免数据库中出现错误数据，或导致数据丢失 !!
             */
            insertIntoSongs.setInt(3, albumId);
            int affectedRows = insertIntoSongs.executeUpdate();
            if (affectedRows == 1) {
                connection.commit(); // 所有的transaction序列sql statement操作都成功，则commit changes to database !!
            } else {
                throw new SQLException("The song insert failed");
            }
        } catch (SQLException exception) { // 捕获所有try中调用的方法所抛出的异常 SQLException, 判断执行过程中是否出错 !!
            System.out.println("Insert song exception" + exception.getMessage());
            connection.rollback(); // 回滚，执行数据的恢复操作
        } finally {
            connection.setAutoCommit(true);
        }
    }

    private int insertArtistByName(String name) throws SQLException {
        int findKey = existArtistName(name);
        if (findKey == 0) {
            String insertArtist = "INSERT INTO artists (name) VALUES (?)";
            try (PreparedStatement insertIntoArtist = connection.prepareStatement(insertArtist, Statement.RETURN_GENERATED_KEYS)) {
                insertIntoArtist.setString(1, name);
                // insertIntoArtist.execute() 返回boolean类型的值，指示什么类型的返回值 !!
                int affectedRows = insertIntoArtist.executeUpdate();
                if (affectedRows == 1) {
                    ResultSet generatedKeys = insertIntoArtist.getGeneratedKeys();  // 拿到自动(添加)生成的key：_id
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("generate key error"); // 抛出异常给调用方法去处理 !!
                    }
                } else {
                    throw new SQLException("insert artist error");
                }
            }
        } else {
            return findKey;
        }
    }

    private int existArtistName(String name) throws SQLException {
        String queryAlbums = "SELECT _id FROM artists WHERE name = ?";
        try (PreparedStatement queryAlbumKey = connection.prepareStatement(queryAlbums)) {
            queryAlbumKey.setString(1, name);
            ResultSet resultSet = queryAlbumKey.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
            return 0;
        }
    }

    private int insertAlbum(String album, int artistId) throws SQLException {
        String queryAlbums = "SELECT _id FROM albums WHERE name = ? and artist = ?";
        String insertAlbums = "INSERT INTO albums (name, artist) VALUES (?, ?)";
        int albumId = 10;
        return albumId;
    }

    public void closeConnection() throws SQLException {
        connection.close();
    }
}
