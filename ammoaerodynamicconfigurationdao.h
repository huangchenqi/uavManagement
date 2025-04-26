#ifndef AMMOAERODYNAMICCONFIGURATIONDAO_H
#define AMMOAERODYNAMICCONFIGURATIONDAO_H

#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include "databaseconnection.h"

class AmmoAerodynamicConfigurationDao:public QObject
{
    Q_OBJECT
public:
    AmmoAerodynamicConfigurationDao(QObject* parent = nullptr);// explicit UavMountLocationDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectAmmoAerodynamicConfigurationAllData();//查询全部数据
    Q_INVOKABLE QJsonArray queryAmmoAerodynamicConfigurationData(const QJsonObject &uavModel);
    Q_INVOKABLE bool updateAmmoAerodynamicConfigurationData(const QJSValue &selectedData);//更新数据
    Q_INVOKABLE bool deleteAmmoAerodynamicConfigurationData(const QJSValue &selectedData);//删除数据
    Q_INVOKABLE bool insertAmmoAerodynamicConfigurationData(const QJsonObject& object);//插入数据
private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};


#endif // AMMOAERODYNAMICCONFIGURATIONDAO_H
