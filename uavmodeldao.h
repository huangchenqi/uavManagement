#ifndef UAVMODELDAO_H
#define UAVMODELDAO_H
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QQmlParserStatus>
#include <QObject>
#include <QHash>
#include <QJSValue>
#include "databaseconnection.h"
class UavModelDao: public QObject
{
    Q_OBJECT
public:
    UavModelDao(QObject* parent = nullptr);//UavModelDao();//explicit UavModelDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectUavModelAllData();//查询全部数据
    Q_INVOKABLE QJsonArray queryUavModelData(const QString &jsonStr);//查询条件数据
    Q_INVOKABLE QJsonArray transformQueryAllData();
    QHash<QString,QString>createIdMap(const QJsonArray &bArray);
    QJsonArray ProcessUavComponentWay(const QString &uavComponent,const QHash<QString,QString> &idMap);
    Q_INVOKABLE QJsonArray processData(const QJsonArray &aArray,const QHash<QString,QString> &idMap);
    Q_INVOKABLE QJsonObject selectSomeUavModelDate(const QString &jsonStr);//查询某个条件的数据
    Q_INVOKABLE bool updateModelDate(const QString &jsonStr);//更新数据
    Q_INVOKABLE bool deleteModelDate(const QJsonArray& object);//删除数据
    QJsonObject checkUavDataObject(const QJsonObject& object);//检查QML界面的数据是否匹配
    Q_INVOKABLE bool insertModelDate(const QJsonObject& object);//插入数据
    void test();
private:
    std::unique_ptr<DatabaseConnection> dbConn_;

};

#endif // UAVMODELDAO_H
