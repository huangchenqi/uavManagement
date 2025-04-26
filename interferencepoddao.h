#ifndef INTERFERENCEPODDAO_H
#define INTERFERENCEPODDAO_H

#include "databaseconnection.h"
#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include <QQmlParserStatus>

class InterferencePodDao: public QObject
{
    Q_OBJECT
public:
    InterferencePodDao(QObject* parent = nullptr);//UavModelDao();//explicit UavModelDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectInterferencePodData(const QJsonObject &selectedData);//查询全部数据
    //Q_INVOKABLE QJsonObject selectSomeAmmoData(const QJsonObject &selectedData);//查询某个条件的数据
    Q_INVOKABLE bool updateInterferencePodData(const QJsonObject &selectedData);//更新数据
    Q_INVOKABLE bool deleteInterferencePodData(const QJSValue &selectedData);//删除数据
    //QJsonObject checkAmmoDataObject(const QJsonObject& object);//检查QML界面的数据是否匹配
    Q_INVOKABLE bool insertInterferencePodData(const QJsonObject &selectedData);//插入数据

private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};


#endif // INTERFERENCEPODDAO_H
