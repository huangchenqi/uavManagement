#include "mountingschemedao.h"
#include "MountingSchemeEntity.h"
#include "MountingSchemeEntity-odb.hxx"
#include <stdexcept>
// ODB 头文件
#include <odb/database.hxx>
#include <odb/transaction.hxx>
#include <odb/query.hxx>
#include <odb/pgsql/database.hxx>
#include "databaseconnection.h"
#include "odb/pgsql/traits.hxx"
#include <QJsonObject>
#include <QJsonValue>
#include <QDebug>
#include <QDateTime>
MountingSchemeDao::MountingSchemeDao(QObject* parent) : QObject(parent){
    // 使用 C++11 兼容的写法初始化数据库连接（参数可配置化）
    dbConn_.reset(new DatabaseConnection(
        "uav_type_man",
        "uav_type_man",
        "db_aux_prac_sys",
        "192.168.0.101",
        5432
        ));

}
QJsonArray MountingSchemeDao::selectMountingSchemeData(const QJsonObject &selectedData)
{
    QJsonArray ammoModelData;
    QJsonDocument adoc(selectedData);
    qDebug()<<"当前xASRA wae  q函数名称:" << __FUNCTION__<<":";
    qDebug().noquote() << adoc.toJson(QJsonDocument::Indented);

    try{
        // 1. 建立数据库连接
        qDebug() << "Connecting to selectAmmoAllData database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction select all started";
        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<UavMountSchemeEntity>;

        // 3. 从JSON创建实体对象
        UavMountSchemeEntity entity;

        query_t q(query_t::status == true); // 初始化为无条件query_t::true_expr

        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<UavMountSchemeEntity>;
//        if (selectedData["ammoType"] == "请选择:"){
//            qDebug()<<"查询全部无人机类型";
//        }else{
//            if (selectedData.contains("ammoType") && selectedData["ammoType"].isString()) {
//                auto ammoType = selectedData["uavType"].toString();
//                q = q && (query_t::ammoType == ammoType.toStdString());
//            }
//        }
        if (selectedData["mountSchemeName"] == ""){
            qDebug()<<"查询全部无人机名称";
        }else{
            // 处理 name 字段（使用 == 条件）
            if (selectedData.contains("mountSchemeName") && selectedData["mountSchemeName"].isString()) {
                QString mountSchemeName = selectedData["mountSchemeName"].toString();
                if (!mountSchemeName.isEmpty()) {
                    q = q && (query_t::mountSchemeName == mountSchemeName.toStdString());
                }
            }
        }
        odb::result<UavMountSchemeEntity> result = db.query<UavMountSchemeEntity>(q);
        qDebug() << "Query returned" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        if(result.size()==0){
            return ammoModelData;
        }



//        odb::result<AmmunitionEntity> result = db.query<AmmunitionEntity>(query_t::true_expr);
//        qDebug() << "Query returned" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        int sum = 1;
        bool checked = false;
        if(result.size()==0){
            return ammoModelData;
        }

        for (UavMountSchemeEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "Processing record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["mountSchemeName"] = QString::fromStdString(entity.mountSchemeName_);
            obj["uavName"] = QString::fromStdString(entity.uavName_);
            obj["maxTakeoffWeight"] = QString::number(entity.maxTakeoffWeight_);
            //obj["ammoToUavModel"] = QString::fromStdString(entity.ammoToUavModel_);
            obj["runningDistance"] = QString::number(entity.runningDistance_);
            obj["endurance"] = QString::number(entity.endurance_);
            obj["fightRadius"] = QString::number(entity.fightRadius_);
            obj["emptyWeight"] = QString::number(entity.emptyWeight_);
            obj["maxFuel"] = QString::number(entity.maxFuel_);
            obj["maxExternalWeight"] = QString::number(entity.maxExternalWeight_);
            // obj["launch_angle"] = QString::number(entity.launchAngle_);
            // obj["launch_method"] = QString::fromStdString(entity.launchWay_);
            // obj["approve_attack_target_type"] = QString::fromStdString(entity.approveAttackTargetType_);
            // obj["killing_dose"] = QString::number(entity.killingDose_);
            // obj["killing_method"] = QString::fromStdString(entity.killingMethod_);
            // obj["killing_depth"] = QString::number(entity.killingDepth_);
            // obj["killing_range_min"] = QString::number(entity.killingRangeMin_);
            // obj["killing_range_max"] = QString::number(entity.killingRangeMax_);
            // // 使用 QDateTime 转换 std::time_t 到 QString
            // obj["image_url"] = QString::fromStdString(entity.ammoImgUrl_);
            // obj["image_name"] = QString::fromStdString(entity.ammoName_);
            // QDateTime dateTime;
            // dateTime = entity.recordCreationTime_;
            // qDebug() <<"recordcreation_time"<< entity.recordCreationTime_;
            // obj["recordcreation_time"] = entity.recordCreationTime_.toString(Qt::ISODate);


            //obj["operation"] = "";
            obj["checked"] = checked;
            sum++;

            ammoModelData.append(obj);
        }
        trans.commit();
        //qDebug()<<"ammoModelData:"<<sum;
    }
    catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        throw; // 或返回包含错误信息的 JSON
    }
    QJsonDocument doc(ammoModelData);
    qDebug()<<"当前函数名称:" << __FUNCTION__<<":";
    qDebug().noquote() << doc.toJson(QJsonDocument::Indented);
    return ammoModelData;
}

