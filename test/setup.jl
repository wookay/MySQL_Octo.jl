using MySQL_Octo

HOST = "127.0.0.1"

if true
    adapter = SQL.connect(host=HOST, user="root", pass="", reconnect=true)
    SQL.execute(adapter, """
    DROP DATABASE IF EXISTS mysqltest;
    GRANT USAGE ON *.* TO 'test'@'127.0.0.1' IDENTIFIED BY 'test';
    DROP USER 'test'@'127.0.0.1';
    """)
    SQL.execute(adapter, """
    CREATE DATABASE mysqltest;
    CREATE USER test@$HOST IDENTIFIED BY 'test';
    GRANT ALL ON mysqltest.* TO 'test'@$HOST;
    FLUSH PRIVILEGES;
    """)
    SQL.disconnect(adapter)
end

adapter = SQL.connect(host=HOST, user="test", pass="test", db="mysqltest", reconnect=true)

SQL.execute(adapter, """
CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(20),
    PRIMARY KEY (id)
);
CREATE TABLE comments (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT,
    body VARCHAR(300),
    FOREIGN KEY (user_id) REFERENCES users(id),
    PRIMARY KEY (id)
); """)

SQL.execute(adapter, "INSERT INTO users (name) VALUES ('John');")
