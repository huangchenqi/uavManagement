#ifndef UAVMODELOPERATIONWAYDAO_H
#define UAVMODELOPERATIONWAYDAO_H

#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include "databaseconnection.h"
class UavModelOperationWayDao:public QObject
{
    Q_OBJECT
public:
    UavModelOperationWayDao(QObject* parent = nullptr);// explicit UavMountLocationDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectModelOperationWayAllData();//查询全部数据
    Q_INVOKABLE bool updateModelOperationWayDate(const QJSValue &selectedData);//更新数据
    Q_INVOKABLE bool deleteModelOperationWayDate(const QJSValue &selectedData);//删除数据
    Q_INVOKABLE bool insertModelOperationWayDate(const QJsonObject& object);//插入数据

private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};

#endif // UAVMODELOPERATIONWAYDAO_H