bool MountingSchemeDao::updateMountingSchemeData(const QJsonObject &selectedData)
{
    return  true;
}

bool MountingSchemeDao::deleteMountingSchemeData(const QJSValue &selectedData)
{
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction delete UavMountSchemeEntity started";
        // 3. 从JSON创建实体对象
        UavMountSchemeEntity entity;
        typedef odb::query<UavMountSchemeEntity> query;
        // 将 QJSValue 转换为 QVariantList
        QVariantList dataList = selectedData.toVariant().toList();

        // 处理数据遍历
        for (const QVariant &item : dataList) {
            QVariantMap dataMap = item.toMap();
            int  recordId = dataMap["recordId"].toInt();
            //QString ammoNameStr = dataMap["ammoComponeName"].toString();
            //QString ammoIdStr = dataMap["ammoComponeCode"].toString();
            bool ammoStatusStr = false;
            db.load(recordId, entity);
            //entity.ammoAttackTargetCode_ = ammoIdStr.toInt();
            //entity.ammoAttackTargetName_= ammoNameStr.toStdString();
            entity.status_ = ammoStatusStr;
            qDebug() << "before update";
            // 4. 修改数据
            db.update(entity);
            // auto rst = db.erase_query<AmmoAttackTargetTypeEntity>(//db.erase_query<UavModelEntity>
            //     query::id == recordId
            //     && query::ammoAttackTargetName == ammoNameStr.toStdString().c_str()
            //     //&& query::mountLocationId == mountLocationIdStr.toInt()//.c_str()
            //     ); // 替换 condition1、condition2 为实际的字段名，value1、value2 为实际的值
            qDebug() << "recordId:" << dataMap["recordId"].toInt();
//            qDebug() << "mountName:" << dataMap["ammoComponeName"].toString();
//            qDebug() << "ammoLaunchWayId:" << dataMap["ammoComponeCode"].toString();
            //qDebug() << "<<<<>>>>" << rst.size();
        }

        // 提交事务
        trans.commit();
        qDebug() <<"当前函数名称:" << __FUNCTION__<<":"<< "Transaction committed, 删除成功";
    } catch (const std::exception& e) {
        qCritical() << "Error:" << "删除操作出错: " << e.what();
        return false;
    }
    return  true;
}

bool MountingSchemeDao::insertMountingSchemeData(const QJsonObject &selectedData)
{
    return  true;
}
