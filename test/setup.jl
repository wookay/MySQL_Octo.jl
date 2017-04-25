using MySQL_Octo

adapter = SQL.connect(host="127.0.0.1", user="test", pass="test", db="mysqltest", reconnect=true)

if true
    SQL.execute(adapter, """
    DROP TABLE comments;
    DROP TABLE users; """)
end

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
