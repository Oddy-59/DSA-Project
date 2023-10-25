import ballerina/config;
import ballerina/mysql;

type DataSourceConfiguration record {
    string url;
    string username;
    string password;
};

public function getDatabaseClient() returns (mysql:Client) {
    DataSourceConfiguration config = check getDatabaseConfig();
    mysql:Client dbClient = check new (config);
    return dbClient;
}

private function getDatabaseConfig() returns (DataSourceConfiguration) {
    string dbURL = check config:getAsString("DB_URL");
    string username = check config:getAsString("DB_USERNAME");
    string password = check config:getAsString("DB_PASSWORD");

    DataSourceConfiguration config = {
        url: dbURL,
        username: username,
        password: password
    };

    return config;
}
