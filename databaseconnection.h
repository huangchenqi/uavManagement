#ifndef DATABASECONNECTION_H
#define DATABASECONNECTION_H

#include <odb/pgsql/database.hxx>
#include <memory>

class DatabaseConnection {
public:
    DatabaseConnection(
        const std::string& user,
        const std::string& password,
        const std::string& dbname,
        const std::string& host,
        unsigned int port
        );

    odb::pgsql::database& getDatabase();

private:
    std::unique_ptr<odb::pgsql::database> db_;
};
#endif // DATABASECONNECTION_H
