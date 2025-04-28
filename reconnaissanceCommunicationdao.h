#ifndef RECONNAISSANCECOMMUNICATIONDAO_H
#define RECONNAISSANCECOMMUNICATIONDAO_H

#include "databaseconnection.h"
#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include <QQmlParserStatus>

class ReconnaissanceCommunicationDao: public QObject
{
    Q_OBJECT
public:
    ReconnaissanceCommunicationDao(QObject* parent = nullptr);//UavModelDao();//explicit UavModelDao(QObject *parent = 0);
    Q_INVOKABLE QJsonArray selectReconnaissanceCommunicationData(const QJsonObject &object);//查询全部数据
    Q_INVOKABLE QJsonObject queryReconnaissanceCommunicationData(const QJsonObject &object);//查询某个条件的数据
    Q_INVOKABLE bool updateReconnaissanceCommunicationData(const QJsonObject &object);//更新数据
    Q_INVOKABLE bool deleteReconnaissanceCommunicationData(const QJSValue &selectedData);//删除数据
    //QJsonObject checkAmmoDataObject(const QJsonObject& object);//检查QML界面的数据是否匹配
    Q_INVOKABLE bool insertReconnaissanceCommunicationData(const QJsonObject &object);//插入数据

private:
    std::unique_ptr<DatabaseConnection> dbConn_;
};

#endif // RECONNAISSANCECOMMUNICATIONDAO_H
