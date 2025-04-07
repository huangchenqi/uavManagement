#ifndef UAVDATAOPERATIONMODEL_H
#define UAVDATAOPERATIONMODEL_H
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
class UavDataOperationModel
{
public:
    UavDataOperationModel();
    void selectUavData(const QJsonObject& data);
    void updateUavData(const QJsonObject& data);
    void deleteUavData(const QJsonObject& data);
    void insertUavData(const QJsonObject& data);


    //载荷数据管理
    void selectPayLoad();
    void deletePayLoad(const QJsonObject& data);
    void insertPayLoad(const QJsonObject& data);

    //投弹数据管理
    void selectUavBombingmethod();
    void deleteUavBombingmethod(const QJsonObject& data);
    void insertUavBombingmethod(const QJsonObject& data);

    //回收数据管理
    void selectUavRecoverymode();
    void deleteUavRecoverymode(const QJsonObject& data);
    void insertUavRecoverymode(const QJsonObject& data);

    //挂载数据管理
    void selectUavHangingLocation();
    void deleteUavHangingLocation(const QJsonObject& data);
    void insertUavHangingLocation(const QJsonObject& data);

    //操控数据管理
    void selectOperationMethod();
    void deleteOperationMethod(const QJsonObject& data);
    void insertOperationMethod(const QJsonObject& data);
};

#endif // UAVDATAOPERATIONMODEL_H
