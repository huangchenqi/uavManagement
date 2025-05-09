#include "uavmodeldao.h"
#include "uavmodelbombingmethoddao.h"
#include "uavmodelloadtypedao.h"
#include "uavmodelrecoverymodedao.h"
#include "uavmodeloperationwaydao.h"
#include "uavmountlocationdao.h"
#include "uavmodeltypedao.h"
#include "odb/pgsql/database.hxx"
#include <vector>
#include <stdexcept>
#include <iostream>

// ODB 头文件
#include <odb/database.hxx>
#include <odb/transaction.hxx>
#include <odb/query.hxx>
#include <odb/pgsql/database.hxx>
#include "databaseconnection.h"
#include "odb/pgsql/traits.hxx"
#include <QJsonObject>
#include <QJsonValue>
#include <QStringList>
#include <QDebug>
#include "json.hpp"
#include <QUrl>
#include <QTemporaryFile>
#include <QFile>
#include <QDebug>
#include <QImage>
#include "AmmunitionEntity-odb.hxx"
#include "UavModelEntity-odb.hxx"
#include "uavmodelentity-odb.hxx"
#include "UavModelLoadTypeEntity-odb.hxx"
#include "UavModelBombingMethodEntity-odb.hxx"
#include "UavModelMountLocationEntity-odb.hxx"
#include "UavModelRecoveryModeEntity-odb.hxx"
#include "UavModelOperationWayEntity-odb.hxx"
#include "UavModelTypeEntity-odb.hxx"

namespace nl = nlohmann;

QDateTime covert(unsigned long long i){
    const QDateTime pg_epoch (QDate (2000, 1, 1), QTime (0, 0, 0));
    return pg_epoch.addMSecs (
        static_cast <qint64> (odb::pgsql::details::endian_traits::ntoh (i) / 1000LL));
}
struct order{
    template<typename T>
    static odb::query<T> by(::std::string column, ::std::string p = "DESC"){
        return odb::query<T>{"order by "} + column + p;
    }
};
UavModelDao::UavModelDao(QObject* parent) : QObject(parent){ //::UavModelDao() {
    // 使用 C++11 兼容的写法初始化数据库连接（参数可配置化）
    dbConn_.reset(new DatabaseConnection(
        "uav_type_man",
        "uav_type_man",
        "db_aux_prac_sys",
        "192.168.0.101",
        5432
        ));
    // C++14初始化数据库连接（参数可配置化）
    // dbConn_ = std::make_unique<DatabaseConnection>(
    //     "postgres",
    //     "123456",
    //     "db_aux_prac_sys",
    //     "192.168.0.101",
    //     5432
    //     );
} //UavModelDao::UavModelDao(QObject *parent) : QObject(parent){}

// struct load{
// private:
//     odb::pgsql::database& db_;
// public:
//     load(odb::pgsql::database& db):db_{db}{}

//     template<typename T>
//     QVector<T> from(QString fileds){
//         QVector<T> rst;
//         for(auto&& id_ : fileds.split(",")){
//             auto id{id_.toLong()};
//             auto pload{db_.load<T>(id)};
//             if(pload) rst.push_back(*pload);
//         }
//         return rst;
//     }
// };

template<typename T>
struct traits{
    using query_t = odb::query<T>;
    static T* load(odb::pgsql::database& db,typename odb::object_traits<T>::id_type id){
        return db.query_one<T>(query_t::id == id);
    }
};

// template<>
// struct traits<UavModelMountLocationEntity>{
//     template<typename I>
//     static UavModelMountLocationEntity* load(odb::pgsql::database& db,I&& id){
//         using query_t = odb::query<UavModelMountLocationEntity>;
//         return db.query_one<UavModelMountLocationEntity>(query_t::mountLocationId == id);
//     }
// };

struct load{
private:
    odb::pgsql::database& db_;
public:
    load(odb::pgsql::database& db):db_{db}{}

    template<typename T>
    QVector<T> from(QString fileds){
        QVector<T> rst;
        for(auto&& id_ : fileds.split(",")){
            auto id{id_.toLong()};
            // auto pload{db_.load<T>(id)};
            auto pload{traits<T>::load(db_,id)};
            if(pload) rst.push_back(*pload);
        }
        return rst;
    }
};
QJsonArray UavModelDao::selectUavModelAllData()
{
    QJsonArray uavModelData;
    //std::vector<person> persons;

    try{
    //using query_t = odb::query<UavModelEntity>;
    // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        // odb::pgsql::database db(
        //     "postgres",       // username
        //     "123456",         // password
        //     "db_aux_prac_sys",// database
        //     "192.168.0.101",  // host
        //     5432              // port
        //     );
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction select all started";
        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<UavModelEntity>;

        odb::result<UavModelEntity> result = db.query<UavModelEntity>(query_t::true_expr + order::by<UavModelEntity>(query_t::uavCreatModelTime.column()));
        qDebug() << "Query returned" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        int sum = 1;
        bool checked = false;
        if(result.size()==0){
            return uavModelData;
        }

        for (UavModelEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "Processing record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["uavName"] = QString::fromStdString(entity.uavName_);
            obj["uavType"] = QString::fromStdString(entity.uavType_);
            obj["uavId"] = [&db,&entity](){
                auto loaded{load{db}.from<UavModelTypeEntity>(QString::fromStdString(entity.uavId_))};
                QJsonArray arr;
                for(auto load: loaded){
                    //qDebug() << "loaded: " << load.ammoName_.c_str();
                    arr.append(QString::fromStdString(load.uavModelTypeName_));
                }
                return QJsonValue{arr};
            }();
            obj["origHangingCapacity"] = QString::fromStdString(entity.uavHangingLoctionCapacity_);
            obj["hangingCapacity"] = [&db,&entity](){
                    auto loaded{load{db}.from<UavModelMountLocationEntity>(QString::fromStdString(entity.uavHangingLoctionCapacity_))};
                    QJsonArray arr;
                    for(auto load: loaded){
                        //qDebug() << "loaded: " << load.ammoName_.c_str();
                        arr.append(QString::fromStdString(load.mountLocationName_));
                    }
                    return QJsonValue{arr};
                }();
            obj["uavLoadAmmoType"] = [&db,&entity](){
                auto loaded{load{db}.from<AmmunitionEntity>(QString::fromStdString(entity.uavLoadAmmoType_))};
                QJsonArray arr;
                for(auto load: loaded){
                    //qDebug() << "loaded: " << load.ammoName_.c_str();
                    arr.append(QString::fromStdString(load.ammoName_));
                }
                return QJsonValue{arr};
            }();
            obj["payloadType"] = [&db,&entity](){//QString::fromStdString(entity.uavInvestigationPayloadType_);

                auto loaded{load{db}.from<UavModelLoadTypeEntity>(QString::fromStdString(entity.uavInvestigationPayloadType_))};
                QJsonArray arr;
                for(auto load: loaded){
                    //qDebug() << "loaded: " << load.ammoName_.c_str();
                    arr.append(QString::fromStdString(load.loadTypeName_));
                }
                return QJsonValue{arr};
            }();
            obj["bombMethod"] = //QString::fromStdString(entity.uavBombingway_);
                [&db,&entity](){//
                auto loaded{load{db}.from<UavModelBombingMethodEntity>(QString::fromStdString(entity.uavBombingway_))};
                QJsonArray arr;
                for(auto load: loaded){
                    //qDebug() << "loaded: " << load.ammoName_.c_str();
                    arr.append(QString::fromStdString(load.bombingMethodName_));
                }
                return QJsonValue{arr};
            }();
            obj["recoveryMode"] = //QString::fromStdString(entity.uavRecoveryway_);
                [&db,&entity](){
                auto loaded{load{db}.from<UavModelRecoveryModeEntity>(QString::fromStdString(entity.uavRecoveryway_))};
                QJsonArray arr;
                for(auto load: loaded){
                    //qDebug() << "loaded: " << load.ammoName_.c_str();
                    arr.append(QString::fromStdString(load.recoveryWayName_));
                }
                return QJsonValue{arr};
            }();
            obj["operationMethod"] = //QString::fromStdString(entity.uavOperationWay_);
                [&db,&entity](){
                auto loaded{load{db}.from<UavModelOpreationWayEntity>(QString::fromStdString(entity.uavOperationWay_))};
                QJsonArray arr;
                for(auto load: loaded){
                    //qDebug() << "loaded: " << load.ammoName_.c_str();
                    arr.append(QString::fromStdString(load.operationWayName_));
                }
                return QJsonValue{arr};
            }();
            // 使用 QDateTime 转换 std::time_t 到 QString

            // QDateTime dateTime;
            // dateTime = entity.uavCreatModelTime_;
            qDebug() <<"uavCreatModelTime_"<< entity.uavCreatModelTime_;
            QString originalDateTime = entity.uavCreatModelTime_.toString(Qt::ISODate);

            // 解析原始日期时间字符串
            QDateTime dateTime = QDateTime::fromString(originalDateTime, "yyyy-MM-ddTHH:mm:ss");
            QString formattedDateTime;
            // 检查解析是否成功
            if (dateTime.isValid()) {
                // 转换为指定格式
                formattedDateTime = dateTime.toString("yyyy-MM-dd HH:mm:ss");
                qDebug() << "Formatted Date and Time:" << formattedDateTime;
            } else {
                qDebug() << "Invalid date time string";
            }
            obj["uavCreatModelTime"] = formattedDateTime;
            obj["imageUrl"] = QString::fromStdString(entity.uavImgUrl_);

            obj["operation"] = "";
            obj["checked"] = checked;
            sum++;
            qDebug()<<"uavModelAllDatauavcreat:";
            uavModelData.append(obj);
        }
        trans.commit();
    }
    catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        throw; // 或返回包含错误信息的 JSON
    }
    QJsonDocument doc(uavModelData);
    qDebug()<<"当前函数名称bbbbbbbbbbbbb:" << __FUNCTION__<<":";
    qDebug().noquote() << doc.toJson(QJsonDocument::Indented);
    return uavModelData;

}

