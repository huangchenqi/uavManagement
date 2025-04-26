#include "databaseconnection.h"
#include <QSettings>
#include <QtDebug>
struct sig{
    std::unique_ptr<odb::pgsql::database> db_;

    // sig(    const std::string& user,
    //     const std::string& password,
    //     const std::string& dbname,
    //     const std::string& host,
    //     unsigned int port)
    //     :db_{new odb::pgsql::database(user, password, dbname, host, port)}
    // {
    // }


    static odb::pgsql::database& ins(){
                   // 读取配置文件
        QSettings settings("./configToDataBase.ini", QSettings::IniFormat);
        qDebug() << settings.group();

        // 检查配置文件是否存在
        if (!settings.isWritable()) {
            qDebug() << "配置文件不存在或无法写入";
        } else {
            qDebug() << "配置文件存在并可写入";
        }

        settings.beginGroup("database");
         qDebug()<<"day"<<settings.value("user").toString();//"uav_type_man",
                 qDebug()<<"day"<<settings.value("password").toString();//"uav_type_man",
                 qDebug()<<"day"<<settings.value("dbname").toString();//"db_aux_prac_sys",
                 qDebug()<<"day"<<settings.value("host").toString(); //   "192.168.0.101",
                 qDebug()<<"day"<<settings.value("port").toUInt();//
        static odb::pgsql::database ins{
            settings.value("user").toString().toStdString(),//"uav_type_man",
            settings.value("password").toString().toStdString(),//"uav_type_man",
            settings.value("dbname").toString().toStdString(),//"db_aux_prac_sys",
            settings.value("host").toString().toStdString(), //   "192.168.0.101",
            settings.value("port").toUInt()//    5432
        };
        settings.endGroup();
        return ins;
    }
};

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
    // db_.reset(new odb::pgsql::database(user, password, dbname, host, port));
    // C++11 兼容性：std::make_unique 是 C++14 引入的，而 std::unique_ptr::reset() 和直接使用 new 是 C++11 的标准特性。
    //             将 std::make_unique 替换为 db_.reset(new ...) 或直接在构造函数初始化列表中使用 new。
    // 编译选项：如果希望继续使用 std::make_unique，请确保编译器支持 C++14 并添加编译选项（如 -std=c++14）。
}

odb::pgsql::database& DatabaseConnection::getDatabase() {
    // return *db_;
    return sig::ins();
}
