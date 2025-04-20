#ifndef AMMOTYPEDAO_H
#define AMMOTYPEDAO_H
#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include "databaseconnection.h"
class AmmoTypeDao:public QObject
{
    Q_OBJECT
public:
    AmmoTypeDao(QObject* parent = nullptr);// explicit UavMountLocationDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectAmmoLaunchWayAllData();//查询全部数据
    Q_INVOKABLE QJsonArray queryAmmoLaunchWayData(const QJsonObject &uavModel);
    Q_INVOKABLE bool updateAmmoLaunchWayData(const QJSValue &selectedData);//更新数据
    Q_INVOKABLE bool deleteAmmoLaunchWayData(const QJSValue &selectedData);//删除数据
    Q_INVOKABLE bool insertAmmoLaunchWayData(const QJsonObject& object);//插入数据

private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};

#endif // AMMOTYPEDAO_H