QJsonArray UavModelDao::queryUavModelData(const QString &jsonStr)
{
    QJsonArray queryUavModelArray;
    QJsonObject uavModelData,object;
    // 将 JSON 字符串转换为 QJsonObject
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonStr.toUtf8());
    if (jsonDoc.isObject()) {
        object = jsonDoc.object();
        qDebug() << "Received JSON object:" << object;

    } else {
        qDebug() << "Invalid JSON format";
    }

    using query_t = odb::query<UavModelEntity>;
    // 1. 建立数据库连接
    qDebug() << "Connecting to database...";

    auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

    // 2. 创建事务
    odb::transaction trans(db.begin());
    qDebug() << "Transaction started";
    try {

        // 3. 从JSON创建实体对象
        UavModelEntity entity;

        query_t q(query_t::true_expr); // 初始化为无条件
        // if (object.contains("recordId") && object["recordId"].isString()) {
        //     auto uav_recordId = object["recordId"].toString();
        //     q = q && (query_t::id == uav_recordId.toInt());
        // }


        // 执行查询
        // auto r(db.query_one<UavModelEntity>(q));
        // if(r){
        //     auto val{r};
        //     // uavModelData = val;
        //     nl::json json{*val};
        //     qDebug() << QString::fromStdString(json.dump());
        // }
        // 执行查询
        //auto result = db.query_one<UavModelEntity>(q);
        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<UavModelEntity>;
        if (object["uavType"] == "全部"){
            qDebug()<<"查询全部无人机类型";
        }else{
            if (object.contains("uavType") && object["uavType"].isString()) {
                auto uav_type = object["uavType"].toString();
                q = q && (query_t::uavType == uav_type.toStdString());
            }
        }
        if (object["uavName"] == ""){
            qDebug()<<"查询全部无人机名称";
        }else{
            // 处理 name 字段（使用 == 条件）
            if (object.contains("uavName") && object["uavName"].isString()) {
                QString uav_name = object["uavName"].toString();
                if (!uav_name.isEmpty()) {
                    q = q && (query_t::uavName == uav_name.toStdString());
                }
            }
        }
        if (object["uavId"] == ""){
            qDebug()<<"查询全部无人机型号";
        }else{
            if (object.contains("uavId") && object["uavId"].isString()) {
                QString uav_id = object["uavId"].toString();
                if (!uav_id.isEmpty()) {
                    q = q && (query_t::uavId == uav_id.toStdString());
                }
            }
        }
        odb::result<UavModelEntity> result = db.query<UavModelEntity>(q + order::by<UavModelEntity>(query_t::uavCreatModelTime.column()));
        qDebug() << "Query returned" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        int sum = 0;
        bool checked = false;
        if(result.size()==0){
            return queryUavModelArray;
        }

        for (UavModelEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "Processing record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["uavId"] = [&db,&entity](){
                auto loaded{load{db}.from<UavModelTypeEntity>(QString::fromStdString(entity.uavId_))};
                QJsonArray arr;
                for(auto load: loaded){
                    //qDebug() << "loaded: " << load.ammoName_.c_str();
                    arr.append(QString::fromStdString(load.uavModelTypeName_));
                }
                return QJsonValue{arr};
            }();
            obj["uavName"] = QString::fromStdString(entity.uavName_);
            obj["uavType"] = QString::fromStdString(entity.uavType_);
            obj["origHangingCapacity"] = QString::fromStdString(entity.uavHangingLoctionCapacity_);
            obj["hangingCapacity"] = [&db,&entity](){//QString::fromStdString(entity.uavHangingLoctionCapacity_);
                auto loaded{load{db}.from<UavModelMountLocationEntity>(QString::fromStdString(entity.uavHangingLoctionCapacity_))};
                QJsonArray arr;
                for(auto load: loaded){

                    arr.append(QString::fromStdString(load.mountLocationName_));
                }
                return QJsonValue{arr};
            }();
            obj["uavLoadAmmoType"] = [&db,&entity](){
                auto loaded{load{db}.from<AmmunitionEntity>(QString::fromStdString(entity.uavLoadAmmoType_))};
                QJsonArray arr;
                for(auto load: loaded){
                    //qDebug() << "loaded: " << load.ammoName_.c_str();
                    arr.append(QString::fromStdString(load.ammoName_));
                }
                return QJsonValue{arr};
            }();
            obj["payloadType"] = [&db,&entity](){//QString::fromStdString(entity.uavInvestigationPayloadType_);

                auto loaded{load{db}.from<UavModelLoadTypeEntity>(QString::fromStdString(entity.uavInvestigationPayloadType_))};
                QJsonArray arr;
                for(auto load: loaded){
                    //qDebug() << "loaded: " << load.ammoName_.c_str();
                    arr.append(QString::fromStdString(load.loadTypeName_));
                }
                return QJsonValue{arr};
            }();
            obj["bombMethod"] = //QString::fromStdString(entity.uavBombingway_);
                [&db,&entity](){//
                    auto loaded{load{db}.from<UavModelBombingMethodEntity>(QString::fromStdString(entity.uavBombingway_))};
                    QJsonArray arr;
                    for(auto load: loaded){
                        //qDebug() << "loaded: " << load.ammoName_.c_str();
                        arr.append(QString::fromStdString(load.bombingMethodName_));
                    }
                    return QJsonValue{arr};
                }();
            obj["recoveryMode"] = //QString::fromStdString(entity.uavRecoveryway_);
                [&db,&entity](){
                    auto loaded{load{db}.from<UavModelRecoveryModeEntity>(QString::fromStdString(entity.uavRecoveryway_))};
                    QJsonArray arr;
                    for(auto load: loaded){
                        //qDebug() << "loaded: " << load.ammoName_.c_str();
                        arr.append(QString::fromStdString(load.recoveryWayName_));
                    }
                    return QJsonValue{arr};
                }();
            obj["operationMethod"] = //QString::fromStdString(entity.uavOperationWay_);
                [&db,&entity](){
                    auto loaded{load{db}.from<UavModelOpreationWayEntity>(QString::fromStdString(entity.uavOperationWay_))};
                    QJsonArray arr;
                    for(auto load: loaded){
                        //qDebug() << "loaded: " << load.ammoName_.c_str();
                        arr.append(QString::fromStdString(load.operationWayName_));
                    }
                    return QJsonValue{arr};
                }();
            // 使用 QDateTime 转换 std::time_t 到 QString

            // QDateTime dateTime;
            // dateTime = entity.uavCreatModelTime_;
            qDebug() <<"uavCreatModelTime_"<< entity.uavCreatModelTime_;
            QString originalDateTime = entity.uavCreatModelTime_.toString(Qt::ISODate);

            // 解析原始日期时间字符串
            QDateTime dateTime = QDateTime::fromString(originalDateTime, "yyyy-MM-ddTHH:mm:ss");
            QString formattedDateTime;
            // 检查解析是否成功
            if (dateTime.isValid()) {
                // 转换为指定格式
                formattedDateTime = dateTime.toString("yyyy-MM-dd HH:mm:ss");
                qDebug() << "Formatted Date and Time:" << formattedDateTime;
            } else {
                qDebug() << "Invalid date time string";
            }
            obj["uavCreatModelTime"] = formattedDateTime;
            //obj["uavCreatModelTime"] = entity.uavCreatModelTime_.toString(Qt::ISODate);
            obj["operation"] = "";
            obj["checked"] = checked;
            sum++;
            qDebug()<<"uavModelAllDatauavcreat:";
            queryUavModelArray.append(obj);
        }
        trans.commit();
    } catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        trans.rollback(); // 显式回滚事务（可选）
        throw; // 重新抛出异常或返回空结果
    }
    return queryUavModelArray;
}

QJsonArray UavModelDao::queryUavModelPartData()
{
    QJsonArray uavModelData;
    //std::vector<person> persons;

    try{
        //using query_t = odb::query<UavModelEntity>;
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction select all started";
        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<UavModelEntity>;

        odb::result<UavModelEntity> result = db.query<UavModelEntity>(query_t::true_expr + order::by<UavModelEntity>(query_t::uavCreatModelTime.column()));
        qDebug() << "Query returned" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        int sum = 1;
        bool checked = false;
        if(result.size()==0){
            return uavModelData;
        }

        for (UavModelEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "Processing record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["uavId"] = QString::fromStdString(entity.uavId_);
            obj["uavName"] = QString::fromStdString(entity.uavName_);
            obj["uavType"] = QString::fromStdString(entity.uavType_);
            obj["checked"] = checked;
            sum++;
            qDebug()<<"uavModelAllDatauavcreat:";
            uavModelData.append(obj);
        }
        trans.commit();
    }
    catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        throw; // 或返回包含错误信息的 JSON
    }
    QJsonDocument doc(uavModelData);
    qDebug()<<"当前函数名称:" << __FUNCTION__<<":";
    qDebug().noquote() << doc.toJson(QJsonDocument::Indented);
    return uavModelData;
}

