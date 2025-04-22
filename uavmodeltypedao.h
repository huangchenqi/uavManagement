#ifndef UAVMODELTYPEDAO_H
#define UAVMODELTYPEDAO_H

#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include "databaseconnection.h"
class UavModelTypeDao:public QObject
{
    Q_OBJECT
public:
    UavModelTypeDao(QObject* parent = nullptr);// explicit UavMountLocationDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectUavModelTypeAllData();//查询全部数据
    Q_INVOKABLE QJsonArray queryUavModelTypeData(const QJsonObject &uavModel);
    Q_INVOKABLE bool updateUavModelTypeData(const QJSValue &selectedData);//更新数据
    Q_INVOKABLE bool deleteUavModelTypeData(const QJSValue &selectedData);//删除数据
    Q_INVOKABLE bool insertUavModelTypeData(const QJsonObject& object);//插入数据

private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};

#endif // UAVMODELTYPEDAO_H
