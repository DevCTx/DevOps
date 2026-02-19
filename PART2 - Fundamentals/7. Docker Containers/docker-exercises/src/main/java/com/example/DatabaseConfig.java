package com.example;

import com.mysql.cj.jdbc.MysqlDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.SQLException;


@Configuration
public class DatabaseConfig {

//    private String user = System.getenv("DB_USER");
//    private String password = System.getenv("DB_PWD");
//    private String serverName = System.getenv("DB_SERVER"); // db host name, like localhost without the port
//    private String dbName = System.getenv("DB_NAME");
    private final MysqlDataSource datasource;

    public DatabaseConfig() {
        String user = readSecret("/run/secrets/mysql_user");
        String password = readSecret("/run/secrets/mysql_password");
        String serverName = readSecret("/run/secrets/mysql_host_server");
        String dbName = readSecret("/run/secrets/mysql_database");

        datasource = new MysqlDataSource();
        datasource.setUser(user);
        datasource.setPassword(password);
        datasource.setServerName(serverName);
        datasource.setPort(3306); // default config
        datasource.setDatabaseName(dbName);
        datasource.setURL("jdbc:mysql://" + serverName + ":3306/" + dbName);
    }

    private String readSecret(String path) {
        try {
            return Files.readString(Path.of(path)).trim();
        } catch (Exception e) {
            throw new RuntimeException("Unable to read secret: " + path, e);
        }
    }

    @Bean
    public Connection getConnection() throws SQLException {
        return datasource.getConnection();
    }
}
