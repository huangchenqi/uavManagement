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
    Q_INVOKABLE QJsonArray selectAmmoTypeAllData();//查询全部数据
    Q_INVOKABLE QJsonArray queryAmmoTypeData(const QJsonObject &uavModel);
    Q_INVOKABLE bool updateAmmoTypeData(const QJSValue &selectedData);//更新数据
    Q_INVOKABLE bool deleteAmmoTypeData(const QJSValue &selectedData);//删除数据
    Q_INVOKABLE bool insertAmmoTypeData(const QJsonObject& object);//插入数据

private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};

#endif // AMMOTYPEDAO_H
