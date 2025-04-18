#ifndef UAVMOUNTLOCATIONDAO_H
#define UAVMOUNTLOCATIONDAO_H

#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include "databaseconnection.h"
class UavMountLocationDao:public QObject
{
    Q_OBJECT
public:
        UavMountLocationDao(QObject* parent = nullptr);// explicit UavMountLocationDao(QObject *parent = 0);
        Q_INVOKABLE QJsonArray selectUavMountLocationAllData();//查询全部数据
        Q_INVOKABLE QJsonArray queryUavToMountData(const QJsonObject &uavModel);
        Q_INVOKABLE bool updateUavMountLocationDate(const QJSValue &selectedData);//更新数据
        Q_INVOKABLE bool deleteUavMountLocationDate(const QJSValue &selectedData);//删除数据
        Q_INVOKABLE bool insertUavMountLocationDate(const QJsonObject& object);//插入数据

private:
        std::unique_ptr<DatabaseConnection> dbConn_;
};

#endif // UAVMOUNTLOCATIONDAO_H
