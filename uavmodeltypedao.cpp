#include "uavmodeltypedao.h"
#include "UavModelTypeEntity.h"
#include "UavModelTypeEntity-odb.hxx"
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
UavModelTypeDao::UavModelTypeDao(QObject* parent) : QObject(parent) {
    // 使用 C++11 兼容的写法初始化数据库连接（参数可配置化）
    dbConn_.reset(new DatabaseConnection(
        "uav_type_man",
        "uav_type_man",
        "db_aux_prac_sys",
        "192.168.0.101",
        5432
        ));
}

QJsonArray UavModelTypeDao::selectUavModelTypeAllData()
{
    QJsonArray uavComponentData;

    try{

        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction select all uavMountLocation started";
        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<UavModelTypeEntity>;

        odb::result<UavModelTypeEntity> result = db.query<UavModelTypeEntity>(query_t::uavModelTypeStatus == true );//:true_expr);
        qDebug() << "Query returned uavComponentDatauavModelAllDatauavcreat" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        int sum = 1;
        bool checked = false;
        if(result.size()==0){
            return uavComponentData;
        }
        for (UavModelTypeEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "ProcessingQuery returned uavComponentDatauavModelAllDatauavcreat record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["uavComponeCode"] = QString::fromStdString(entity.uavModelTypeCode_);
            obj["uavComponeName"] = QString::fromStdString(entity.uavModelTypeName_);
            //obj["status"] = QString::number(entity.uavLaunchStatus_);
            obj["checked"] = checked;
            sum++;
            qDebug()<<"uavComponentDatauavModelAllDatauavcreat:";
            uavComponentData.append(obj);
        }
        trans.commit();
    }
    catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        throw; // 或返回包含错误信息的 JSON
    }
    QJsonDocument doc(uavComponentData);
    qDebug()<<"当前函数名称:" << __FUNCTION__<<":";
    qDebug().noquote() << doc.toJson(QJsonDocument::Indented);
    return uavComponentData;
}

QJsonArray UavModelTypeDao::selectUavModelTypeData()
{
    QJsonArray uavComponentData;

    try{

        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction select all uavMountLocation started";
        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<UavModelTypeEntity>;

        odb::result<UavModelTypeEntity> result = db.query<UavModelTypeEntity>(query_t::true_expr);
        qDebug() << "Query returned uavComponentDatauavModelAllDatauavcreat" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        int sum = 1;
        bool checked = false;
        if(result.size()==0){
            return uavComponentData;
        }
        for (UavModelTypeEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "ProcessingQuery returned uavComponentDatauavModelAllDatauavcreat record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["uavComponeCode"] = QString::fromStdString(entity.uavModelTypeCode_);
            obj["uavComponeName"] = QString::fromStdString(entity.uavModelTypeName_);
            //obj["status"] = QString::number(entity.uavLaunchStatus_);
            obj["checked"] = checked;
            sum++;
            qDebug()<<"uavComponentDatauavModelAllDatauavcreat:";
            uavComponentData.append(obj);
        }
        trans.commit();
    }
    catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        throw; // 或返回包含错误信息的 JSON
    }
    QJsonDocument doc(uavComponentData);
    qDebug()<<"当前函数名称:" << __FUNCTION__<<":";
    qDebug().noquote() << doc.toJson(QJsonDocument::Indented);
    return uavComponentData;
}

QJsonArray UavModelTypeDao::queryUavModelTypeData(const QJsonObject &uavModel)
{
    QJsonArray uavToMountArray;

    using query_t = odb::query<UavModelTypeEntity>;
    // 1. 建立数据库连接
    qDebug() << "Connecting to database...";

    auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

    // 2. 创建事务
    odb::transaction trans(db.begin());
    qDebug() << "Transaction started";
    try {

        // 3. 从JSON创建实体对象
        UavModelTypeEntity entity;

        query_t q(query_t::true_expr); // 初始化为无条件
        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<UavModelTypeEntity>;
        if (uavModel["uavComponeName"] == ""){
            qDebug()<<"查询全部无人机类型";
        }else{
            if (uavModel.contains("uavComponeName") && uavModel["uavComponeName"].isString()) {
                auto uav_type = uavModel["uavComponeName"].toString();
                q = q && (query_t::uavModelTypeName == uav_type.toStdString());
            }
        }
        odb::result<UavModelTypeEntity> result = db.query<UavModelTypeEntity>(q);
        qDebug() << "Query returned" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        int sum = 0;
        bool checked = false;
        if(result.size()==0){
            return uavToMountArray;
        }

        for (UavModelTypeEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "Processing record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["uavComponeCode"] = QString::fromStdString(entity.uavModelTypeCode_);
            obj["uavComponeName"] = QString::fromStdString(entity.uavModelTypeName_);
            obj["uavComponeStatus"] = QString::number(entity.uavModelTypeStatus_);
            obj["checked"] = checked;
            sum++;
            qDebug()<<"uavModelAllDatauavcreat:";
            uavToMountArray.append(obj);
        }
        trans.commit();
    } catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        trans.rollback(); // 显式回滚事务（可选）
        throw; // 重新抛出异常或返回空结果
    }
    return uavToMountArray;
}

