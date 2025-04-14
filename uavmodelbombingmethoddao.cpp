#include "uavmodelbombingmethoddao.h"
#include "UavModelBombingMethodEntity.h"
#include "UavModelBombingMethodEntity-odb.hxx"

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
UavModelBombingMethodDao::UavModelBombingMethodDao(QObject* parent) : QObject(parent) {
    // 使用 C++11 兼容的写法初始化数据库连接（参数可配置化）
    dbConn_.reset(new DatabaseConnection(
        "uav_type_man",
        "uav_type_man",
        "db_aux_prac_sys",
        "192.168.0.101",
        5432
        ));
}


QJsonArray UavModelBombingMethodDao::selectUavModelBombingMethodAllData()
{
    QJsonArray uavModelBombingMethodData;

    try{

        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction select all UavModelBombingMethodEntity started";
        // 关键修正1：使用 query<UavModelBombingMethodEntity> 获取结果集
        using query_t = odb::query<UavModelBombingMethodEntity>;

        odb::result<UavModelBombingMethodEntity> result = db.query<UavModelBombingMethodEntity>(query_t::true_expr);
        qDebug() << "Query returned" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        int sum = 0;
        bool checked = false;
        if(result.size()==0){
            return uavModelBombingMethodData;
        }
        for (UavModelBombingMethodEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "Processing record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["uavComponeCode"] = QString::fromStdString(entity.bombingMethodCode_);
            obj["uavComponeName"] = QString::fromStdString(entity.bombingMethodName_);
            obj["checked"] = checked;
            sum++;
            qDebug()<<"uavModelAllDatauavcreat:";
            uavModelBombingMethodData.append(obj);
        }
        trans.commit();
    }
    catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        throw; // 或返回包含错误信息的 JSON
    }
    QJsonDocument doc(uavModelBombingMethodData);
    qDebug()<<"当前函数名称:" << __FUNCTION__<<":";
    qDebug().noquote() << doc.toJson(QJsonDocument::Indented);
    return uavModelBombingMethodData;
}

bool UavModelBombingMethodDao::updateUavModelBombingMethodDate(const QJSValue &selectedData)
{
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to updateUavModelBombingMethodDate database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction delete started";
        // 3. 从JSON创建实体对象
        UavModelBombingMethodEntity entity;
        typedef odb::query<UavModelBombingMethodEntity> query;
        // 将 QJSValue 转换为 QVariantList
        QVariantList dataList = selectedData.toVariant().toList();

        // 处理数据遍历
        for (const QVariant &item : dataList) {
            QVariantMap dataMap = item.toMap();
            int  recordId = dataMap["recordId"].toInt();
            QString uavComponeNameStr = dataMap["uavComponeName"].toString();
            //QString uavComponeCodeStr = dataMap["uavComponeCode"].toString();
            db.load(recordId, entity);
            entity.bombingMethodName_ = uavComponeNameStr.toStdString();
            //entity.bombingMethodCode_ = uavComponeCodeStr.toStdString();

            // 4. 修改数据
            db.update(entity);
            qDebug() << "recordId:" << dataMap["recordId"].toInt();
            qDebug() << "uavComponeName:" << dataMap["uavComponeName"].toString();
            qDebug() << "uavComponeCode:" << dataMap["uavComponeCode"].toString();
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

bool UavModelBombingMethodDao::deleteUavModelBombingMethodDate(const QJSValue &selectedData)
{
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction delete started";
        // 3. 从JSON创建实体对象
        UavModelBombingMethodEntity entity;
        typedef odb::query<UavModelBombingMethodEntity> query;
        // 将 QJSValue 转换为 QVariantList
        QVariantList dataList = selectedData.toVariant().toList();

        // 处理数据遍历
        for (const QVariant &item : dataList) {
            QVariantMap dataMap = item.toMap();
            int  recordId = dataMap["recordId"].toInt();
            QString uavComponeNameStr = dataMap["uavComponeName"].toString();
            //QString uavComponeCodeStr = dataMap["uavComponeCode"].toString();
            auto rst = db.erase_query<UavModelBombingMethodEntity>(//db.erase_query<UavModelEntity>
                query::id == recordId
                && query::bombingMethodName == uavComponeNameStr.toStdString().c_str()
                //&& query::bombingMethodCode == uavComponeCodeStr.toStdString().c_str()
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

bool UavModelBombingMethodDao::insertUavModelBombingMethodDate(const QJsonObject &object)
{
    qDebug() << "Starting database insertUavModelBombingMethodDate insertion...";
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction insert started";

        // 3. 从JSON创建实体对象
        UavModelBombingMethodEntity entity;
        QDateTime recordCreationTime;//创建记录时间

        // 4. 映射JSON字段到实体属性
        // 基础字段
        entity.bombingMethodCode_ = object["uavComponeCode"].toString().toStdString();
        entity.bombingMethodName_ = object["uavComponeName"].toString().toStdString();

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
