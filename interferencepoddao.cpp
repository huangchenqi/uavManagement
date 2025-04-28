#include "interferencepoddao.h"
#include "InterferencePodEntity.h"
#include "InterferencePodEntity-odb.hxx"
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
#include <QFile>
#include <QTemporaryFile>
#include <QImage>
InterferencePodDao::InterferencePodDao(QObject* parent) : QObject(parent){
    // 使用 C++11 兼容的写法初始化数据库连接（参数可配置化）
    dbConn_.reset(new DatabaseConnection(
        "uav_type_man",
        "uav_type_man",
        "db_aux_prac_sys",
        "192.168.0.101",
        5432
        ));

}

QJsonArray InterferencePodDao::selectInterferencePodData(const QJsonObject &selectedData)
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
        using query_t = odb::query<InterferencePodEntity>;

        // 3. 从JSON创建实体对象
        InterferencePodEntity entity;

        query_t q(query_t::useStatus == true); // 初始化为无条件query_t::true_expr

        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<InterferencePodEntity>;
//        if (selectedData["ammoType"] == "请选择:"){
//            qDebug()<<"查询全部无人机类型";
//        }else{
//            if (selectedData.contains("ammoType") && selectedData["ammoType"].isString()) {
//                auto ammoType = selectedData["uavType"].toString();
//                q = q && (query_t::ammoType == ammoType.toStdString());
//            }
//        }
        if (selectedData["interferencePodName"] == ""){
            qDebug()<<"查询全部无人机名称";
        }else{
            // 处理 name 字段（使用 == 条件）
            if (selectedData.contains("interferencePodName") && selectedData["interferencePodName"].isString()) {
                QString interferencePodName = selectedData["interferencePodName"].toString();
                if (!interferencePodName.isEmpty()) {
                    q = q && (query_t::interferencePodName == interferencePodName.toStdString());
                }
            }
        }
        odb::result<InterferencePodEntity> result = db.query<InterferencePodEntity>(q);
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

        for (InterferencePodEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "Processing record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["interferencePodName"] = QString::fromStdString(entity.interferencePodName_);
            obj["interferencePodId"] = QString::fromStdString(entity.interferencePodId_);
            obj["interferencePodType"] = QString::fromStdString(entity.interferencePodType_);
            obj["mainCabinSectione"] = QString::number(entity.mainCabinSection_);
            obj["length"] = QString::number(entity.mainLength_);
            obj["frontCoverLength"] = QString::number(entity.frontCoverLength_);
            obj["rearCoverLength"] = QString::number(entity.rearCoverLength_);
            obj["mass"] = QString::number(entity.mass_);
            obj["description"] = QString::fromStdString(entity.description_);

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


            obj["operation"] = "";
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

QJsonObject InterferencePodDao::queryInterferencePodData(const QJsonObject &object)
{
    QJsonObject interferencePodData;
    // 将 JSON 字符串转换为 QJsonObject
    // QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonStr.toUtf8());
    // if (jsonDoc.isObject()) {
    //     object = jsonDoc.object();
    //     qDebug() << "Received JSON object:" << object;

    // } else {
    //     qDebug() << "Invalid JSON format";
    // }

    using query_t = odb::query<InterferencePodEntity>;
    // 1. 建立数据库连接
    qDebug() << "Connecting to database...";

    auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

    // 2. 创建事务
    odb::transaction trans(db.begin());
    qDebug() << "Transaction started";
    try {

        // 3. 从JSON创建实体对象
        InterferencePodEntity entity;

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


        // 执行查询
        // auto r(db.query_one<UavModelEntity>(q));
        // if(r){
        //     auto val{r};
        //     // interferencePodData = val;
        //     nl::json json{*val};
        //     qDebug() << QString::fromStdString(json.dump());
        // }
        // 执行查询
        auto result = db.query_one<InterferencePodEntity>(q);
        if (result) {
            const InterferencePodEntity& entity = *result;

            // 手动转换每个字段到QJsonObject// 基础字段
            interferencePodData["recordId"] = QString::number(entity.id_);
            interferencePodData["interferencePodName"] = QString::fromStdString(entity.interferencePodName_);
            interferencePodData["usedUavModels"] = QString::fromStdString(entity.usedUavModels_);
            interferencePodData["description"] = QString::fromStdString(entity.description_);
            // 处理数值类型（示例）/******************** 尺寸参数 ********************/
            interferencePodData["mass"] = QString::number(entity.mass_); // 假设返回float// 使用 QString::number 方法转换 float
            interferencePodData["mainLength"] = QString::number(entity.mainLength_);
            interferencePodData["firstReconnaissanceRange"] = QString::number(entity.frontCoverLength_);
            interferencePodData["rearCoverLength"] = QString::number(entity.rearCoverLength_);
            interferencePodData["mainCabinSection"] = QString::number(entity.mainCabinSection_);
            interferencePodData["maximumWeightPodFullyLoaded"] = QString::number(entity.maximumWeightPodFullyLoaded_);
            interferencePodData["interferenceBand"] = QString::fromStdString(entity.interferenceBand_);
            interferencePodData["effectiveReflectionArea"] = QString::fromStdString(entity.effectiveReflectionArea_);
            interferencePodData["deliveryControlWay"] = QString::fromStdString(entity.deliveryControlWay_);
            interferencePodData["deliverySpeed"] = QString::fromStdString(entity.deliverySpeed_);
            interferencePodData["loadingCapacity"] = QString::number(entity.loadingCapacity_);
            interferencePodData["interferenceIntensity_"] = QString::fromStdString(entity.interferenceIntensity_);
            // 格式化为字符串（保留5位小数）
            // QString formattedValue = QString::number(entity.uavLength_, 'f', 5);
            // interferencePodData["uavLengthhangingCapacityStr"] = formattedValue;
            //interferencePodData["hardpoint_loc"] = QString::fromStdString(entity.uavHangingLoctionCapacity_);
            // entity.uavHangingpoints_ = interferencePodData["hardpoint_num"].toInt();
            // entity.uavPayloadcapacity_ = interferencePodData["payload_capacity"].toInt();

            interferencePodData["imageUrl"] = QString::fromStdString(entity.imageUrl_);

            /******************** 系统记录 ********************/
            //entity.uavCreatModelTime_ = recordCreationTime.toTime_t();
            //interferencePodData["image_name"] = QString::fromStdString(entity.uavImgName_);

            QByteArray imageData(entity.imageName_.data(), entity.imageName_.size());
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

            interferencePodData["image_url"] = newFilePath;
            // 转换为格式化的JSON字符串
            QJsonDocument doc(interferencePodData);
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
    return interferencePodData;
}

bool InterferencePodDao::updateInterferencePodData(const QJsonObject &selectedData)
{

    try {
        // 1. 建立数据库连接
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        qDebug() << "Connecting to database...";

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction started";
        // 3. 从JSON创建实体对象
        InterferencePodEntity entity;
        // 定义查询条件
        // unique_ptr<entity> john (
        //     db->query_one<entity> (query::first == "John" &&
        //                           query::last == "Doe"));
        // if (john.get () != 0)
        //     db->erase (*john);
        typedef odb::query<InterferencePodEntity> query;
        // 3. 加载要修改的实体
        //std::shared_ptr<Person> person(db->load<Person>(1));  // 加载ID为1的记录
        // 获取要更新的记录ID
        // 从 QJsonObject 中提取 "id" 字段
        QJsonValue idValue = selectedData.value("id");

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
        entity.interferencePodName_ = selectedData["interferencePodName"].toString().toStdString();//.toInt();
        entity.interferencePodType_= "";
        entity.interferencePodId_ = "";
        entity.usedUavModels_ = selectedData["usedUavModels"].toString().toStdString();
        entity.description_ = selectedData["description"].toString().toStdString();//.toInt();
        entity.mainLength_ = selectedData["mainLength"].toDouble();
        entity.mass_ = selectedData["mass"].toDouble();
        entity.frontCoverLength_ = selectedData["frontCoverLength"].toDouble();
        entity.rearCoverLength_ = selectedData["rearCoverLength"].toDouble();
        entity.mainCabinSection_ = selectedData["mainCabinSection"].toDouble();//.toInt();
        entity.maximumWeightPodFullyLoaded_ = selectedData["maximumWeightPodFullyLoaded"].toDouble();
        entity.interferenceBand_ = selectedData["interferenceBand"].toBool();
        entity.effectiveReflectionArea_ = selectedData["effectiveReflectionArea"].toDouble();
        entity.deliveryControlWay_ = selectedData["deliveryControlWay"].toDouble();
        entity.deliverySpeed_ = selectedData["deliverySpeed"].toDouble();//.toInt();
        entity.loadingCapacity_ = selectedData["loadingCapacity"].toDouble();
        entity.interferenceIntensity_ = selectedData["interferenceIntensity"].toDouble();
        //entity.imageName_ = selectedData["imageName"].toDouble();



        entity.imageUrl_ = selectedData["imageUrl"].toString().toStdString();
        entity.recordCreationTime_ = QDateTime::currentDateTime();//selectedData["record_creation_time"].toString().toStdString();//.toInt();
        entity.useStatus_ =  true;//selectedData["use_status"].toBool();
        /******************** 系统记录 ********************/
        //entity.uavCreatModelTime_ = recordCreationTime.toTime_t();
        // 使用 QUrl 解析 URL 并提取本地路径
        QString image_url = selectedData["image_url"].toString();
        QUrl url(image_url);
        QString localFilePath = url.toLocalFile();
        QFile file(localFilePath);

        qDebug()<<"image_url:"<<selectedData["image_url"].toString();
        file.open(QIODevice::ReadOnly);
        QByteArray data = file.readAll();
        file.close();
        //std::vector  imagByteA = std::vector<unsigned char>(data.begin(),data.end());
        entity.imageName_ = std::vector<char>(data.begin(),data.end());
        std::vector<char> imagByteA(data.begin(), data.end());
        std::cout << "imagByteA: "<<imagByteA.size()<<"Data size" << entity.imageName_.size() << std::endl;
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

bool InterferencePodDao::deleteInterferencePodData(const QJSValue &selectedData)
{
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction delete deleteInterferencePodData started";
        // 3. 从JSON创建实体对象
        InterferencePodEntity entity;
        //typedef odb::query<InterferencePodEntity> query;
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
            entity.useStatus_ = ammoStatusStr;
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

bool InterferencePodDao::insertInterferencePodData(const QJsonObject &object)
{
    qDebug() << "Starting database insertUavMountLocationDate insertion...";
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction insert Ammo started";

        // 3. 从JSON创建实体对象
        InterferencePodEntity entity;
        QDateTime recordCreationTime;//创建记录时间

        // 4. 映射JSON字段到实体属性
        // 基础字段
        //#pragma db not_null column("ammo_name")//            VARCHAR(100) NOT NULL ,--COMMENT '名称',


        entity.interferencePodName_ = object["interferencePodName"].toString().toStdString();//.toInt();
        entity.interferencePodType_= "";
        entity.interferencePodId_ = "";
        entity.usedUavModels_ = object["usedUavModels"].toString().toStdString();
        entity.description_ = object["description"].toString().toStdString();//.toInt();
        entity.mainLength_ = object["mainLength"].toDouble();
        entity.mass_ = object["mass"].toDouble();
        entity.frontCoverLength_ = object["frontCoverLength"].toDouble();
        entity.rearCoverLength_ = object["rearCoverLength"].toDouble();
        entity.mainCabinSection_ = object["mainCabinSection"].toDouble();//.toInt();
        entity.maximumWeightPodFullyLoaded_ = object["maximumWeightPodFullyLoaded"].toDouble();
        entity.interferenceBand_ = object["interferenceBand"].toBool();
        entity.effectiveReflectionArea_ = object["effectiveReflectionArea"].toDouble();
        entity.deliveryControlWay_ = object["deliveryControlWay"].toDouble();
        entity.deliverySpeed_ = object["deliverySpeed"].toDouble();//.toInt();
        entity.loadingCapacity_ = object["loadingCapacity"].toDouble();
        entity.interferenceIntensity_ = object["interferenceIntensity"].toDouble();
        //entity.imageName_ = object["imageName"].toDouble();



        entity.imageUrl_ = object["imageUrl"].toString().toStdString();
        entity.recordCreationTime_ = QDateTime::currentDateTime();//object["record_creation_time"].toString().toStdString();//.toInt();
        entity.useStatus_ =  true;//object["use_status"].toBool();
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
        entity.imageName_ = std::vector<char>(data.begin(),data.end());
        std::vector<char> imagByteA(data.begin(), data.end());
        std::cout << "imagByteA: "<<imagByteA.size()<<"Data size" << entity.imageName_.size() << std::endl;
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
