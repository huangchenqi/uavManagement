#ifndef UAVMODELRECOVERYMODEDAO_H
#define UAVMODELRECOVERYMODEDAO_H
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include "databaseconnection.h"
#include <QObject>

class UavModelRecoveryModeDao:public QObject
{
    Q_OBJECT
public:
    UavModelRecoveryModeDao(QObject* parent = nullptr);// explicit UavMountLocationDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectModelRecoveryModeAllData();//查询全部数据
    Q_INVOKABLE bool updateModelRecoveryModeDate(const QJSValue &selectedData);//更新数据
    Q_INVOKABLE bool deleteModelRecoveryModeDate(const QJSValue &selectedData);//删除数据
    Q_INVOKABLE bool insertModelRecoveryModeDate(const QJsonObject& object);//插入数据

private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};

#endif // UAVMODELRECOVERYMODEDAO_H
