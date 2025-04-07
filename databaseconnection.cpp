#include "databaseconnection.h"

DatabaseConnection::DatabaseConnection(
    const std::string& user,
    const std::string& password,
    const std::string& dbname,
    const std::string& host,
    unsigned int port
    )//: db_(new odb::pgsql::database(user, password, dbname, host, port)) {}//第二种实现方法。在构造函数初始化列表中直接初始化。
{//第一种实现方法
    //db_ = std::make_unique<odb::pgsql::database>(user, password, dbname, host, port);//这个要使用C++14版本
    // 使用 reset + new 替代 make_unique（兼容 C++11）
    db_.reset(new odb::pgsql::database(user, password, dbname, host, port));
    // C++11 兼容性：std::make_unique 是 C++14 引入的，而 std::unique_ptr::reset() 和直接使用 new 是 C++11 的标准特性。
    //             将 std::make_unique 替换为 db_.reset(new ...) 或直接在构造函数初始化列表中使用 new。
    // 编译选项：如果希望继续使用 std::make_unique，请确保编译器支持 C++14 并添加编译选项（如 -std=c++14）。
}

odb::pgsql::database& DatabaseConnection::getDatabase() {
    return *db_;
}