bool UavModelTypeDao::updateUavModelTypeData(const QJSValue &selectedData)
{
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to updateUavMountLocationDate database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction delete started";
        // 3. 从JSON创建实体对象
        UavModelTypeEntity entity;
        typedef odb::query<UavModelTypeEntity> query;
        // 将 QJSValue 转换为 QVariantList
        QVariantList dataList = selectedData.toVariant().toList();

        // 处理数据遍历
        for (const QVariant &item : dataList) {
            QVariantMap dataMap = item.toMap();
            qDebug() << "uavModelTypeName:" << dataMap["uavComponeName"].toString().toStdString().c_str();
            qDebug() << "uavLaunchWayId:" << dataMap["uavComponeCode"].toString().toStdString().c_str();
            int  recordId = dataMap["recordId"].toInt();
            QString uavNameStr = dataMap["uavComponeName"].toString();
            //QString uavIdStr = dataMap["uavComponeCode"].toString();
            //bool uavStatusStr = dataMap["uavStatus"].toBool();
            // float  mountlocationQuantityStr = dataMap["uavmountLocationQuantity"].toString().toDouble();
            // float  uavmountLocationCapacityStr = dataMap["uavmountLocationCapacity"].toString().toDouble();
            db.load(recordId, entity);
            //entity.uavtypeCode_ = uavIdStr.toInt();
            entity.uavModelTypeName_= uavNameStr.toStdString();
            //entity.uavTypeStatus_ = uavStatusStr;
            qDebug() << "before update";
            // 4. 修改数据
            db.update(entity);
            qDebug() << "after update";
            qDebug() << "recordId:" << dataMap["recordId"].toInt();
            qDebug() << "uavLaunchWayName:" << dataMap["uavComponeName"].toString();
            qDebug() << "uavLaunchWayId:" << dataMap["uavComponeCode"].toString();
            qDebug() << "uavLaunchWayStatus:" << dataMap["uavStatus"].toBool();
            //qDebug() << "<<<<>>>>" << rst.size();
        }

        // 提交事务
        trans.commit();
        qDebug() <<"当前函数名称:" << __FUNCTION__<<":"<< "Transaction committed, 更新成功";
    } catch (const std::exception& e) {
        qCritical() << "Error:" << "更新操作出错: " << e.what();
        return false;
    }
    return true;
}

bool UavModelTypeDao::deleteUavModelTypeData(const QJSValue &selectedData)
{
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction delete started";
        // 3. 从JSON创建实体对象
        UavModelTypeEntity entity;
        typedef odb::query<UavModelTypeEntity> query;
        // 将 QJSValue 转换为 QVariantList
        QVariantList dataList = selectedData.toVariant().toList();

        // 处理数据遍历
        for (const QVariant &item : dataList) {
            QVariantMap dataMap = item.toMap();
            int  recordId = dataMap["recordId"].toInt();
            //QString uavNameStr = dataMap["uavComponeName"].toString();
            //QString uavIdStr = dataMap["uavComponeCode"].toString();
            bool uavStatusStr = false ;
            db.load(recordId, entity);
            //entity.uavtypeCode_ = uavIdStr.toInt();
            //entity.uavTypeName_= uavNameStr.toStdString();
            entity.uavModelTypeStatus_= uavStatusStr;
            qDebug() << "before update";
            // 4. 修改数据
            db.update(entity);
            // auto rst = db.erase_query<uavTypeEntity>(//db.erase_query<UavModelEntity>
            //     query::id == recordId
            //     && query::uavTypeName == uavNameStr.toStdString().c_str()
            //     //&& query::mountLocationId == mountLocationIdStr.toInt()//.c_str()
            //     ); // 替换 condition1、condition2 为实际的字段名，value1、value2 为实际的值
            qDebug() << "recordId:" << dataMap["recordId"].toInt();
            qDebug() << "uavModelTypeName:" << dataMap["uavComponeName"].toString();
            qDebug() << "uavModelTypeId:" << dataMap["uavComponeCode"].toString();
            //qDebug() << "<<<<>>>>" << rst.size();
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

bool UavModelTypeDao::insertUavModelTypeData(const QJsonObject &object)
{
    qDebug() << "Starting database insertUavMountLocationDate insertion...";
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction insert started";

        // 3. 从JSON创建实体对象
        UavModelTypeEntity entity;
        QDateTime recordCreationTime;//创建记录时间

        // 4. 映射JSON字段到实体属性
        // 基础字段
        entity.uavModelTypeCode_ = object["uavComponeCode"].toString().toStdString();//.toInt();
        entity.uavModelTypeName_ = object["uavComponeName"].toString().toStdString();
        entity.uavModelTypeStatus_ = object["uavStatus"].toBool();
        // entity.mountlocationCapacity_ = object["uavmountLocationCapacity"].toDouble();
        // entity.uavModelName_ = object["uavModelName"].toString().toStdString();
        // 6. 持久化到数据库
        qDebug() << "Persisting entity...";
        auto id = db.persist(entity);

        // 7. 提交事务
        trans.commit();
        qDebug() <<"当前函数名称:" << __FUNCTION__<<":"<< "Transaction committed, ID:" << id;

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
    return true;
}
