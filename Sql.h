#ifndef SQL_H
#define SQL_H
#include <QStringList>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QFile>
#include <QThreadStorage>
#include <QUuid>
#include <QDebug>

const QString DRIVER = "QSQLITE";
static QThreadStorage<QSqlDatabase> databasePool;

namespace Sql
{
static QSqlDatabase database(const QString &databaseName = QString(), bool open = true)
{
    QSqlDatabase db;

    if(!databasePool.hasLocalData())
    {
        QString connName = QUuid::createUuid().toString(QUuid::Id128);
        db = QSqlDatabase::addDatabase(DRIVER, connName);
        if(!databaseName.isEmpty())
            db.setDatabaseName(databaseName);
        if(open)
            db = QSqlDatabase::database(connName, open);
        databasePool.setLocalData(db);
    }
    db = databasePool.localData();
    return db;
}

static QSqlDatabase connection(const QString &connectionName)
{
    if(connectionName.isEmpty())
        return QSqlDatabase::database(QSqlDatabase::defaultConnection, true);

    return QSqlDatabase::database(connectionName, true);
}

static QSqlDatabase connection()
{
    QString connectionName = QUuid::createUuid().toString(QUuid::Id128);
    return QSqlDatabase::database(connectionName, true);
}
} // namespace Sql
#endif // SQL_H
