#include "uavmountlocationdao.h"
#include "UavModelMountLocationEntity.h"
#include "UavModelMountLocationEntity-odb.hxx"

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
UavMountLocationDao::UavMountLocationDao(QObject* parent) : QObject(parent) {
    // 使用 C++11 兼容的写法初始化数据库连接（参数可配置化）
    dbConn_.reset(new DatabaseConnection(
        "uav_type_man",
        "uav_type_man",
        "db_aux_prac_sys",
        "192.168.0.101",
        5432
        ));
}

QJsonArray UavMountLocationDao::selectUavMountLocationAllData()
{
    QJsonArray uavMountLocationData;

    try{

        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction select all uavMountLocation started";
        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<UavModelMountLocationEntity>;

        odb::result<UavModelMountLocationEntity> result = db.query<UavModelMountLocationEntity>(query_t::true_expr);
        qDebug() << "Query returned" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        int sum = 0;
        bool checked = false;
        if(result.size()==0){
            return uavMountLocationData;
        }
        for (UavModelMountLocationEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "Processing record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["uavmountLocationId"] = QString::number(entity.mountLocationId_);
            obj["uavmountLocationName"] = QString::fromStdString(entity.mountLocationName_);
            obj["uavmountLocationQuantity"] = QString::number(entity.mountlocationQuantity_);
            obj["uavmountLocationCapacity"] = QString::number(entity.mountlocationCapacity_);
            obj["uavModelName"] = QString::fromStdString(entity.uavModelName_);
            obj["checked"] = checked;
            sum++;
            qDebug()<<"uavModelAllDatauavcreat:";
            uavMountLocationData.append(obj);
        }
        trans.commit();
    }
    catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        throw; // 或返回包含错误信息的 JSON
    }
    QJsonDocument doc(uavMountLocationData);
    qDebug()<<"当前函数名称:" << __FUNCTION__<<":";
    qDebug().noquote() << doc.toJson(QJsonDocument::Indented);
    return uavMountLocationData;
}

