#include "mountingschemedao.h"
#include "MountingSchemeEntity.h"
#include "MountingSchemeEntity-odb.hxx"
#include <stdexcept>
#include "iostream"
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
struct order{
    template<typename T>
    static odb::query<T> by(::std::string column, ::std::string p = "DESC"){
        return odb::query<T>{"order by "} + column + p;
    }
};
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
        odb::result<UavMountSchemeEntity> result = db.query<UavMountSchemeEntity>(q+ order::by<UavMountSchemeEntity>(query_t::recordCreationTime.column()));
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

QJsonObject MountingSchemeDao::queryMountingSchemeData(const QJsonObject &selectedData)
{
    QJsonObject mountSchemeData;
    return mountSchemeData;
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

bool MountingSchemeDao::insertMountingSchemeData(const QJsonObject &object)
{
    qDebug() << "Starting database insertUavMountLocationDate insertion...";
    QJsonDocument doc(object);
    qDebug()<<"当前函数名称:" << __FUNCTION__<<":";
    qDebug().noquote() << doc.toJson(QJsonDocument::Indented);
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction insert Ammo started";

        // 3. 从JSON创建实体对象
        UavMountSchemeEntity entity;
        QDateTime recordCreationTime;//创建记录时间

        // 4. 映射JSON字段到实体属性
        // 基础字段
        //#pragma db not_null column("ammo_name")//            VARCHAR(100) NOT NULL ,--COMMENT '名称',


        entity.mountSchemeName_ = object["mountSchemeName"].toString().toStdString();//.toInt();
        entity.uavName_ = object["uavName"].toString().toStdString();
        entity.maxTakeoffWeight_ = object["maxTakeoffWeight"].toDouble();
        entity.emptyWeight_ = object["emptyWeight"].toDouble();
        entity.oneHangingPoint_ = object["oneHangingPoint"].toString().toStdString();//.toInt();
        entity.oneLocation_ = object["oneLocation"].toString().toStdString();
        entity.oneAmmoName_ = object["oneAmmoName"].toString().toStdString();
        entity.twoHangingPoint_ = object["twoHangingPoint"].toString().toStdString();
        entity.twoLocation_ = object["twoLocation"].toString().toStdString();
        entity.twoAmmoName_ = object["twoAmmoName"].toString().toStdString();//.toInt();
        entity.threeHangingPoint_ = object["threeHangingPoint"].toString().toStdString();
        entity.threeLocation_ = object["threeLocation"].toString().toStdString();
        entity.threeAmmoName_ = object["threeAmmoName"].toString().toStdString();
        entity.fourHangingPoint_ = object["fourHangingPoint"].toString().toStdString();
        entity.fourLocation_ = object["fourLocation"].toString().toStdString();//.toInt();
        entity.fourAmmoName_ = object["fourAmmoName"].toString().toStdString();
        entity.fiveHangingPoint_ = object["fiveHangingPoint"].toString().toStdString();//.toInt();
        entity.fiveLocation_ = object["fiveLocation"].toString().toStdString();
        entity.fiveAmmoName_ = object["fiveAmmoName"].toString().toStdString();//.toInt();
        entity.sixHangingPoint_ = object["sixHangingPoint"].toString().toStdString();
        entity.sixLocation_ = object["sixLocation"].toString().toStdString();//.toInt();
        entity.sixAmmoName_ = object["sixAmmoName"].toString().toStdString();
        entity.sevenHangingPoint_ = object["sevenHangingPoint"].toString().toStdString();//.toInt();
        entity.sevenLocation_ = object["sevenLocation"].toString().toStdString();
        entity.sevenAmmoName_ = object["sevenAmmoName"].toString().toStdString();//.toInt();
        entity.eightHangingPoint_ = object["eightHangingPoint"].toString().toStdString();
        entity.eightLocation_ = object["eightLocation"].toString().toStdString();//.toInt();
        entity.eightAmmoName_ = object["eightAmmoName"].toString().toStdString();
        entity.nineHangingPoint_ = object["nineHangingPoint"].toString().toStdString();
        entity.nineLocation_ = object["nineLocation"].toString().toStdString();
        entity.nineAmmoName_ = object["nineAmmoName"].toString().toStdString();
        entity.tenHangingPoint_ = object["tenHangingPoint"].toString().toStdString();
        entity.tenLocation_ = object["tenLocation"].toString().toStdString();
        entity.tenAmmoName_ = object["tenAmmoName"].toString().toStdString();
        entity.runningDistance_ = object["runningDistance"].toDouble();
        entity.endurance_ = object["endurance"].toDouble();
        entity.fightRadius_ = object["fightRadius"].toDouble();
        entity.maxFuel_ = object["endurance"].toDouble();
        entity.maxExternalWeight_ = object["maxExternalWeight"].toDouble();
        //entity.recordCreationTime_ = QDateTime::currentDateTime();//object["record_creation_time"].toString().toStdString();//.toInt();
        entity.status_ =  true;//object["use_status"].toBool();

        std::cout <<"entity"<<entity.uavName_<< std::endl;;
        /******************** 系统记录 ********************/
        //entity.uavCreatModelTime_ = recordCreationTime.toTime_t();
        // 使用 QUrl 解析 URL 并提取本地路径
        // QString image_url = object["image_url"].toString();
        // QUrl url(image_url);
        // QString localFilePath = url.toLocalFile();
        // QFile file(localFilePath);

        // qDebug()<<"image_url:"<<object["image_url"].toString();
        // file.open(QIODevice::ReadOnly);
        // QByteArray data = file.readAll();
        // file.close();
        // //std::vector  imagByteA = std::vector<unsigned char>(data.begin(),data.end());
        // entity.imageName_ = std::vector<char>(data.begin(),data.end());
        // std::vector<char> imagByteA(data.begin(), data.end());
        // std::cout << "imagByteA: "<<imagByteA.size()<<"Data size" << entity.imageName_.size() << std::endl;
        // 6. 持久化到数据库
        qDebug() << "Persisting entity...";
        auto id = db.persist(entity);

        // 7. 提交事务
        trans.commit();
        qDebug() <<"当前函数名称:" << __FUNCTION__<<":"<< "Transaction committed, ID:" << id;


    }
    catch (const odb::exception& e) {
        qCritical() << "Database error:" << e.what();
        return false;//throw;
    }
    catch (const std::exception& e) {
        qCritical() << "Error:" << e.what();
        return false;//throw;
    }
    return true;
}
