#ifndef UAVMODELLOADTYPEDAO_H
#define UAVMODELLOADTYPEDAO_H

#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include "databaseconnection.h"
class UavModelLoadTypeDao:public QObject
{
    Q_OBJECT
public:
    UavModelLoadTypeDao(QObject* parent = nullptr);// explicit UavMountLocationDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectUavModelLoadTypeAllData();//查询全部数据
    Q_INVOKABLE bool updateUavModelLoadTypeDate(const QJSValue &selectedData);//更新数据
    Q_INVOKABLE bool deleteUavModelLoadTypeDate(const QJSValue &selectedData);//删除数据
    Q_INVOKABLE bool insertUavModelLoadTypeDate(const QJsonObject& object);//插入数据

private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};

#endif // UAVMODELLOADTYPEDAO_H
