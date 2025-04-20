#ifndef AMMOATTACKTARGETDAO_H
#define AMMOATTACKTARGETDAO_H

#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include "databaseconnection.h"
class AmmoAttackTargetDao:public QObject
{
    Q_OBJECT
public:
    AmmoAttackTargetDao(QObject* parent = nullptr);// explicit UavMountLocationDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectAmmoAttackTargetAllData();//查询全部数据
    Q_INVOKABLE QJsonArray queryAmmoAttackTargetData(const QJsonObject &uavModel);
    Q_INVOKABLE bool updateAmmoAttackTargetData(const QJSValue &selectedData);//更新数据
    Q_INVOKABLE bool deleteAmmoAttackTargetData(const QJSValue &selectedData);//删除数据
    Q_INVOKABLE bool insertAmmoAttackTargetData(const QJsonObject& object);//插入数据
private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};

#endif // AMMOATTACKTARGETDAO_H
