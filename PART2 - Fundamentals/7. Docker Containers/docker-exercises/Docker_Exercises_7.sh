Exercise 7

Secure all with 

import java.nio.file.Files;
import java.nio.file.Path;

private String readSecret(String path) {
    try {
        return Files.readString(Path.of(path)).trim();
    } catch (Exception e) {
        throw new RuntimeException(e);
    }
}

private String user = readSecret("/run/secrets/mysql_user");
private String password = readSecret("/run/secrets/mysql_password");
private String serverName = readSecret("/run/secrets/mysql_host_server");
private String dbName = readSecret("/run/secrets/mysql_database");


et

js-app:
        environment:            
            - DB_USER=/run/secrets/mysql_user
            - DB_PWD=/run/secrets/mysql_password
            - MYSQL_HOST_SERVER_FILE=/run/secrets/mysql_host_server
            - DB_NAME=/run/secrets/mysql_database


peut être utiliser des variables d'environnements qui reprennent la valeur des secrets?


PENSER A SUPPRIMER LES SERVEURS SUR DIGITAL A LA FIN !!!