QJsonObject UavModelDao::queryMountSchemeToUavMod(const QJsonObject &object)
{
    QJsonObject mountSchemData;

    using query_t = odb::query<UavModelEntity>;
    // 1. 建立数据库连接
    qDebug() << "Connecting to database...";

    auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

    // 2. 创建事务
    odb::transaction trans(db.begin());
    qDebug() << "Transaction started";
    try {

        // 3. 从JSON创建实体对象
        UavModelEntity entity;

        query_t q(query_t::true_expr); // 初始化为无条件
        if (object.contains("recordId") && object["recordId"].isString()) {
            auto uav_recordId = object["recordId"].toString();
            q = q && (query_t::id == uav_recordId.toInt());
        }

        // 执行查询
        auto result = db.query_one<UavModelEntity>(q);
        if (result) {
            const UavModelEntity& entity = *result;

            // 手动转换每个字段到QJsonObject// 基础字段
            mountSchemData["uavRecordId"] = QString::number(entity.id_);
            mountSchemData["uavId"] = QString::fromStdString(entity.uavId_);
            mountSchemData["uavType"] = QString::fromStdString(entity.uavType_);
            mountSchemData["uavName"] = QString::fromStdString(entity.uavName_);
            // 处理数值类型（示例）/******************** 尺寸参数 ********************/
            if(!entity.uavLength_){
                mountSchemData["uavLength"] = "";
            }else{
               mountSchemData["uavLength"] = QString::number(entity.uavLength_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavWidth_){
                mountSchemData["uavWidth"] = "";
            }else{
                mountSchemData["uavWidth"] = QString::number(entity.uavWidth_.get());
            }
            if(!entity.uavHeight_){
                mountSchemData["uavHeight"] = "";
            }else{
                mountSchemData["uavHeight"] = QString::number(entity.uavHeight_.get());
            }
            mountSchemData["load_ammo_type"] = QString::fromStdString(entity.uavLoadAmmoType_);
            // 格式化为字符串（保留5位小数）
            // QString formattedValue = QString::number(entity.uavLength_, 'f', 5);
            // mountSchemData["uavLengthhangingCapacityStr"] = formattedValue;
            /******************** 飞行性能 ********************/
            // mountSchemData["flight_height_min"] = QString::number(entity.uavFlightHeightRangeMin_);
            // mountSchemData["flight_height_max"] = QString::number(entity.uavFlightHeightRangeMax_) ;

            if(!entity.uavFlightSpeedRangeMin_){
                mountSchemData["flight_speed_min"] = "";
            }else{
                mountSchemData["flight_speed_min"] = QString::number(entity.uavFlightSpeedRangeMin_.get());
            }
            if(!entity.uavFlightSpeedRangeMax_){
                mountSchemData["flight_speed_max"] = "";
            }else{
                mountSchemData["flight_speed_max"] = QString::number(entity.uavFlightSpeedRangeMax_.get());
            }
            // mountSchemData["flight_distance_min"] = QString::number(entity.uavFlightDistanceRangeMin_);
            // mountSchemData["flight_distance_max"] = QString::number(entity.uavFlightDistanceRangeMax_);
            // mountSchemData["flight_time_min"] = QString::number(entity.uavFlightTimeRangeMin_);
            // mountSchemData["flight_time_max"] = QString::number(entity.uavFlightTimeRangeMax_);

            /******************** 起降参数 ********************/
            if(!entity.uavTakeoffDistance_){
                mountSchemData["takeoff_distance"] = "";
            }else{
                mountSchemData["takeoff_distance"] = QString::number(entity.uavTakeoffDistance_.get());
            }
            if(!entity.uavLandDistance_){
                mountSchemData["landing_distance"] = "";
            }else{
                mountSchemData["landing_distance"] = QString::number(entity.uavLandDistance_.get());
            }
            /******************** 机动性能 ********************/
            //mountSchemData["turn_radius_min"] = QString::number(entity.uavTurningRadiusRangeMin_);
            //mountSchemData["turn_radius_max"] = QString::number(entity.uavTurningRadiusRangeMax_);
            if(!entity.uavOperatioanalRadius_){
                mountSchemData["combat_radius"] = "";
            }else{
                mountSchemData["combat_radius"] = QString::number(entity.uavOperatioanalRadius_.get());
            }
            /******************** 载荷配置 ********************/
            // mountSchemData["payload_type"] = QString::fromStdString(entity.uavInvestigationPayloadType_);
            // mountSchemData["bomb_method"] = QString::fromStdString(entity.uavBombingway_);
            // mountSchemData["operation_method"] = QString::fromStdString(entity.uavOperationWay_);
            // mountSchemData["recon_range_min"] = QString::number(entity.uavLoadReconnaissanceRangeMin_);
            // mountSchemData["recon_range_max"] = QString::number(entity.uavLoadReconnaissanceRangeMax_);
            // mountSchemData["recon_accuracy"] = QString::number(entity.uavLoadReconnaissanceAccuracy_);

            // /******************** 回收与突防 ********************/
            // mountSchemData["recovery_mode"] = QString::fromStdString(entity.uavRecoveryway_);
            // mountSchemData["low_alt_speed"] = QString::number(entity.uavLowAltitudeBreakthroughSpeed_);

            /******************** 挂载能力 ********************/
            //mountSchemData["hardpoint_loc"] = QString::fromStdString(entity.uavHangingLoctionCapacity_);
            // entity.uavHangingpoints_ = mountSchemData["hardpoint_num"].toInt();
            // entity.uavPayloadcapacity_ = mountSchemData["payload_capacity"].toInt();
           //mountSchemData["attack_accuracy"] = QString::number(entity.uavAttackaccuracy_);
            mountSchemData["hangingCapacity"] = QString::fromStdString(entity.uavHangingLoctionCapacity_);
            mountSchemData["uavLoadAmmoType"] = QString::fromStdString(entity.uavLoadAmmoType_);



            /******************** 雷达特征 ********************/
            //mountSchemData["rcs"] = QString::number(entity.uavRadarCrossSection_);

            /******************** 重量与平衡 ********************/
            //mountSchemData["cg_front_limit"] = QString::number(entity.uavCenterOfGravityFrontLimit_);
            //mountSchemData["cg_rear_limit"] = QString::number(entity.uavCenterOfGravityAfterwardLimit_);
            if(!entity.uavMaximumTakeoffWeight_){
                mountSchemData["max_takeoff_weight"] = "";
            }else{
                mountSchemData["max_takeoff_weight"] = QString::number(entity.uavMaximumTakeoffWeight_.get());
            }
            if(!entity.uavEmptyWeight_){
                mountSchemData["empty_weight"] = "";
            }else{
                mountSchemData["empty_weight"] = QString::number(entity.uavEmptyWeight_.get());
            }
            /******************** 燃油与载重 ********************/
            if(!entity.uavMaximumFuelCapacity_){
                mountSchemData["max_fuel"] = "";
            }else{
                mountSchemData["max_fuel"] = QString::number(entity.uavMaximumFuelCapacity_.get());
            }
            if(!entity.uavMaximumExternalWeight_){
                mountSchemData["max_external_weight"] = "";
            }else{
                mountSchemData["max_external_weight"] = QString::number(entity.uavMaximumExternalWeight_.get());
            }
            /******************** 高度性能 ********************/
            // mountSchemData["ceiling"] = QString::number(entity.uavCeiling_);
            // mountSchemData["ground_start_alt"] = QString::number(entity.uavMaximumGroundStartingHeight_);
            // mountSchemData["air_start_alt"] = QString::number(entity.uavMaximumAirStartingAltitude_);

            // /******************** 续航性能 ********************/
            // mountSchemData["endurance"] = QString::number(entity.uavMaximumEndurance_);
            // mountSchemData["max_vacuum_speed"] = QString::number(entity.uavMaximumFlightVacuumSpeed_);
            // mountSchemData["min_meter_speed"] = QString::number(entity.uavMinimumFlightMeterSpeed_);

            // /******************** 特殊场景性能 ********************/
            // mountSchemData["sea_takeoff_roll"] = QString::number(entity.sealLevelTakeoffAndRollDistance_);
            // mountSchemData["sea_landing_roll"] = QString::number(entity.sealLevelLandingAndRollDistance_);
            // mountSchemData["recon_cruise_alt"] = QString::number(entity.cruiseAltitudeReconnaissanceConfiguration_);
            // mountSchemData["full_external_cruise_alt"] = QString::number(entity.cruiseAltitudeFullExternalConfiguration_);
            mountSchemData["mountCapacity"] = [&db,&entity](){//QString::fromStdString(entity.uavHangingLoctionCapacity_);
                auto loaded{load{db}.from<UavModelMountLocationEntity>(QString::fromStdString(entity.uavHangingLoctionCapacity_))};
                QJsonArray arr;
                for(auto load: loaded){
                    QJsonObject hangObj;
                    hangObj["mountLocationName"] = QString::fromStdString(load.mountLocationName_);
                    hangObj["mountLocationId"] = QString::number(load.mountLocationId_);
                    arr.append(hangObj);//QString::fromStdString(load.mountLocationName_)
                }
                return QJsonValue{arr};
            }();
            mountSchemData["uavLoadAmmoContent"] = [&db,&entity](){
                auto loaded{load{db}.from<AmmunitionEntity>(QString::fromStdString(entity.uavLoadAmmoType_))};
                QJsonArray arr;
                for(auto load: loaded){
                    QJsonObject uavLoadAmmoObj;
                    uavLoadAmmoObj["ammoId"] = QString::number(load.id_);
                    uavLoadAmmoObj["ammoName"] = QString::fromStdString(load.ammoName_);
                    uavLoadAmmoObj["ammoWeight"] = QString::number(load.ammoMass_);
                    //qDebug() << "loaded: " << load.ammoName_.c_str();
                    arr.append(uavLoadAmmoObj);//QString::fromStdString(load.ammoName_
                }
                return QJsonValue{arr};
            }();
            // 转换为格式化的JSON字符串
            QJsonDocument doc(mountSchemData);
            QString jsonString = doc.toJson(QJsonDocument::Indented);
            qDebug()<<"当前函数名称:" << __FUNCTION__<<":"<<jsonString;
        } else {
            qDebug() << "No matching record found";
        }

        trans.commit();
    } catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        trans.rollback(); // 显式回滚事务（可选）
        throw; // 重新抛出异常或返回空结果
    }
    return mountSchemData;
}

