#ifndef AMMODAO_H
#define AMMODAO_H
#include "databaseconnection.h"
#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include <QQmlParserStatus>
class AmmoDao: public QObject
{
    Q_OBJECT
public:
    AmmoDao(QObject* parent = nullptr);//UavModelDao();//explicit UavModelDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectAmmoAllData();//查询全部数据
    Q_INVOKABLE QJsonObject selectSomeAmmoDate(const QJSValue &selectedData);//查询某个条件的数据
    Q_INVOKABLE bool updateAmmoDate(const QJSValue &selectedData);//更新数据
    Q_INVOKABLE bool deleteAmmoDate(const QJSValue &selectedData);//删除数据
    //QJsonObject checkAmmoDataObject(const QJsonObject& object);//检查QML界面的数据是否匹配
    Q_INVOKABLE bool insertAmmoDate(const QJSValue &selectedData);//插入数据
    void test();
private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};
#endif // AMMODAO_H
