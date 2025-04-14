#ifndef UAVMODELBOMBINGMETHODDAO_H
#define UAVMODELBOMBINGMETHODDAO_H
#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include "databaseconnection.h"

class UavModelBombingMethodDao:public QObject
{
    Q_OBJECT
public:
    UavModelBombingMethodDao(QObject* parent = nullptr);// explicit UavMountLocationDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectUavModelBombingMethodAllData();//查询全部数据
    Q_INVOKABLE bool updateUavModelBombingMethodDate(const QJSValue &selectedData);//更新数据
    Q_INVOKABLE bool deleteUavModelBombingMethodDate(const QJSValue &selectedData);//删除数据
    Q_INVOKABLE bool insertUavModelBombingMethodDate(const QJsonObject& object);//插入数据

private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};
#endif // UAVMODELBOMBINGMETHODDAO_H