QJsonArray UavModelDao::transformQueryAllData()
{
    QJsonArray transformUavData;
    QJsonArray queryUavAllData = selectUavModelAllData();
    UavModelBombingMethodDao uavModelBombWayDao;
    UavModelLoadTypeDao uavModelLoadTypeDao;
    UavModelRecoveryModeDao uavModelRecovery;
    UavModelOperationWayDao uavModelOpreation;
    UavMountLocationDao uavMountLocationDao;
    QJsonArray queryUavBombAllData = uavModelBombWayDao.selectUavModelBombingMethodAllData();
    QJsonArray queryUavLoadTypeAllData = uavModelBombWayDao.selectUavModelBombingMethodAllData();
    QJsonArray queryUavRecoveryAllData = uavModelRecovery.selectModelRecoveryModeAllData();
    QJsonArray queryUavOperationAllData = uavModelOpreation.selectModelOperationWayAllData();
    QJsonArray queryUavMountAllData = uavMountLocationDao.selectUavMountLocationAllData();
    QJsonDocument doc(queryUavAllData);
    QJsonDocument bdoc(queryUavBombAllData);
    qDebug()<<"当前函数名称:" << __FUNCTION__<<":";
    qDebug().noquote() << doc.toJson(QJsonDocument::Indented);
    qDebug()<<"当前函数名称:" << __FUNCTION__<<":";
    qDebug().noquote() << bdoc.toJson(QJsonDocument::Indented);
    return transformUavData;
}

QHash<QString, QString> UavModelDao::createIdMap(const QJsonArray &bArray)
{
    QHash<QString, QString> idMap;
    for (const QJsonValue &val : bArray) {
        QJsonObject obj = val.toObject();
        QString id = obj["recordId"].toString();
        QString name = obj["uavComponeName"].toString();
        if (!id.isEmpty() && !name.isEmpty()) {
            idMap.insert(id, name);
        }
    }
    return idMap;
}

QJsonArray UavModelDao::ProcessUavComponentWay(const QString &uavComponent, const QHash<QString, QString> &idMap)
{
    QJsonArray newArray;
    QJsonParseError parseError;

    QJsonDocument doc = QJsonDocument::fromJson(uavComponent.toUtf8(), &parseError);
    if (parseError.error != QJsonParseError::NoError || !doc.isArray()) {
        qWarning() << "Invalid JSON array format:" << uavComponent;
        return newArray;
    }

    QJsonArray originalArray = doc.array();
    for (const QJsonValue &item : originalArray) {
        QString element = item.toString();

        // 直接匹配完整ID
        if (idMap.contains(element)) {
            newArray.append(idMap[element]);
            continue;
        }

        // 处理带冒号的格式
        if (element.contains(":")) {
            QStringList parts = element.split(":");
            if (parts.size() >= 2) {
                QString id = parts[1].trimmed();
                if (idMap.contains(id)) {
                    newArray.append(QString("%1:%2").arg(parts[0].trimmed()).arg(idMap[id]));
                }
            }
        }
    }

    return newArray;
}

QJsonArray UavModelDao::processData(const QJsonArray &aArray, const QHash<QString, QString> &idMap)
{
    QJsonArray cArray;
    const QStringList targetFields = {
        "bombMethod",
        "operationMethod",
        "payloadType",
        "recoveryMode"
    };

    for (const QJsonValue &val : aArray) {
        QJsonObject originalObj = val.toObject();
        QJsonObject newObj;
        bool hasValidData = false;

        // 复制非目标字段
        for (auto it = originalObj.begin(); it != originalObj.end(); ++it) {
            if (!targetFields.contains(it.key())) {
                newObj[it.key()] = it.value();
            }
        }

        // 处理所有目标字段
        foreach (const QString &field, targetFields) {
            if (!originalObj.contains(field)) continue;

            QJsonArray processed = ProcessUavComponentWay(
                originalObj[field].toString(),
                idMap
                );

            if (!processed.isEmpty()) {
                // 将 QJsonArray 转换为 JSON 字符串
                QJsonDocument doc(processed);
                QByteArray jsonBytes = doc.toJson(QJsonDocument::Compact);
                // 将 QByteArray 转换为 QString
                newObj[field] = QString::fromUtf8(jsonBytes);
                hasValidData = true;
            }
        }

        if (hasValidData) {
            cArray.append(newObj);
        }
    }

    return cArray;
}

