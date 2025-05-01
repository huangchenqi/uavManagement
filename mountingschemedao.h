#ifndef MOUNTINGSCHEMEDAO_H
#define MOUNTINGSCHEMEDAO_H

#include "databaseconnection.h"
#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include <QQmlParserStatus>

class MountingSchemeDao: public QObject
{
    Q_OBJECT
public:
    MountingSchemeDao(QObject* parent = nullptr);//UavModelDao();//explicit UavModelDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectMountingSchemeData(const QJsonObject &selectedData);//查询全部数据
    Q_INVOKABLE QJsonObject queryMountingSchemeData(const QJsonObject &selectedData);//查询某个条件的数据
    Q_INVOKABLE bool updateMountingSchemeData(const QJsonObject &selectedData);//更新数据
    Q_INVOKABLE bool deleteMountingSchemeData(const QJSValue &selectedData);//删除数据
    //QJsonObject checkAmmoDataObject(const QJsonObject& object);//检查QML界面的数据是否匹配
    Q_INVOKABLE bool insertMountingSchemeData(const QJsonObject &object);//插入数据

private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};

#endif // MOUNTINGSCHEMEDAO_H
