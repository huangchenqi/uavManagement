#include "uavmodeldao.h"
#include "odb/database.hxx"
#include "odb/pgsql/database.hxx"
#include "UavModelEntity-odb.hxx"
#include "uavmodelentity.h"
#include <QJsonObject>
#include <QJsonValue>
#include <QDebug>
#include <stdexcept>
#include <QStringList>
#include <odb/database.hxx>
#include <odb/transaction.hxx>
// ODB 头文件
#include <odb/database.hxx>
#include <odb/transaction.hxx>
#include <odb/query.hxx>
#include <odb/pgsql/database.hxx>
#include "databaseconnection.h"
UavModelDao::UavModelDao(QObject* parent) : QObject(parent){ //::UavModelDao() {
    // 使用 C++11 兼容的写法初始化数据库连接（参数可配置化）
    dbConn_.reset(new DatabaseConnection(
        "postgres",
        "FreeXGIS_Server2025",
        "uav_management",
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

        odb::result<UavModelEntity> result = db.query<UavModelEntity>(query_t::true_expr);
        qDebug() << "Query returned" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        int sum = 0;
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
            obj["payloadType"] = QString::fromStdString(entity.uavInvestigationPayloadType_);
            obj["bombMethod"] = QString::fromStdString(entity.uavBombingway_);
            obj["recoveryMode"] = QString::fromStdString(entity.uavRecoveryway_);
            obj["operationMethod"] = QString::fromStdString(entity.uavOperationWay_);
            obj["hangingCapacity"] = QString::fromStdString(entity.uavHangingLoctionCapacity_);
            obj["uavInvisibility"] = QString::fromStdString(entity.uavInvisibility_);
            // obj["uavLength"] = QString::number(entity.uavLength_); // 使用 QString::number 方法转换 float
            // obj["uavWidth"] = QString::number(entity.uavWidth_);
            // obj["uavHeight"] = QString::number(entity.uavHeight_);
            // 使用 QDateTime 转换 std::time_t 到 QString

            QDateTime dateTime;
            dateTime = QDateTime::fromTime_t(static_cast<uint>(entity.uavCreatModelTime_));
            obj["uavCreatModelTime"] = dateTime.toString(Qt::ISODate);
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
    qDebug()<<"uavModelAllData:";
    qDebug().noquote() << doc.toJson(QJsonDocument::Indented);
    return uavModelData;

}

QJsonObject UavModelDao::selectSomeUavModelDate(const QJsonObject &object)
{
    QJsonObject uavModelData;
    //std::vector<person> persons;
    using query_t = odb::query<UavModelEntity>;
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
    qDebug() << "Transaction started";
    // try {


    //     // 3. 从JSON创建实体对象
    //     UavModelEntity entity;

    //     query_t q(query_t::true_c); // 初始化为无条件

    //     // 处理 age 字段（使用 > 条件，与原始代码一致）
    //     if (object.contains("uav_type") && object["uav_type"].isString()) {
    //         auto uav_type = object["uav_type"].toString();
    //         q = q && (query_t::uavType == uav_type.toStdString());
    //     }

    //     // 处理 name 字段（使用 == 条件）
    //     if (object.contains("uav_name") && object["uav_name"].isString()) {
    //         QString uav_name = object["uav_name"].toString();
    //         if (!uav_name.isEmpty()) {
    //             q = q && (query_t::uavName == uav_name.toStdString());
    //         }
    //     }
    //     if (object.contains("uav_id") && object["uav_id"].isString()) {
    //         QString uav_id = object["uav_id"].toString();
    //         if (!uav_id.isEmpty()) {
    //             q = q && (query_t::uavId == uav_id.toStdString());
    //         }
    //     }
    //     if (object.contains("hanging_capacity") && object["hanging_capacity"].isString()) {
    //         QString hanging_capacity = object["hanging_capacity"].toString();
    //         if (!hanging_capacity.isEmpty()) {
    //             q = q && (query_t::uavHangingLoctionCapacity == hanging_capacity.toStdString());
    //         }
    //     }
    //     if (object.contains("opreation_method") && object["opreation_method"].isString()) {
    //         QString opreation_method = object["opreation_method"].toString();
    //         if (!opreation_method.isEmpty()) {
    //             q = q && (query_t::uavOperationMethod == opreation_method.toStdString());
    //         }
    //     }
    //     if (object.contains("bomb_method") && object["bomb_method"].isString()) {
    //         QString bomb_method = object["bomb_method"].toString();
    //         if (!bomb_method.isEmpty()) {
    //             q = q && (query_t::uavBombingmethod == bomb_method.toStdString());
    //         }
    //     }
    //     if (object.contains("recovery_mode") && object["recovery_mode"].isString()) {
    //         QString recovery_mode = object["recovery_mode"].toString();
    //         if (!recovery_mode.isEmpty()) {
    //             q = q && (query_t::uavRecoverymode == recovery_mode.toStdString());
    //         }
    //     }
    //     if (object.contains("payload_type") && object["payload_type"].isString()) {
    //         QString payload_type = object["payload_type"].toString();
    //         if (!payload_type.isEmpty()) {
    //             q = q && (query_t::uavInvestigationPayloadType == payload_type.toStdString());
    //         }
    //     }

    //     // 执行查询
    //     auto r(db.query_one<entity>(q));
    //     // entity.assign(r.begin(), r.end());
    //     if(r){
    //         auto val{r.get()};
    //         uavModelData = val;
    //     }

    //     trans.commit();
    // } catch (const odb::exception& e) {
    //     qCritical() << "Database error:" << e.what();
    //     trans.rollback(); // 显式回滚事务（可选）
    //     throw; // 重新抛出异常或返回空结果
    // }
    return uavModelData;

}

bool UavModelDao::updateModelDate(const QJsonObject &object)
{
    QJsonObject uavModelData;
    // try {
    //     // 1. 建立数据库连接
    auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
    //     qDebug() << "Connecting to database...";
    //     odb::pgsql::database db(
    //         "postgres",       // username
    //         "123456",         // password
    //         "db_aux_prac_sys",// database
    //         "192.168.0.101",  // host
    //         5432              // port
    //         );

    //     // 2. 创建事务
    //     odb::transaction trans(db.begin());
    //     qDebug() << "Transaction started";
    //     // 3. 从JSON创建实体对象
    //     UavModelEntity entity;
    //     // 定义查询条件
    //     // unique_ptr<entity> john (
    //     //     db->query_one<entity> (query::first == "John" &&
    //     //                           query::last == "Doe"));
    //     // if (john.get () != 0)
    //     //     db->erase (*john);
    //     typedef odb::query<UavModelEntity> query;
    //     // 3. 加载要修改的实体
    //     std::shared_ptr<Person> person(db->load<Person>(1));  // 加载ID为1的记录


    //     db.load(1, entity);
    //     entity.uavName_("James");
    //     entity.age("Newland");
    //     // 4. 修改数据
    //     // person->name("James");
    //     // person->country("Newland");
    //     db.update(entity);
    // // 提交事务
    // trans.commit();
    // qDebug() << "Transaction committed, 数据更新成功";
    // } catch (const std::exception& e) {
    //     qCritical() << "Error:" << " 数据更新操作出错: " << e.what();
    // }
    return true;
}

bool UavModelDao::deleteModelDate(const QJsonArray &object)
{
    qDebug() << "Starting database Rows Delete...";
    QJsonObject checkResult;
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
            auto rst = db.query<UavModelEntity>(//db.erase_query<UavModelEntity>
                query::uavType == uavType.toStdString().c_str()
                && query::uavName == uavName.toStdString().c_str()
                && query::uavId == uavId.toStdString().c_str()
                // && query::uavInvestigationPayloadType == uavInvestigationPayloadType.toStdString()
                // && query::uavBombingmethod == uavBombingmethod.toStdString()
                // && query::uavRecoverymode == uavRecoverymode.toStdString()
                // && query::uavHangingLoctionCapacity == uavHangingLoctionCapacity.toStdString()
                // && query::uavOperationMethod == uavOperationMethod.toStdString()
                //&& query::uavCreatModelTime == uavCreatModelTime.toStdString().c_str()

                ); // 替换 condition1、condition2 为实际的字段名，value1、value2 为实际的值
            qDebug() << "===============================" << rst.size();
        }

        // 提交事务
        trans.commit();
        qDebug() << "Transaction committed, 删除成功";
    } catch (const std::exception& e) {
        qCritical() << "Error:" << "删除操作出错: " << e.what();
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
        "length", "width", "height", "invisibility",

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

bool UavModelDao::insertModelDate(const QJsonObject& object)
{
    qDebug() << "Starting database insertion...";
    QJsonObject checkResult;
    checkResult = checkUavDataObject(object);
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
        entity.uavType_ = checkResult["uav_type"].toString().toStdString();
        entity.uavName_ = checkResult["uav_name"].toString().toStdString();
        entity.uavId_ = checkResult["uav_id"].toString().toStdString();

        /******************** 尺寸参数 ********************/
        entity.uavLength_ = checkResult["length"].toDouble();
        entity.uavWidth_ = checkResult["width"].toDouble();
        entity.uavHeight_ = checkResult["height"].toDouble();
        entity.uavInvisibility_ = checkResult["invisibility"].toString().toStdString();

        /******************** 飞行性能 ********************/
        entity.uavFlightHeightRangeMin_ = checkResult["flight_height_min"].toDouble();
        entity.uavFlightHeightRangeMax_ = checkResult["flight_height_max"].toDouble();
        entity.uavFlightSpeedRangeMin_ = checkResult["flight_speed_min"].toDouble();
        entity.uavFlightSpeedRangeMax_ = checkResult["flight_speed_max"].toDouble();
        entity.uavFlightDistanceRangeMin_ = checkResult["flight_distance_min"].toDouble();
        entity.uavFlightDistanceRangeMax_ = checkResult["flight_distance_max"].toDouble();
        entity.uavFlightTimeRangeMin_ = checkResult["flight_time_min"].toDouble();
        entity.uavFlightTimeRangeMax_ = checkResult["flight_time_max"].toDouble();

        /******************** 起降参数 ********************/
        entity.uavTakeoffDistance_ = checkResult["takeoff_distance"].toDouble();
        entity.uavLandDistance_ = checkResult["landing_distance"].toDouble();

        /******************** 机动性能 ********************/
        entity.uavTurningRadiusRangeMin_ = checkResult["turn_radius_min"].toDouble();
        entity.uavTurningRadiusRangeMax_ = checkResult["turn_radius_max"].toDouble();
        entity.uavOperatioanalRadius_ = checkResult["combat_radius"].toDouble();

        /******************** 载荷配置 ********************/
        entity.uavInvestigationPayloadType_ = checkResult["payload_type"].toString().toStdString();
        entity.uavBombingway_ = checkResult["bomb_method"].toString().toStdString();
        entity.uavOperationWay_ = checkResult["operation_method"].toString().toStdString();
        entity.uavLoadReconnaissanceRangeMin_ = checkResult["recon_range_min"].toDouble();
        entity.uavLoadReconnaissanceRangeMax_ = checkResult["recon_range_max"].toDouble();
        entity.uavLoadReconnaissanceAccuracy_ = checkResult["recon_accuracy"].toDouble();

        /******************** 回收与突防 ********************/
        entity.uavRecoveryway_ = checkResult["recovery_mode"].toString().toStdString();
        entity.uavLowAltitudeBreakthroughSpeed_ = checkResult["low_alt_speed"].toDouble();

        /******************** 挂载能力 ********************/
        entity.uavHangingLoctionCapacity_ = checkResult["hardpoint_loc"].toString().toStdString();
        // entity.uavHangingpoints_ = checkResult["hardpoint_num"].toInt();
        // entity.uavPayloadcapacity_ = checkResult["payload_capacity"].toInt();
        entity.uavAttackaccuracy_ = checkResult["attack_accuracy"].toDouble();

        /******************** 雷达特征 ********************/
        entity.uavRadarCrossSection_ = checkResult["rcs"].toDouble();

        /******************** 重量与平衡 ********************/
        entity.uavCenterOfGravityFrontLimit_ = checkResult["cg_front_limit"].toDouble();
        entity.uavCenterOfGravityAfterwardLimit_ = checkResult["cg_rear_limit"].toDouble();
        entity.uavMaximumTakeoffWeight_ = checkResult["max_takeoff_weight"].toDouble();
        entity.uavEmptyWeight_ = checkResult["empty_weight"].toDouble();

        /******************** 燃油与载重 ********************/
        entity.uavMaximumFuelCapacity_ = checkResult["max_fuel"].toDouble();
        entity.uavMaximumExternalWeight_ = checkResult["max_external_weight"].toDouble();

        /******************** 高度性能 ********************/
        entity.uavCeiling_ = checkResult["ceiling"].toDouble();
        entity.uavMaximumGroundStartingHeight_ = checkResult["ground_start_alt"].toDouble();
        entity.uavMaximumAirStartingAltitude_ = checkResult["air_start_alt"].toDouble();

        /******************** 续航性能 ********************/
        entity.uavMaximumEndurance_ = checkResult["endurance"].toDouble();
        entity.uavMaximumFlightVacuumSpeed_ = checkResult["max_vacuum_speed"].toDouble();
        entity.uavMinimumFlightMeterSpeed_ = checkResult["min_meter_speed"].toDouble();

        /******************** 特殊场景性能 ********************/
        entity.sealLevelTakeoffAndRollDistance_ = checkResult["sea_takeoff_roll"].toDouble();
        entity.sealLevelLandingAndRollDistance_ = checkResult["sea_landing_roll"].toDouble();
        entity.cruiseAltitudeReconnaissanceConfiguration_ = checkResult["recon_cruise_alt"].toDouble();
        entity.cruiseAltitudeFullExternalConfiguration_ = checkResult["full_external_cruise_alt"].toDouble();

        /******************** 系统记录 ********************/
        entity.uavCreatModelTime_ = recordCreationTime.toTime_t();
        entity.uavImgName_ = checkResult["image_name"].toString().toStdString();
        entity.uavImgUrl_ = checkResult["image_url"].toString().toStdString();

        // 5. 数据验证
        // if (entity.getUavType().empty()) {
        //     throw std::invalid_argument("Missing required field: uav_type");
        // }

        // 6. 持久化到数据库
        qDebug() << "Persisting entity...";
        auto id = db.persist(entity);

        // 7. 提交事务
        trans.commit();
        qDebug() << "Transaction committed, ID:" << id;

        return id;
    }
    catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        throw;
    }
    catch (const std::exception& e) {
        qCritical() << "Error:" << e.what();
        throw;
    }
}

void UavModelDao::test()
{
    QJsonObject uavJson = {
        {"uav_type", "侦察型"},
        {"uav_name", "鹰眼-2023"},
        {"uav_id", "UAV-001"},
        {"length", 8.5},
        {"width", 15.2},
        // ... 其他字段
    };
    QJsonObject inputObj;
    inputObj["uav_type"] = "侦察型无人机";
    inputObj["uav_name"] = "鹰眼-2023";
    inputObj["uav_id"] = "UAV-001";
    inputObj["flight_height_max"] = 12000.5;
    inputObj["custom_field"] = "额外数据";
    QJsonObject checkResult;
    checkResult = checkUavDataObject(inputObj);
    // 验证结果
    //qDebug() << QJsonDocument(checkResult).toJson(QJsonDocument::Indented);
    try {
        bool newId = insertModelDate(uavJson);

        qDebug() << "Successfully inserted record with ID:" << newId;
    }
    catch (...) {
        qDebug() << "Failed to insert record";
    }
}