QJsonObject UavModelDao::selectSomeUavModelDate(const QString &jsonStr)
{
    QJsonObject uavModelData,object;
    // 将 JSON 字符串转换为 QJsonObject
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonStr.toUtf8());
    if (jsonDoc.isObject()) {
        object = jsonDoc.object();
        qDebug() << "Received JSON object:" << object;

    } else {
        qDebug() << "Invalid JSON format";
    }

    using query_t = odb::query<UavModelEntity>;
    // 1. 建立数据库连接
    qDebug() << "Connecting to database...";

    auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

    // 2. 创建事务
    odb::transaction trans(db.begin());
    qDebug() << "Transaction started";
    try {

        // 3. 从JSON创建实体对象
        UavModelEntity entity;

        query_t q(query_t::true_expr); // 初始化为无条件
        if (object.contains("recordId") && object["recordId"].isString()) {
            auto uav_recordId = object["recordId"].toString();
            q = q && (query_t::id == uav_recordId.toInt());
        }
        // if (object.contains("uavType") && object["uavType"].isString()) {
        //     auto uav_type = object["uavType"].toString();
        //     q = q && (query_t::uavType == uav_type.toStdString());
        // }

        // // 处理 name 字段（使用 == 条件）
        // if (object.contains("uavName") && object["uavName"].isString()) {
        //     QString uav_name = object["uavName"].toString();
        //     if (!uav_name.isEmpty()) {
        //         q = q && (query_t::uavName == uav_name.toStdString());
        //     }
        // }
        // if (object.contains("uavId") && object["uavId"].isString()) {
        //     QString uav_id = object["uavId"].toString();
        //     if (!uav_id.isEmpty()) {
        //         q = q && (query_t::uavId == uav_id.toStdString());
        //     }
        // }
        // if (object.contains("hangingCapacity") && object["hangingCapacity"].isString()) {
        //     QString hanging_capacity = object["hangingCapacity"].toString();
        //     if (!hanging_capacity.isEmpty()) {
        //         q = q && (query_t::uavHangingLoctionCapacity == hanging_capacity.toStdString());
        //     }
        // }
        // if (object.contains("operationMethod") && object["operationMethod"].isString()) {
        //     QString operation_method = object["operationMethod"].toString();
        //     if (!operation_method.isEmpty()) {
        //         q = q && (query_t::uavOperationWay == operation_method.toStdString());
        //     }
        // }
        // if (object.contains("bombMethod") && object["bombMethod"].isString()) {
        //     QString bomb_method = object["bombMethod"].toString();
        //     if (!bomb_method.isEmpty()) {
        //         q = q && (query_t::uavBombingway == bomb_method.toStdString());
        //     }
        // }
        // if (object.contains("recoveryMode") && object["recoveryMode"].isString()) {
        //     QString recovery_mode = object["recoveryMode"].toString();
        //     if (!recovery_mode.isEmpty()) {
        //         q = q && (query_t::uavRecoveryway == recovery_mode.toStdString());
        //     }
        // }
        // if (object.contains("payloadType") && object["payloadType"].isString()) {
        //     QString payload_type = object["payloadType"].toString();
        //     if (!payload_type.isEmpty()) {
        //         q = q && (query_t::uavInvestigationPayloadType == payload_type.toStdString());
        //     }
        // }

        // 执行查询
        // auto r(db.query_one<UavModelEntity>(q));
        // if(r){
        //     auto val{r};
        //     // uavModelData = val;
        //     nl::json json{*val};
        //     qDebug() << QString::fromStdString(json.dump());
        // }
        // 执行查询
        auto result = db.query_one<UavModelEntity>(q);
        if (result) {
            const UavModelEntity& entity = *result;

            // 手动转换每个字段到QJsonObject// 基础字段
            uavModelData["uavRecordId"] = QString::number(entity.id_);
            uavModelData["uavId"] = QString::fromStdString(entity.uavId_);
            uavModelData["uavType"] = QString::fromStdString(entity.uavType_);
            uavModelData["uavName"] = QString::fromStdString(entity.uavName_);
            // 处理数值类型（示例）/******************** 尺寸参数 ********************/
            if(!entity.uavLength_){
                uavModelData["uavLength"] = "";
            }else{
               uavModelData["uavLength"] = QString::number(entity.uavLength_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavWidth_){
                uavModelData["uavWidth"] = "";
            }else{
                uavModelData["uavWidth"] = QString::number(entity.uavWidth_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavHeight_){
                uavModelData["uavHeight"] = "";
            }else{
                uavModelData["uavHeight"] = QString::number(entity.uavHeight_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            uavModelData["load_ammo_type"] = QString::fromStdString(entity.uavLoadAmmoType_);
            // 格式化为字符串（保留5位小数）
            // QString formattedValue = QString::number(entity.uavLength_, 'f', 5);
            // uavModelData["uavLengthhangingCapacityStr"] = formattedValue;
            /******************** 飞行性能 ********************/
            if(!entity.uavFlightHeightRangeMin_){
                uavModelData["flight_height_min"] = "";
            }else{
                uavModelData["flight_height_min"] = QString::number(entity.uavFlightHeightRangeMin_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavFlightHeightRangeMax_){
                uavModelData["flight_height_max"] = "";
            }else{
                uavModelData["flight_height_max"] = QString::number(entity.uavFlightHeightRangeMax_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavFlightSpeedRangeMin_){
                uavModelData["flight_speed_min"] = "";
            }else{
                uavModelData["flight_speed_min"] = QString::number(entity.uavFlightSpeedRangeMin_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavFlightSpeedRangeMax_){
                uavModelData["flight_speed_max"] = "";
            }else{
                uavModelData["flight_speed_max"] = QString::number(entity.uavFlightSpeedRangeMax_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }

            /******************** 起降参数 ********************/
            if(!entity.uavFlightDistanceRangeMin_){
                uavModelData["flight_distance_min"] = "";
            }else{
                uavModelData["flight_distance_min"] = QString::number(entity.uavFlightDistanceRangeMin_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavFlightDistanceRangeMax_){
                uavModelData["flight_distance_max"] = "";
            }else{
                uavModelData["flight_distance_max"] = QString::number(entity.uavFlightDistanceRangeMax_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavFlightTimeRangeMin_){
                uavModelData["flight_time_min"] = "";
            }else{
                uavModelData["flight_time_min"] = QString::number(entity.uavFlightTimeRangeMin_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavFlightTimeRangeMax_){
                uavModelData["flight_time_max"] = "";
            }else{
                uavModelData["flight_time_max"] = QString::number(entity.uavFlightTimeRangeMax_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavTakeoffDistance_){
                uavModelData["takeoff_distance"] = "";
            }else{
                uavModelData["takeoff_distance"] = QString::number(entity.uavTakeoffDistance_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavLandDistance_){
                uavModelData["landing_distance"] = "";
            }else{
                uavModelData["landing_distance"] = QString::number(entity.uavLandDistance_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            /******************** 机动性能 ********************/
            if(!entity.uavTurningRadiusRangeMin_){
                uavModelData["turn_radius_min"] = "";
            }else{
                uavModelData["turn_radius_min"] = QString::number(entity.uavTurningRadiusRangeMin_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavTurningRadiusRangeMax_){
                uavModelData["turn_radius_max"] = "";
            }else{
                uavModelData["turn_radius_max"] = QString::number(entity.uavTurningRadiusRangeMax_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavOperatioanalRadius_){
                uavModelData["combat_radius"] = "";
            }else{
                uavModelData["combat_radius"] = QString::number(entity.uavOperatioanalRadius_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavLoadReconnaissanceRangeMin_){
                uavModelData["recon_range_min"] = "";
            }else{
                uavModelData["recon_range_min"] = QString::number(entity.uavLoadReconnaissanceRangeMin_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavLoadReconnaissanceRangeMax_){
                uavModelData["recon_range_max"] = "";
            }else{
                uavModelData["recon_range_max"] = QString::number(entity.uavLoadReconnaissanceRangeMax_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavLoadReconnaissanceAccuracy_){
                uavModelData["recon_accuracy"] = "";
            }else{
                uavModelData["recon_accuracy"] = QString::number(entity.uavLoadReconnaissanceAccuracy_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            /******************** 载荷配置 ********************/
            uavModelData["payload_type"] = QString::fromStdString(entity.uavInvestigationPayloadType_);
            uavModelData["bomb_method"] = QString::fromStdString(entity.uavBombingway_);
            uavModelData["operation_method"] = QString::fromStdString(entity.uavOperationWay_);
            /******************** 回收与突防 ********************/
            uavModelData["recovery_mode"] = QString::fromStdString(entity.uavRecoveryway_);


            /******************** 挂载能力 ********************/
            //uavModelData["hardpoint_loc"] = QString::fromStdString(entity.uavHangingLoctionCapacity_);
            // entity.uavHangingpoints_ = uavModelData["hardpoint_num"].toInt();
            // entity.uavPayloadcapacity_ = uavModelData["payload_capacity"].toInt();

            uavModelData["hangingCapacity"] = QString::fromStdString(entity.uavHangingLoctionCapacity_);

            if(!entity.uavLowAltitudeBreakthroughSpeed_){
                uavModelData["low_alt_speed"] = "";
            }else{
                uavModelData["low_alt_speed"] = QString::number(entity.uavLowAltitudeBreakthroughSpeed_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavAttackaccuracy_){
                uavModelData["attack_accuracy"] = "";
            }else{
                uavModelData["attack_accuracy"] = QString::number(entity.uavAttackaccuracy_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            /******************** 雷达特征 ********************/
            if(!entity.uavRadarCrossSection_){
                uavModelData["rcs"] = "";
            }else{
                uavModelData["rcs"] = QString::number(entity.uavRadarCrossSection_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            /******************** 重量与平衡 ********************/
            if(!entity.uavCenterOfGravityFrontLimit_){
                uavModelData["cg_front_limit"] = "";
            }else{
                uavModelData["cg_front_limit"] = QString::number(entity.uavCenterOfGravityFrontLimit_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavCenterOfGravityAfterwardLimit_){
                uavModelData["cg_rear_limit"] = "";
            }else{
                uavModelData["cg_rear_limit"] = QString::number(entity.uavCenterOfGravityAfterwardLimit_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            /******************** 燃油与载重 ********************/
            if(!entity.uavMaximumTakeoffWeight_){
                uavModelData["max_takeoff_weight"] = "";
            }else{
                uavModelData["max_takeoff_weight"] = QString::number(entity.uavMaximumTakeoffWeight_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavEmptyWeight_){
                uavModelData["empty_weight"] = "";
            }else{
                uavModelData["empty_weight"] = QString::number(entity.uavEmptyWeight_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavMaximumFuelCapacity_){
                uavModelData["max_fuel"] = "";
            }else{
                uavModelData["max_fuel"] = QString::number(entity.uavMaximumFuelCapacity_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavMaximumExternalWeight_){
                uavModelData["max_external_weight"] = "";
            }else{
                uavModelData["max_external_weight"] = QString::number(entity.uavMaximumExternalWeight_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            /******************** 高度性能 ********************/
            if(!entity.uavCeiling_){
                uavModelData["ceiling"] = "";
            }else{
                uavModelData["ceiling"] = QString::number(entity.uavCeiling_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavMaximumGroundStartingHeight_){
                uavModelData["ground_start_alt"] = "";
            }else{
                uavModelData["ground_start_alt"] = QString::number(entity.uavMaximumGroundStartingHeight_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavMaximumAirStartingAltitude_){
                uavModelData["air_start_alt"] = "";
            }else{
                uavModelData["air_start_alt"] = QString::number(entity.uavMaximumAirStartingAltitude_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            /******************** 续航性能 ********************/
            if(!entity.uavMaximumEndurance_){
                uavModelData["endurance"] = "";
            }else{
                uavModelData["endurance"] = QString::number(entity.uavMaximumEndurance_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavMaximumFlightVacuumSpeed_){
                uavModelData["max_vacuum_speed"] = "";
            }else{
                uavModelData["max_vacuum_speed"] = QString::number(entity.uavMaximumFlightVacuumSpeed_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.uavMinimumFlightMeterSpeed_){
                uavModelData["min_meter_speed"] = "";
            }else{
                uavModelData["min_meter_speed"] = QString::number(entity.uavMinimumFlightMeterSpeed_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            /******************** 特殊场景性能 ********************/
            if(!entity.sealLevelTakeoffAndRollDistance_){
                uavModelData["sea_takeoff_roll"] = "";
            }else{
                uavModelData["sea_takeoff_roll"] = QString::number(entity.sealLevelTakeoffAndRollDistance_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.sealLevelLandingAndRollDistance_){
                uavModelData["sea_landing_roll"] = "";
            }else{
                uavModelData["sea_landing_roll"] = QString::number(entity.sealLevelLandingAndRollDistance_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.cruiseAltitudeReconnaissanceConfiguration_){
                uavModelData["recon_cruise_alt"] = "";
            }else{
                uavModelData["recon_cruise_alt"] = QString::number(entity.cruiseAltitudeReconnaissanceConfiguration_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.cruiseAltitudeFullExternalConfiguration_){
                uavModelData["full_external_cruise_alt"] = "";
            }else{
                uavModelData["full_external_cruise_alt"] = QString::number(entity.cruiseAltitudeFullExternalConfiguration_.get());                 // 假设返回float// 使用 QString::number 方法转换 float
            }
            /******************** 系统记录 ********************/
            //entity.uavCreatModelTime_ = recordCreationTime.toTime_t();
            //uavModelData["image_name"] = QString::fromStdString(entity.uavImgName_);

            QByteArray imageData(entity.uavImgName_.data(), entity.uavImgName_.size());
            //建立临时文件名

            QString tempFileName = "Uav" + QDateTime::currentDateTime().toString("yyyyMMddHHmmss") + "Image";
            // 创建一个临时文件
            QTemporaryFile tempFile(tempFileName);
            //tempFile.setAutoRemove(false); // 禁用自动删除
            if (!tempFile.open()) {
                qDebug() << "Failed to create temporary file:" << tempFile.errorString();
                //return QString();
            }

            // 写入图片数据
            tempFile.write(imageData);
            tempFile.close();

            // 返回临时文件的路径
            QUrl imageUrl;
             QString tempFilePath =tempFile.fileName();
             if (!tempFilePath.isEmpty()) {
                 imageUrl = QUrl::fromLocalFile(tempFilePath);
             }

             QString filePath = imageUrl.toString();
             // 去掉文件路径中的 "file:///"
                filePath = filePath.mid(8);

                // 检查文件是否存在
                QFile file(filePath);
                if (!file.exists()) {
                    qDebug()<< "错误, 文件不存在！";

                }

                // 加载图片
                QImage image(filePath);
//                if (image.isNull()) {
//                    qDebug()<<"错误, 无法加载图片！";
//                    return -1;
//                }
                QString fileType = ".png";

                // 修改文件扩展名
                QString newFilePath = filePath.section('.', 0, -2) + fileType;

                // 保存为PNG格式
                if (!image.save(newFilePath, "PNG")) {
                    qDebug()<<"错误, 保存失败！";
                }
                qDebug()<<"QTemporaryFile"<<newFilePath;

            uavModelData["image_url"] = newFilePath;
            // 转换为格式化的JSON字符串
            QJsonDocument doc(uavModelData);
            QString jsonString = doc.toJson(QJsonDocument::Indented);
            qDebug()<<"当前函数名称:" << __FUNCTION__<<":"<<jsonString;
        } else {
            qDebug() << "No matching record found";
        }

        trans.commit();
    } catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        trans.rollback(); // 显式回滚事务（可选）
        throw; // 重新抛出异常或返回空结果
    }
    return uavModelData;

}

bool UavModelDao::updateModelDate(const QString &jsonStr)
{
    QJsonObject uavModelData;
    qDebug()<<"updateUavModelDatajsonStr"<<jsonStr;
    // 将 JSON 字符串转换为 QJsonObject
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonStr.toUtf8());
    if (jsonDoc.isObject()) {
        uavModelData = jsonDoc.object();
        qDebug() << "Received JSON object:" << uavModelData;

    } else {
        qDebug() << "Invalid JSON format";
    }

    try {
        // 1. 建立数据库连接
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        qDebug() << "Connecting to database...";

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction started";
        // 3. 从JSON创建实体对象
        UavModelEntity entity;
        // 定义查询条件
        // unique_ptr<entity> john (
        //     db->query_one<entity> (query::first == "John" &&
        //                           query::last == "Doe"));
        // if (john.get () != 0)
        //     db->erase (*john);
        typedef odb::query<UavModelEntity> query;
        // 3. 加载要修改的实体
        //std::shared_ptr<Person> person(db->load<Person>(1));  // 加载ID为1的记录
        // 获取要更新的记录ID
        // 从 QJsonObject 中提取 "id" 字段
        QJsonValue idValue = uavModelData.value("id");

        // 检查字段是否存在
        if (idValue.isUndefined()) {
            qCritical() << "Error: JSON 中缺少 'id' 字段";
            return false;
        }

        // 将字段值转为 QString（无论原始类型是字符串还是数字）
        QString idStr = idValue.toVariant().toString();

        // 转换为整型并校验格式
        bool ok;
        int rid = idStr.toInt(&ok);
        if (!ok) {
            qCritical() << "Error: 'id' 值无效，无法转换为整数：" << idStr;
            return false;
        }

        // 检查 ID 是否为正数（根据业务需求）
        if (rid <= 0) {
            qCritical() << "Error: ID 必须为正整数，当前值：" << rid;
            return false;
        }

        // 此时 id 变量已包含正确的整数值
        qDebug() << "成功获取 ID:" << rid;
        db.load(rid, entity);

        // 基础字段
        entity.uavType_ = uavModelData["uav_type"].toString().toStdString();
        entity.uavName_ = uavModelData["uav_name"].toString().toStdString();
        entity.uavId_ = uavModelData["uav_id"].toString().toStdString();

        /******************** 尺寸参数 ********************/
        entity.uavLength_ = uavModelData["length"].toDouble();
        entity.uavWidth_ = uavModelData["width"].toDouble();
        entity.uavHeight_ = uavModelData["height"].toDouble();
        entity.uavLoadAmmoType_ = uavModelData["load_ammo_type"].toString().toStdString();

        /******************** 飞行性能 ********************/
        entity.uavFlightHeightRangeMin_ = uavModelData["flight_height_min"].toDouble();
        entity.uavFlightHeightRangeMax_ = uavModelData["flight_height_max"].toDouble();
        entity.uavFlightSpeedRangeMin_ = uavModelData["flight_speed_min"].toDouble();
        entity.uavFlightSpeedRangeMax_ = uavModelData["flight_speed_max"].toDouble();
        //entity.uavFlightDistanceRangeMin_ = uavModelData["flight_distance_min"].toDouble();
        entity.uavFlightDistanceRangeMax_ = uavModelData["flight_distance_max"].toDouble();
        //entity.uavFlightTimeRangeMin_ = uavModelData["flight_time_min"].toDouble();
        entity.uavFlightTimeRangeMax_ = uavModelData["flight_time_max"].toDouble();

        /******************** 起降参数 ********************/
        entity.uavTakeoffDistance_ = uavModelData["takeoff_distance"].toDouble();
        entity.uavLandDistance_ = uavModelData["landing_distance"].toDouble();

        /******************** 机动性能 ********************/
        entity.uavTurningRadiusRangeMin_ = uavModelData["turn_radius_min"].toDouble();
        entity.uavTurningRadiusRangeMax_ = uavModelData["turn_radius_max"].toDouble();
        entity.uavOperatioanalRadius_ = uavModelData["combat_radius"].toDouble();

        /******************** 载荷配置 ********************/
        entity.uavInvestigationPayloadType_ = uavModelData["payload_type"].toString().toStdString();
        entity.uavBombingway_ = uavModelData["bomb_method"].toString().toStdString();
        entity.uavOperationWay_ = uavModelData["operation_method"].toString().toStdString();
        entity.uavLoadReconnaissanceRangeMin_ = uavModelData["recon_range_min"].toDouble();
        entity.uavLoadReconnaissanceRangeMax_ = uavModelData["recon_range_max"].toDouble();
        entity.uavLoadReconnaissanceAccuracy_ = uavModelData["recon_accuracy"].toDouble();

        /******************** 回收与突防 ********************/
        entity.uavRecoveryway_ = uavModelData["recovery_mode"].toString().toStdString();
        entity.uavLowAltitudeBreakthroughSpeed_ = uavModelData["low_alt_speed"].toDouble();

        /******************** 挂载能力 ********************/
        entity.uavHangingLoctionCapacity_ = uavModelData["hanging_capacity"].toString().toStdString();
        // entity.uavHangingpoints_ = uavModelData["hardpoint_num"].toInt();
        // entity.uavPayloadcapacity_ = uavModelData["payload_capacity"].toInt();
        entity.uavAttackaccuracy_ = uavModelData["attack_accuracy"].toDouble();

        /******************** 雷达特征 ********************/
        entity.uavRadarCrossSection_ = uavModelData["rcs"].toDouble();

        /******************** 重量与平衡 ********************/
        entity.uavCenterOfGravityFrontLimit_ = uavModelData["cg_front_limit"].toDouble();
        entity.uavCenterOfGravityAfterwardLimit_ = uavModelData["cg_rear_limit"].toDouble();
        entity.uavMaximumTakeoffWeight_ = uavModelData["max_takeoff_weight"].toDouble();
        entity.uavEmptyWeight_ = uavModelData["empty_weight"].toDouble();

        /******************** 燃油与载重 ********************/
        entity.uavMaximumFuelCapacity_ = uavModelData["max_fuel"].toDouble();
        entity.uavMaximumExternalWeight_ = uavModelData["max_external_weight"].toDouble();

        /******************** 高度性能 ********************/
        entity.uavCeiling_ = uavModelData["ceiling"].toDouble();
        entity.uavMaximumGroundStartingHeight_ = uavModelData["ground_start_alt"].toDouble();
        entity.uavMaximumAirStartingAltitude_ = uavModelData["air_start_alt"].toDouble();

        /******************** 续航性能 ********************/
        entity.uavMaximumEndurance_ = uavModelData["endurance"].toDouble();
        entity.uavMaximumFlightVacuumSpeed_ = uavModelData["max_vacuum_speed"].toDouble();
        entity.uavMinimumFlightMeterSpeed_ = uavModelData["min_meter_speed"].toDouble();

        /******************** 特殊场景性能 ********************/
        entity.sealLevelTakeoffAndRollDistance_ = uavModelData["sea_takeoff_roll"].toDouble();
        entity.sealLevelLandingAndRollDistance_ = uavModelData["sea_landing_roll"].toDouble();
        entity.cruiseAltitudeReconnaissanceConfiguration_ = uavModelData["recon_cruise_alt"].toDouble();
        entity.cruiseAltitudeFullExternalConfiguration_ = uavModelData["full_external_cruise_alt"].toDouble();

        /******************** 系统记录 ********************/
        entity.uavCreatModelTime_ = QDateTime::currentDateTime();
        QString image_url = uavModelData["image_url"].toString();
        QUrl url(image_url);
        QString localFilePath = url.toLocalFile();
        QFile file(localFilePath);

        qDebug()<<"image_url:"<<uavModelData["image_url"].toString();
        file.open(QIODevice::ReadOnly);
        QByteArray data = file.readAll();
        file.close();
        //std::vector  imagByteA = std::vector<unsigned char>(data.begin(),data.end());
        entity.uavImgName_ = std::vector<char>(data.begin(),data.end());
        std::vector<char> imagByteA(data.begin(), data.end());
        std::cout << "imagByteA: "<<imagByteA.size()<<"Data size" << entity.uavImgName_.size() << std::endl;
        // auto id = db.persist(entity);
        // qDebug() << "Persisting entity..."<<id;

        //entity.uavName_("James");
        //entity.age("Newland");
        // 4. 修改数据
        db.update(entity);
        // 提交事务
        trans.commit();
        qDebug()<<"当前函数名称:" << __FUNCTION__<<":" << "Transaction committed, 数据更新成功";
    } catch (const std::exception& e) {
        qCritical() << "Error:" << " 数据更新操作出错: " << e.what();
        return false;
    }
    return true;
}

bool UavModelDao::deleteModelDate(const QJsonArray &object)
{
    qDebug() << "Starting database Rows Delete...";
    QJsonObject checkResult;
    int recordId;
    QString uavType,uavId,uavName;
    QString uavInvestigationPayloadType,uavBombingmethod,
            uavRecoverymode,uavHangingLoctionCapacity,uavOperationMethod;
    QString uavCreatModelTime,uavImgName;

    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        // odb::pgsql::database db(
        //     "postgres",       // username
        //     "123456",         // password
        //     "db_aux_prac_sys",// database
        //     "192.168.0.101",  // host
        //     5432              // port
        //     );
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction delete started";
        // 3. 从JSON创建实体对象
        UavModelEntity entity;
        // 定义查询条件
        // unique_ptr<entity> john (
        //     db->query_one<entity> (query::first == "John" &&
        //                           query::last == "Doe"));
        // if (john.get () != 0)
        //     db->erase (*john);
        typedef odb::query<UavModelEntity> query;
        // 遍历 QJsonArray
        for (int i = 0; i < object.size(); ++i) {
            QJsonObject uavData = object.at(i).toObject();
             recordId = uavData["recordId"].toInt();
             uavType = uavData["uav_type"].toString();
             uavName = uavData["uav_type"].toString();
             uavId  = uavData["uav_id"].toString();
             uavInvestigationPayloadType = uavData["payload_type"].toString();
             uavBombingmethod = uavData["bomb_method"].toString();
             uavRecoverymode = uavData["recovery_mode"].toString();
             uavHangingLoctionCapacity = uavData["hanging_capacity"].toString();
             uavOperationMethod = uavData["operation_method"].toString();
             uavCreatModelTime = uavData["create_time"].toString();
            // 打印每一行的数据
             qDebug() << "recordId:" << uavData["recordId"].toInt();
            qDebug() << "UAV Type:" << uavData["uav_type"].toString();
            qDebug() << "UAV Name:" << uavData["uav_name"].toString();
            qDebug() << "UAV ID:" << uavData["uav_id"].toString();
            qDebug() << "Payload Type:" << uavData["payload_type"].toString();
            qDebug() << "Bomb Method:" << uavData["bomb_method"].toString();
            qDebug() << "Recovery Mode:" << uavData["recovery_mode"].toString();
            qDebug() << "Hanging Capacity:" << uavData["hanging_capacity"].toString();
            qDebug() << "Operation Method:" << uavData["operation_method"].toString();
            qDebug() << "Create Time:" << uavData["create_time"].toString();
            qDebug() << "-----------------------------";
            auto rst = db.erase_query<UavModelEntity>(//db.query<UavModelEntity>
                //query::uavType == uavType.toStdString().c_str()
                //&&query::uavName == uavName.toStdString().c_str()
                 query::id == recordId
                // && query::uavInvestigationPayloadType == uavInvestigationPayloadType.toStdString()
                // && query::uavBombingmethod == uavBombingmethod.toStdString()
                // && query::uavRecoverymode == uavRecoverymode.toStdString()
                // && query::uavHangingLoctionCapacity == uavHangingLoctionCapacity.toStdString()
                // && query::uavOperationMethod == uavOperationMethod.toStdString()
                //&& query::uavCreatModelTime == uavCreatModelTime.toStdString().c_str()

                ); // 替换 condition1、condition2 为实际的字段名，value1、value2 为实际的值
            qDebug() << "===============================" ;//<< rst.size()
        }

        // 提交事务
        trans.commit();
        qDebug() <<"当前函数名称:" << __FUNCTION__<<":"<< "Transaction committed, 删除成功";
    } catch (const std::exception& e) {
        qCritical() << "Error:" << "删除操作出错: " << e.what();
        return false;
    }

    return true;
}

QJsonObject UavModelDao::checkUavDataObject(const QJsonObject &object)
{
    // 预定义所有列名列表
    const QStringList predefinedColumns = {
        // 基础字段
        "uav_type", "uav_name", "uav_id",

        // 尺寸参数
        "length", "width", "height", "load_ammo_type",

        // 飞行性能
        "flight_height_min", "flight_height_max",
        "flight_speed_min", "flight_speed_max",
        "flight_distance_min", "flight_distance_max",
        "flight_time_min", "flight_time_max",

        // 起降参数
        "takeoff_distance", "landing_distance",

        // 机动性能
        "turn_radius_min", "turn_radius_max", "combat_radius",

        // 载荷配置
        "payload_type", "bomb_method","operation_method",
        "recon_range_min", "recon_range_max", "recon_accuracy",

        // 回收与突防
        "recovery_mode", "low_alt_speed",

        // 挂载能力
        "hardpoint_loc", "hardpoint_num",
        "payload_capacity", "attack_accuracy",

        // 雷达特征
        "rcs",

        // 重量与平衡
        "cg_front_limit", "cg_rear_limit",
        "max_takeoff_weight", "empty_weight",

        // 燃油与载重
        "max_fuel", "max_external_weight",

        // 高度性能
        "ceiling", "ground_start_alt", "air_start_alt",

        // 续航性能
        "endurance", "max_vacuum_speed", "min_meter_speed",

        // 特殊场景性能
        "sea_takeoff_roll", "sea_landing_roll",
        "recon_cruise_alt", "full_external_cruise_alt",

        // 系统记录
        "create_time", "image_name", "image_url"
    };


    // 保留原始存在的键值对
    // for (const auto& key : input.keys()) {
    //     output[key] = input[key];
    // }
    QJsonObject output = object; // 保留原始输入内容
    // 补充缺失的列
    for (const QString& col : predefinedColumns) {
        if (!output.contains(col)) {
            output[col] = "";
        }
    }
    // 转换为格式化的JSON字符串
    QJsonDocument doc(output);
    QString jsonString = doc.toJson(QJsonDocument::Indented);

    // 打印到控制台
    qDebug()<<"JSON内容：\n" << jsonString;

    return output;
}

bool UavModelDao::insertModelDate(const QJsonObject& objectData)
{
    qDebug() << "Starting database insertion...";
    QJsonObject checkResult;
    QJsonObject object;
    //checkResult = checkUavDataObject(object); 
    // 转换为格式化的JSON字符串
    QJsonDocument doc(objectData);
    QString jsonString = doc.toJson(QJsonDocument::Indented);
    qDebug() << "图片的数据:" << jsonString;
    // 解析 JSON 数据
    QJsonDocument trDoc(objectData); //QJsonDocument::fromJson(jsonString.toUtf8());
    if (!trDoc.isNull() && trDoc.isObject()) {
                QJsonObject uavData = trDoc.object();

                // 指定需要转换的字段
                QStringList fieldsToTransform = {
                    "load_ammo_type",
                    "payload_type",
                    "bomb_method",
                    "operation_method",
                    "recovery_mode"
                };

               object  = transformArrayToStr(uavData, fieldsToTransform);

                // 打印转换后的数据
                QJsonDocument transformedDoc(object);
                qDebug() << "转换后的数据:" << transformedDoc.toJson(QJsonDocument::Compact);
    }        // 打印到控制台
            qDebug()<<"Qt function UavModelDao insertModelDat JSON内容：\n" << jsonString;
            try {
                // 1. 建立数据库连接
                qDebug() << "Connecting to database...";
                // odb::pgsql::database db(
                //     "postgres",       // username
                //     "123456",         // password
                //     "db_aux_prac_sys",// database
                //     "192.168.0.101",  // host
                //     5432              // port
                //     );
                auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

                // 2. 创建事务
                odb::transaction trans(db.begin());
                qDebug() << "Transaction insert started";

                // 3. 从JSON创建实体对象
                UavModelEntity entity;
                QDateTime recordCreationTime;//创建记录时间

                // 4. 映射JSON字段到实体属性
                // 基础字段
                entity.uavType_ = object["uav_type"].toString().toStdString();
                entity.uavName_ = object["uav_name"].toString().toStdString();
                entity.uavId_ = object["uav_id"].toString().toStdString();

                /******************** 尺寸参数 ********************/
                if(object["length"].isNull()){

                }else{
                    entity.uavLength_ = object["length"].toDouble();
                }
                if(object["width"].isNull()){

                }else{
                    entity.uavWidth_ = object["width"].toDouble();
                }
                if(object["height"].isNull()){

                }else{
                    entity.uavHeight_ = object["height"].toDouble();
                }
                /******************** 飞行性能 ********************/
                if(object["flight_height_min"].isNull()){

                }else{
                    entity.uavFlightHeightRangeMin_ = object["flight_height_min"].toDouble();
                }
                if(object["flight_height_max"].isNull()){

                }else{
                    entity.uavFlightHeightRangeMax_ = object["flight_height_max"].toDouble();
                }
                if(object["flight_speed_min"].isNull()){

                }else{
                    entity.uavFlightSpeedRangeMin_ = object["flight_speed_min"].toDouble();
                }
                if(object["flight_speed_max"].isNull()){

                }else{
                    entity.uavFlightSpeedRangeMax_ = object["flight_speed_max"].toDouble();
                }
                if(object["flight_distance_min"].isNull()){

                }else{
                    entity.uavFlightDistanceRangeMin_ = object["flight_distance_min"].toDouble();
                }
                if(object["flight_distance_max"].isNull()){

                }else{
                    entity.uavFlightDistanceRangeMax_ = object["flight_distance_max"].toDouble();
                }
                if(object["flight_time_min"].isNull()){

                }else{
                    entity.uavFlightTimeRangeMin_ = object["flight_time_min"].toDouble();

                }
                if(object["flight_time_max"].isNull()){

                }else{
                    entity.uavFlightTimeRangeMax_ = object["flight_time_max"].toDouble();
                }
                /******************** 起降参数 ********************/
                if(object["takeoff_distance"].isNull()){

                }else{
                    entity.uavTakeoffDistance_ = object["takeoff_distance"].toDouble();
                }
                if(object["landing_distance"].isNull()){

                }else{
                    entity.uavLandDistance_ = object["landing_distance"].toDouble();
                }
                /******************** 机动性能 ********************/
                if(object["turn_radius_min"].isNull()){

                }else{
                    entity.uavTurningRadiusRangeMin_ = object["turn_radius_min"].toDouble();
                }
                if(object["turn_radius_max"].isNull()){

                }else{
                    entity.uavTurningRadiusRangeMax_ = object["turn_radius_max"].toDouble();
                }
                if(object["combat_radius"].isNull()){

                }else{
                    entity.uavOperatioanalRadius_ = object["combat_radius"].toDouble();
                }
                /******************** 载荷配置 ********************/
                entity.uavInvestigationPayloadType_ = object["payload_type"].toString().toStdString();

                entity.uavBombingway_ = object["bomb_method"].toString().toStdString();
                entity.uavOperationWay_ = object["operation_method"].toString().toStdString();
                entity.uavRecoveryway_ = object["recovery_mode"].toString().toStdString();
                entity.uavHangingLoctionCapacity_ = object["hanging_capacity"].toString().toStdString();
                entity.uavLoadAmmoType_ = object["load_ammo_type"].toString().toStdString();
                if(object["recon_range_min"].isNull()){

                }else{
                    entity.uavLoadReconnaissanceRangeMin_ = object["recon_range_min"].toDouble();
                }
                if(object["recon_range_max"].isNull()){

                }else{
                    entity.uavLoadReconnaissanceRangeMax_ = object["recon_range_max"].toDouble();
                }
                if(object["recon_accuracy"].isNull()){

                }else{
                    entity.uavLoadReconnaissanceAccuracy_ = object["recon_accuracy"].toDouble();
                }
                /******************** 回收与突防 ********************/
                if(object["low_alt_speed"].isNull()){

                }else{
                    entity.uavLowAltitudeBreakthroughSpeed_ = object["low_alt_speed"].toDouble();
                }
                /******************** 挂载能力 ********************/
                if(object["attack_accuracy"].isNull()){

                }else{
                    // entity.uavPayloadcapacity_ = object["payload_capacity"].toInt();
                    entity.uavAttackaccuracy_ = object["attack_accuracy"].toDouble();
                }
                /******************** 雷达特征 ********************/
                if(object["rcs"].isNull()){

                }else{
                    entity.uavRadarCrossSection_ = object["rcs"].toDouble();
                }
                /******************** 重量与平衡 ********************/
                if(object["cg_front_limit"].isNull()){

                }else{
                    entity.uavCenterOfGravityFrontLimit_ = object["cg_front_limit"].toDouble();
                }
                if(object["cg_rear_limit"].isNull()){

                }else{
                    entity.uavCenterOfGravityAfterwardLimit_ = object["cg_rear_limit"].toDouble();
                }
                if(object["max_takeoff_weight"].isNull()){

                }else{
                    entity.uavMaximumTakeoffWeight_ = object["max_takeoff_weight"].toDouble();
                }
                if(object["empty_weight"].isNull()){

                }else{
                    entity.uavEmptyWeight_ = object["empty_weight"].toDouble();
                }
                /******************** 燃油与载重 ********************/
                if(object["max_fuel"].isNull()){

                }else{
                    entity.uavMaximumFuelCapacity_ = object["max_fuel"].toDouble();
                }
                if(object["max_external_weight"].isNull()){

                }else{
                    entity.uavMaximumExternalWeight_ = object["max_external_weight"].toDouble();
                }
                /******************** 高度性能 ********************/                

                if(object["ceiling"].isNull()){

                }else{
                    entity.uavCeiling_ = object["ceiling"].toDouble();
                }
                if(object["ground_start_alt"].isNull()){

                }else{
                    entity.uavMaximumGroundStartingHeight_ = object["ground_start_alt"].toDouble();
                }
                if(object["air_start_alt"].isNull()){

                }else{
                    entity.uavMaximumAirStartingAltitude_ = object["air_start_alt"].toDouble();
                }

                /******************** 续航性能 ********************/
                if(object["endurance"].isNull()){

                }else{
                    entity.uavMaximumEndurance_ = object["endurance"].toDouble();
                }
                if(object["max_vacuum_speed"].isNull()){

                }else{
                    entity.uavMaximumFlightVacuumSpeed_ = object["max_vacuum_speed"].toDouble();
                }
                if(object["min_meter_speed"].isNull()){

                }else{
                    entity.uavMinimumFlightMeterSpeed_ = object["min_meter_speed"].toDouble();
                }
                /******************** 特殊场景性能 ********************/
                if(object["sea_takeoff_roll"].isNull()){

                }else{
                    entity.sealLevelTakeoffAndRollDistance_ = object["sea_takeoff_roll"].toDouble();
                }
                if(object["sea_landing_roll"].isNull()){

                }else{
                    entity.sealLevelLandingAndRollDistance_ = object["sea_landing_roll"].toDouble();
                }
                if(object["recon_cruise_alt"].isNull()){

                }else{
                    entity.cruiseAltitudeReconnaissanceConfiguration_ = object["recon_cruise_alt"].toDouble();
                }
                if(object["full_external_cruise_alt"].isNull()){

                }else{
                    entity.cruiseAltitudeFullExternalConfiguration_ = object["full_external_cruise_alt"].toDouble();
                }
                /******************** 系统记录 ********************/
                //entity.uavCreatModelTime_ = recordCreationTime.toTime_t();
                // 使用 QUrl 解析 URL 并提取本地路径
                QString image_url = object["image_url"].toString();
                QUrl url(image_url);
                QString localFilePath = url.toLocalFile();
                QFile file(localFilePath);

                qDebug()<<"image_url:"<<object["image_url"].toString();
                file.open(QIODevice::ReadOnly);
                QByteArray data = file.readAll();
                file.close();
                //std::vector  imagByteA = std::vector<unsigned char>(data.begin(),data.end());
                entity.uavImgName_ = std::vector<char>(data.begin(),data.end());
                std::vector<char> imagByteA(data.begin(), data.end());
                std::cout << "imagByteA: "<<imagByteA.size()<<"Data size" << entity.uavImgName_.size() << std::endl;


                // std::vector<unsigned char> content;

                // // 文件写入方法
                // bool save_to_file(const std::string& path) {
                //     QFile file(QString::fromStdString(path));
                //     if (!file.open(QIODevice::WriteOnly)) return false;
                //     file.write(reinterpret_cast<const char*>(content.data()), content.size());
                //     return file.flush();
                // }

                // // 文件加载方法
                // static BinaryData load_from_file(const std::string& path) {
                //     QFile file(QString::fromStdString(path));
                //     file.open(QIODevice::ReadOnly);
                //     QByteArray data = file.readAll();
                //     return {std::vector<unsigned char>(data.begin(), data.end())};
                // }
                //entity.uavImgName_ = object["image_name"].toString().toStdString();
                //entity.uavImgUrl_ = object["image_url"].toString().toStdString();

                // 5. 数据验证
                // if (entity.getUavType().empty()) {
                //     throw std::invalid_argument("Missing required field: uav_type");
                // }
                // 6. 持久化到数据库
                qDebug() << "Persisting entity...";
                auto id = db.persist(entity);

                // 7. 提交事务
                trans.commit();
                qDebug() <<"当前函数名称:" << __FUNCTION__<<":"<< "Transaction committed, ID:" << id;

                //return id;
            }
            catch (const odb::exception& e) {
                qCritical() << "Database error:" << e.what();
                return false;
                //throw;
            }
            catch (const std::exception& e) {
                qCritical() << "Error:" << e.what();
                return false;//throw;
            }
            return true;

}
QJsonObject UavModelDao::transformArrayToStr(const QJsonObject &input, const QStringList &fields)
{
    QJsonObject output = input;

    for (const QString &field : fields) {
        if (output.contains(field) && output[field].isString()) {
            QString fieldValue = output[field].toString();
            QJsonDocument jsonDoc = QJsonDocument::fromJson(fieldValue.toUtf8());

            if (!jsonDoc.isNull() && jsonDoc.isArray()) {
                QJsonArray array = jsonDoc.array();
                QStringList values;

                for (const QJsonValue &value : array) {
                    if (value.isString()) {
                        values << value.toString();
                    }
                }

                if (!values.isEmpty()) {
                    output[field] = values.join(",");
                }
            }
        }
    }

    return output;

}
