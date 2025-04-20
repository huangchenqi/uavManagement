#ifndef AMMOGUIDANCETYPEDAO_H
#define AMMOGUIDANCETYPEDAO_H
#include "databaseconnection.h"
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include <QQmlParserStatus>
#include <QObject>

class AmmoGuidanceTypeDao: public QObject
{
    Q_OBJECT
public:
    AmmoGuidanceTypeDao(QObject* parent = nullptr);//UavModelDao();//explicit UavModelDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectAmmoGuidanceTypeAllData();//查询全部数据
    Q_INVOKABLE QJsonArray selectSomeAmmoGuidanceTypeData(const QJsonObject& selectedData);//查询某个条件的数据
    Q_INVOKABLE bool updateAmmoGuidanceTypeData(const QJSValue &selectedData);//更新数据
    Q_INVOKABLE bool deleteAmmoGuidanceTypeData(const QJSValue &selectedData);//删除数据
    //QJsonObject checkAmmoDataObject(const QJsonObject& object);//检查QML界面的数据是否匹配
    Q_INVOKABLE bool insertAmmoGuidanceTypeData(const QJsonObject &object);//插入数据
    //void test();
private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};

#endif // AMMOGUIDANCETYPEDAO_H