QJsonArray UavMountLocationDao::queryUavToMountData(const QJsonObject &uavModel)
{
    QJsonArray uavToMountArray;

    using query_t = odb::query<UavModelMountLocationEntity>;
    // 1. 建立数据库连接
    qDebug() << "Connecting to database...";

    auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

    // 2. 创建事务
    odb::transaction trans(db.begin());
    qDebug() << "Transaction started";
    try {

        // 3. 从JSON创建实体对象
        UavModelMountLocationEntity entity;

        query_t q(query_t::true_expr); // 初始化为无条件
        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<UavModelMountLocationEntity>;
        if (uavModel["uavModelName"] == ""){
            qDebug()<<"查询全部无人机类型";
        }else{
            if (uavModel.contains("uavModelName") && uavModel["uavModelName"].isString()) {
                auto uav_type = uavModel["uavModelName"].toString();
                q = q && (query_t::uavModelName == uav_type.toStdString());
            }
        }
        odb::result<UavModelMountLocationEntity> result = db.query<UavModelMountLocationEntity>(q);
        qDebug() << "Query returned" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        int sum = 0;
        bool checked = false;
        if(result.size()==0){
            return uavToMountArray;
        }

        for (UavModelMountLocationEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "Processing record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["uavModelName"] = QString::fromStdString(entity.uavModelName_);
            obj["uavmountLocationName"] = QString::fromStdString(entity.mountLocationName_);
            obj["uavmountLocationId"] = QString::number(entity.mountLocationId_);
            obj["uavmountLocationCapacity"] = QString::number(entity.mountlocationCapacity_);
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

bool UavMountLocationDao::updateUavMountLocationDate(const QJSValue &selectedData)
{
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to updateUavMountLocationDate database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction delete started";
        // 3. 从JSON创建实体对象
        UavModelMountLocationEntity entity;
        typedef odb::query<UavModelMountLocationEntity> query;
        // 将 QJSValue 转换为 QVariantList
        QVariantList dataList = selectedData.toVariant().toList();

        // 处理数据遍历
        for (const QVariant &item : dataList) {
            QVariantMap dataMap = item.toMap();
            qDebug() << "uavmountLocationQuantity:" << dataMap["uavmountLocationName"].toString().toStdString().c_str();
            qDebug() << "uavmountLocationCapacity:" << dataMap["uavmountLocationId"].toString().toStdString().c_str();
            int  recordId = dataMap["recordId"].toInt();
            QString mountLocationNameStr = dataMap["uavmountLocationName"].toString();
            QString mountLocationIdStr = dataMap["uavmountLocationId"].toString();
            QString uavModelNameStr = dataMap["uavModelName"].toString();
            float  mountlocationQuantityStr = dataMap["uavmountLocationQuantity"].toString().toDouble();
            float  uavmountLocationCapacityStr = dataMap["uavmountLocationCapacity"].toString().toDouble();
            db.load(recordId, entity);
            entity.mountLocationName_ = mountLocationNameStr.toStdString();
            entity.mountLocationId_ = mountLocationIdStr.toInt();
            entity.mountlocationQuantity_ = mountlocationQuantityStr;
            entity.mountlocationCapacity_ = uavmountLocationCapacityStr;
            entity.uavModelName_ = uavModelNameStr.toStdString();
            qDebug() << "before update";
            // 4. 修改数据
            db.update(entity);
            qDebug() << "after update";
            qDebug() << "recordId:" << dataMap["recordId"].toInt();
            qDebug() << "uavmountLocationName:" << dataMap["uavmountLocationName"].toString();
            qDebug() << "uavmountLocationId:" << dataMap["uavmountLocationId"].toString();
            qDebug() << "uavmountLocationQuantity:" << dataMap["uavmountLocationQuantity"].toFloat();
            qDebug() << "uavmountLocationCapacity:" << dataMap["uavmountLocationCapacity"].toFloat();
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

bool UavMountLocationDao::deleteUavMountLocationDate(const QJSValue &selectedData)
{
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction delete started";
        // 3. 从JSON创建实体对象
        UavModelMountLocationEntity entity;
        typedef odb::query<UavModelMountLocationEntity> query;
        // 将 QJSValue 转换为 QVariantList
        QVariantList dataList = selectedData.toVariant().toList();

        // 处理数据遍历
        for (const QVariant &item : dataList) {
            QVariantMap dataMap = item.toMap();
            int  recordId = dataMap["recordId"].toInt();
            QString mountLocationNameStr = dataMap["uavmountLocationName"].toString();
            QString mountLocationIdStr = dataMap["uavmountLocationId"].toString();
            auto rst = db.erase_query<UavModelMountLocationEntity>(//db.erase_query<UavModelEntity>
            query::id == recordId
            && query::mountLocationName == mountLocationNameStr.toStdString().c_str()
                //&& query::mountLocationId == mountLocationIdStr.toInt()//.c_str()
            ); // 替换 condition1、condition2 为实际的字段名，value1、value2 为实际的值
            qDebug() << "recordId:" << dataMap["recordId"].toInt();
            qDebug() << "uavmountLocationName:" << dataMap["uavmountLocationName"].toString();
            qDebug() << "uavmountLocationId:" << dataMap["uavmountLocationId"].toString();
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

bool UavMountLocationDao::insertUavMountLocationDate(const QJsonObject &object)
{   qDebug() << "Starting database insertUavMountLocationDate insertion...";
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction insert started";

        // 3. 从JSON创建实体对象
        UavModelMountLocationEntity entity;
        QDateTime recordCreationTime;//创建记录时间

        // 4. 映射JSON字段到实体属性
        // 基础字段
        entity.mountLocationId_ = object["uavmountLocationId"].toInt();
        entity.mountLocationName_ = object["uavmountLocationName"].toString().toStdString();
        entity.mountlocationQuantity_ = object["uavmountLocationQuantity"].toDouble();
        entity.mountlocationCapacity_ = object["uavmountLocationCapacity"].toDouble();
        entity.uavModelName_ = object["uavModelName"].toString().toStdString();
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
