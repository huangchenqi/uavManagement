#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include "odb/database.hxx"
#include "odb/pgsql/database.hxx"
//#include "UavModelEntity-odb.hxx"
#include "uavmodeldao.h"
#include "uavmountlocationdao.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    // {
    //     QStringList files = { ":/migrations/001_books.sql" };
    //     Migration migration(Sql::database("data.db"));
    //     if(!migration.run(files))
    //     {
    //         qWarning() << "Create migration table(s) failed in database"
    //                    << migration.connection().databaseName();
    //     }
    // }

    QQmlApplicationEngine engine;


    qmlRegisterType<UavModelDao>("UavDaoModel",1,0,"UavModelDaoTableModel");
    qmlRegisterType<UavMountLocationDao>("UavMountLocationDaoModel",1,0,"UavMountLocationDaoTableModel");
    //qmlRegisterType<TableModel>("Macai.App", 1, 0, "SqlTableModel");
    const QUrl url(QStringLiteral("qrc:/main.qml"));//mainUavDataTableView.qmlUavManageCommon
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    // UavModelDao dao;
    // QJsonObject obj;
    // dao.checkUavDataObject(obj);
    // dao.test();
    return app.exec();
}
