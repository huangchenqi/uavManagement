#include "reconnaissanceCommunicationdao.h"
#include "ReconnaissanceCommunicationEntity.h"
#include "ReconnaissanceCommunicationEntity-odb.hxx"
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
#include <QImage>
#include <QTemporaryFile>
#include <QUrl>
struct order{
    template<typename T>
    static odb::query<T> by(::std::string column, ::std::string p = "DESC"){
        return odb::query<T>{"order by "} + column + p;
    }
};
ReconnaissanceCommunicationDao::ReconnaissanceCommunicationDao(QObject* parent) : QObject(parent){
    // 使用 C++11 兼容的写法初始化数据库连接（参数可配置化）
    dbConn_.reset(new DatabaseConnection(
        "uav_type_man",
        "uav_type_man",
        "db_aux_prac_sys",
        "192.168.0.101",
        5432
        ));

}

QJsonArray ReconnaissanceCommunicationDao::selectReconnaissanceCommunicationData(const QJsonObject &object)
{
    QJsonArray ammoModelData;
    // QJsonDocument adoc(selectedData);
    // qDebug()<<"当前xASRA wae  q函数名称:" << __FUNCTION__<<":";
    // qDebug().noquote() << adoc.toJson(QJsonDocument::Indented);

    try{
        // 1. 建立数据库连接
        qDebug() << "Connecting to selectAmmoAllData database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction select all started";
        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<ReconnaissanceCommunicationEntity>;

        // 3. 从JSON创建实体对象
        ReconnaissanceCommunicationEntity entity;

        query_t q(query_t::useStatus == true); // 初始化为无条件query_t::true_expr

        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<ReconnaissanceCommunicationEntity>;
        //        if (selectedData["ammoType"] == "请选择:"){
        //            qDebug()<<"查询全部无人机类型";
        //        }else{
        //            if (selectedData.contains("ammoType") && selectedData["ammoType"].isString()) {
        //                auto ammoType = selectedData["uavType"].toString();
        //                q = q && (query_t::ammoType == ammoType.toStdString());
        //            }
        //        }
        if (object["reconnaissanceName"] == ""){
            qDebug()<<"查询全部无人机名称";
        }else{
            // 处理 name 字段（使用 == 条件）
            if (object.contains("reconnaissanceName") && object["reconnaissanceName"].isString()) {
                QString reconnaissanceName = object["interferencePodName"].toString();
                if (!reconnaissanceName.isEmpty()) {
                    q = q && (query_t::reconnaissanceName == reconnaissanceName.toStdString());
                }
            }
        }
        odb::result<ReconnaissanceCommunicationEntity> result = db.query<ReconnaissanceCommunicationEntity>(q+ order::by<ReconnaissanceCommunicationEntity>(query_t::recordCreationTime.column()));
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

        for (ReconnaissanceCommunicationEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "Processing record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["reconnaissanceName"] = QString::fromStdString(entity.reconnaissanceName_);
            obj["usedUavModels"] = QString::fromStdString(entity.usedUavModels_);
            obj["description"] = QString::fromStdString(entity.description_);
            if(!entity.frequencyMinimum_){
                obj["frequencyMinimum"] = "";
            }else{
               obj["frequencyMinimum"] = QString::number(entity.frequencyMinimum_.get());
            }
            if(!entity.frequencyMaximum_){
                obj["frequencyMaximum"] = "";
            }else{
              obj["frequencyMaximum"] = QString::number(entity.frequencyMaximum_.get());
            }

            // obj["frontCoverLength"] = QString::number(entity.frontCoverLength_);
            // obj["rearCoverLength"] = QString::number(entity.rearCoverLength_);
            //obj["mass"] = QString::number(entity.mass_);
            obj["imageUrl"] = QString::fromStdString(entity.imageUrl_);

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
            // 原始日期时间字符串
            QString originalDateTime = entity.recordCreationTime_.toString(Qt::ISODate);

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
            obj["recordcreationTime"] = formattedDateTime;


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
    qDebug()<<"当前函数名称aaaaa:" << __FUNCTION__<<":";
    qDebug().noquote() << doc.toJson(QJsonDocument::Indented);
    return ammoModelData;
}

QJsonObject ReconnaissanceCommunicationDao::queryReconnaissanceCommunicationData(const QJsonObject &object)
{

    QJsonObject reconnaissanceCommunicationData;
    // 将 JSON 字符串转换为 QJsonObject
    // QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonStr.toUtf8());
    // if (jsonDoc.isObject()) {
    //     object = jsonDoc.object();
    //     qDebug() << "Received JSON object:" << object;

    // } else {
    //     qDebug() << "Invalid JSON format";
    // }

    using query_t = odb::query<ReconnaissanceCommunicationEntity>;
    // 1. 建立数据库连接
    qDebug() << "Connecting to database...";

    auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

    // 2. 创建事务
    odb::transaction trans(db.begin());
    qDebug() << "Transaction started";
    try {

        // 3. 从JSON创建实体对象
        ReconnaissanceCommunicationEntity entity;

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
        //     // reconnaissanceCommunicationData = val;
        //     nl::json json{*val};
        //     qDebug() << QString::fromStdString(json.dump());
        // }
        // 执行查询
        auto result = db.query_one<ReconnaissanceCommunicationEntity>(q);
        if (result) {
            const ReconnaissanceCommunicationEntity& entity = *result;

            // 手动转换每个字段到QJsonObject// 基础字段
            reconnaissanceCommunicationData["recordId"] = QString::number(entity.id_);
            reconnaissanceCommunicationData["reconnaissanceName"] = QString::fromStdString(entity.reconnaissanceName_);
            reconnaissanceCommunicationData["usedUavModels"] = QString::fromStdString(entity.usedUavModels_);
            reconnaissanceCommunicationData["description"] = QString::fromStdString(entity.description_);
            // 处理数值类型（示例）/******************** 尺寸参数 ********************/
            if(!entity.frequencyMinimum_){
                reconnaissanceCommunicationData["frequencyMinimum"] = "";
            }else{
             reconnaissanceCommunicationData["frequencyMinimum"] = QString::number(entity.frequencyMinimum_.get()); // 假设返回float// 使用 QString::number 方法转换 float
            }
            if(!entity.frequencyMaximum_){
                reconnaissanceCommunicationData["frequencyMaximum"] = "";
            }else{
                reconnaissanceCommunicationData["frequencyMaximum"] = QString::number(entity.frequencyMaximum_.get());
            }
            if(!entity.firstReconnaissanceRange_){
                reconnaissanceCommunicationData["firstReconnaissanceRange"] = "";
            }else{
              reconnaissanceCommunicationData["firstReconnaissanceRange"] = QString::number(entity.firstReconnaissanceRange_.get());
            }
            if(!entity.firstReconnaissanceFrequencyMinimum_){
                reconnaissanceCommunicationData["firstReconnaissanceFrequencyMinimum"] = "";
            }else{
              reconnaissanceCommunicationData["firstReconnaissanceFrequencyMinimum"] = QString::number(entity.firstReconnaissanceFrequencyMinimum_.get());
            }
            if(!entity.firstReconnaissanceFrequencyMaximum_){
                reconnaissanceCommunicationData["firstReconnaissanceFrequencyMaximum"] = "";
            }else{
               reconnaissanceCommunicationData["firstReconnaissanceFrequencyMaximum"] = QString::number(entity.firstReconnaissanceFrequencyMaximum_.get()) ;
            }
            if(!entity.firstReconnaissanceRadiatedPower_){
                reconnaissanceCommunicationData["firstReconnaissanceRadiatedPower"] = "";
            }else{
                reconnaissanceCommunicationData["firstReconnaissanceRadiatedPower"] = QString::number(entity.firstReconnaissanceRadiatedPower_.get());
            }
            if(!entity.secondReconnaissanceRange_){
                reconnaissanceCommunicationData["secondReconnaissanceRange"] = "";
            }else{
               reconnaissanceCommunicationData["secondReconnaissanceRange"] = QString::number(entity.secondReconnaissanceRange_.get());
            }
            if(!entity.secondReconnaissanceFrequencyMinimum_){
                reconnaissanceCommunicationData["secondReconnaissanceFrequencyMinimum"] = "";
            }else{
              reconnaissanceCommunicationData["secondReconnaissanceFrequencyMinimum"] = QString::number(entity.secondReconnaissanceFrequencyMinimum_.get());
            }
            if(!entity.secondReconnaissanceFrequencyMaximum_){
                reconnaissanceCommunicationData["secondReconnaissanceFrequencyMaximum"] = "";
            }else{
                reconnaissanceCommunicationData["secondReconnaissanceFrequencyMaximum"] = QString::number(entity.secondReconnaissanceFrequencyMaximum_.get());
            }
            if(!entity.secondReconnaissanceRadiatedPower_){
                reconnaissanceCommunicationData["secondReconnaissanceRadiatedPower"] = "";
            }else{
                reconnaissanceCommunicationData["secondReconnaissanceRadiatedPower"] = QString::number(entity.secondReconnaissanceRadiatedPower_.get());
            }
            if(!entity.thirdReconnaissanceRange_){
                reconnaissanceCommunicationData["thirdReconnaissanceRange"] = "";
            }else{
                reconnaissanceCommunicationData["thirdReconnaissanceRange"] = QString::number(entity.thirdReconnaissanceRange_.get());
            }
            if(!entity.thirdReconnaissanceFrequencyMinimum_){
                reconnaissanceCommunicationData["thirdReconnaissanceFrequencyMinimum"] = "";
            }else{
                reconnaissanceCommunicationData["thirdReconnaissanceFrequencyMinimum"] = QString::number(entity.thirdReconnaissanceFrequencyMinimum_.get());
            }
            if(!entity.thirdReconnaissanceFrequencyMaximum_){
                reconnaissanceCommunicationData["thirdReconnaissanceFrequencyMaximum"] = "";
            }else{
                reconnaissanceCommunicationData["thirdReconnaissanceFrequencyMaximum"] = QString::number(entity.thirdReconnaissanceFrequencyMaximum_.get());
            }
            if(!entity.thirdReconnaissanceRadiatedPower_){
                reconnaissanceCommunicationData["thirdReconnaissanceRadiatedPower"] = "";
            }else{
                reconnaissanceCommunicationData["thirdReconnaissanceRadiatedPower"] = QString::number(entity.thirdReconnaissanceRadiatedPower_.get());
            }
            if(!entity.fourthReconnaissanceRange_){
                reconnaissanceCommunicationData["fourthReconnaissanceRange"] = "";
            }else{
                reconnaissanceCommunicationData["fourthReconnaissanceRange"] = QString::number(entity.fourthReconnaissanceRange_.get());
            }
            if(!entity.fourthReconnaissanceFrequencyMinimum_){
                reconnaissanceCommunicationData["fourthReconnaissanceFrequencyMinimum"] = "";
            }else{
                reconnaissanceCommunicationData["fourthReconnaissanceFrequencyMinimum"] = QString::number(entity.fourthReconnaissanceFrequencyMinimum_.get());
            }
            if(!entity.fourthReconnaissanceFrequencyMaximum_){
                reconnaissanceCommunicationData["fourthReconnaissanceFrequencyMaximum"] = "";
            }else{
                reconnaissanceCommunicationData["fourthReconnaissanceFrequencyMaximum"] = QString::number(entity.fourthReconnaissanceFrequencyMaximum_.get());
            }
            if(!entity.fourthReconnaissanceRadiatedPower_){
                reconnaissanceCommunicationData["fourthReconnaissanceRadiatedPower"] = "";
            }else{
                reconnaissanceCommunicationData["fourthReconnaissanceRadiatedPower"] = QString::number(entity.fourthReconnaissanceRadiatedPower_.get());
            }
            if(!entity.firstOrientationAccuracy_){
                reconnaissanceCommunicationData["firstOrientationAccuracy"] = "";
            }else{
                reconnaissanceCommunicationData["firstOrientationAccuracy"] = QString::number(entity.firstOrientationAccuracy_.get());
            }
            if(!entity.firstOrientationFrequencyMinimum_){
                reconnaissanceCommunicationData["firstOrientationFrequencyMinimum"] = "";
            }else{
                reconnaissanceCommunicationData["firstOrientationFrequencyMinimum"] = QString::number(entity.firstOrientationFrequencyMinimum_.get());
            }
            if(!entity.firstOrientationFrequencyMaximum_){
                reconnaissanceCommunicationData["firstOrientationFrequencyMaximum"] = "";
            }else{
                reconnaissanceCommunicationData["firstOrientationFrequencyMaximum"] = QString::number(entity.firstOrientationFrequencyMaximum_.get());
            }
            if(!entity.secondOrientationAccuracy_){
                reconnaissanceCommunicationData["secondOrientationAccuracy"] = "";
            }else{
                reconnaissanceCommunicationData["secondOrientationAccuracy"] = QString::number(entity.secondOrientationAccuracy_.get());
            }
            if(!entity.secondOrientationFrequencyMinimum_){
                reconnaissanceCommunicationData["secondOrientationFrequencyMinimum"] = "";
            }else{
                reconnaissanceCommunicationData["secondOrientationFrequencyMinimum"] = QString::number(entity.secondOrientationFrequencyMinimum_.get());
            }
            if(!entity.secondOrientationFrequencyMaximum_){
                reconnaissanceCommunicationData["secondOrientationFrequencyMaximum"] ="";
            }else{
                reconnaissanceCommunicationData["secondOrientationFrequencyMaximum"] = QString::number(entity.secondOrientationFrequencyMaximum_.get());
            }

            if(!entity.thirdOrientationAccuracy_){
                reconnaissanceCommunicationData["thirdOrientationAccuracy"] = "";
            }else{
                reconnaissanceCommunicationData["thirdOrientationAccuracy"] = QString::number(entity.thirdOrientationAccuracy_.get());
            }
            if(!entity.thirdOrientationFrequencyMinimum_){
                reconnaissanceCommunicationData["thirdOrientationFrequencyMinimum"] = "";
            }else{
                reconnaissanceCommunicationData["thirdOrientationFrequencyMinimum"] = QString::number(entity.thirdOrientationFrequencyMinimum_.get());
            }
            if(!entity.thirdOrientationFrequencyMaximum_){
                reconnaissanceCommunicationData["thirdOrientationFrequencyMaximum"] = "";
            }else{
                reconnaissanceCommunicationData["thirdOrientationFrequencyMaximum"] = QString::number(entity.thirdOrientationFrequencyMaximum_.get());
            }
            if(!entity.fourthOrientationAccuracy_){
                reconnaissanceCommunicationData["fourthOrientationAccuracy"] = "";
            }else{
                reconnaissanceCommunicationData["fourthOrientationAccuracy"] = QString::number(entity.fourthOrientationAccuracy_.get());
            }
            if(!entity.fourthOrientationFrequencyMinimum_){
                reconnaissanceCommunicationData["fourthOrientationFrequencyMinimum"] = "";
            }else{
                reconnaissanceCommunicationData["fourthOrientationFrequencyMinimum"] = QString::number(entity.fourthOrientationFrequencyMinimum_.get());
            }
            if(!entity.fourthOrientationFrequencyMaximum_){
                reconnaissanceCommunicationData["fourthOrientationFrequencyMaximum"] = "";
            }else{
                reconnaissanceCommunicationData["fourthOrientationFrequencyMaximum"] = QString::number(entity.fourthOrientationFrequencyMaximum_.get());
            }
            if(!entity.firstPositioningAccuracy_){
                reconnaissanceCommunicationData["firstPositioningAccuracy"] = "";
            }else{
                reconnaissanceCommunicationData["firstPositioningAccuracy"] = QString::number(entity.firstPositioningAccuracy_.get());
            }
            if(!entity.firstPositioningFrequencyMinimum_){
                reconnaissanceCommunicationData["firstPositioningFrequencyMinimum"] = "";
            }else{
                reconnaissanceCommunicationData["firstPositioningFrequencyMinimum"] = QString::number(entity.firstPositioningFrequencyMinimum_.get());
            }
            if(!entity.firstPositioningFrequencyMaximum_){
                reconnaissanceCommunicationData["firstPositioningFrequencyMaximum"] = "";
            }else{
                reconnaissanceCommunicationData["firstPositioningFrequencyMaximum"] = QString::number(entity.firstPositioningFrequencyMaximum_.get());
            }
            if(!entity.secondPositioningAccuracy_){
                reconnaissanceCommunicationData["secondPositioningAccuracy"] = "";
            }else{
                reconnaissanceCommunicationData["secondPositioningAccuracy"] = QString::number(entity.secondPositioningAccuracy_.get());
            }
            if(!entity.secondPositioningFrequencyMinimum_){
                reconnaissanceCommunicationData["secondPositioningFrequencyMinimum"] = "";
            }else{
                reconnaissanceCommunicationData["secondPositioningFrequencyMinimum"] = QString::number(entity.secondPositioningFrequencyMinimum_.get());
            }
            if(!entity.secondPositioningFrequencyMaximum_){
                reconnaissanceCommunicationData["secondPositioningFrequencyMaximum"] = "";
            }else{
                reconnaissanceCommunicationData["secondPositioningFrequencyMaximum"] = QString::number(entity.secondPositioningFrequencyMaximum_.get());
            }
            if(!entity.thirdPositioningAccuracy_){
                reconnaissanceCommunicationData["thirdPositioningAccuracy"] = "";
            }else{
                reconnaissanceCommunicationData["thirdPositioningAccuracy"] = QString::number(entity.thirdPositioningAccuracy_.get());
            }
            if(!entity.thirdPositioningFrequencyMinimum_){
                reconnaissanceCommunicationData["thirdPositioningFrequencyMinimum"] = "";
            }else{
                reconnaissanceCommunicationData["thirdPositioningFrequencyMinimum"] = QString::number(entity.thirdPositioningFrequencyMinimum_.get());
            }
            if(!entity.thirdPositioningFrequencyMaximum_){
                reconnaissanceCommunicationData["thirdPositioningFrequencyMaximum"] = "";
            }else{
                reconnaissanceCommunicationData["thirdPositioningFrequencyMaximum"] = QString::number(entity.thirdPositioningFrequencyMaximum_.get());
            }

            if(!entity.fourthPositioningAccuracy_){
                reconnaissanceCommunicationData["fourthPositioningAccuracy"] = "";
            }else{
                reconnaissanceCommunicationData["fourthPositioningAccuracy"] = QString::number(entity.fourthPositioningAccuracy_.get());
            }
            if(!entity.fourthPositioningFrequencyMinimum_){
                reconnaissanceCommunicationData["fourthPositioningFrequencyMinimum"] = "";
            }else{
              reconnaissanceCommunicationData["fourthPositioningFrequencyMinimum"] = QString::number(entity.fourthPositioningFrequencyMinimum_.get());
            }
            if(!entity.fourthPositioningFrequencyMaximum_){
                reconnaissanceCommunicationData["fourthPositioningFrequencyMaximum"] = "";
            }else{
               reconnaissanceCommunicationData["fourthPositioningFrequencyMaximum"] = QString::number(entity.fourthPositioningFrequencyMaximum_.get());
            }
            // 格式化为字符串（保留5位小数）
            // QString formattedValue = QString::number(entity.uavLength_, 'f', 5);
            // reconnaissanceCommunicationData["uavLengthhangingCapacityStr"] = formattedValue;
            //reconnaissanceCommunicationData["hardpoint_loc"] = QString::fromStdString(entity.uavHangingLoctionCapacity_);
            // entity.uavHangingpoints_ = reconnaissanceCommunicationData["hardpoint_num"].toInt();
            // entity.uavPayloadcapacity_ = reconnaissanceCommunicationData["payload_capacity"].toInt();

            //reconnaissanceCommunicationData["imageUrl"] = QString::fromStdString(entity.imageUrl_);

            /******************** 系统记录 ********************/
            //entity.uavCreatModelTime_ = recordCreationTime.toTime_t();
            //reconnaissanceCommunicationData["image_name"] = QString::fromStdString(entity.uavImgName_);

            // QByteArray imageData(entity.imageName_.data(), entity.imageName_.size());
            // //建立临时文件名

            // QString tempFileName = "Uav" + QDateTime::currentDateTime().toString("yyyyMMddHHmmss") + "Image";
            // // 创建一个临时文件
            // QTemporaryFile tempFile(tempFileName);
            // //tempFile.setAutoRemove(false); // 禁用自动删除
            // if (!tempFile.open()) {
            //     qDebug() << "Failed to create temporary file:" << tempFile.errorString();
            //     //return QString();
            // }

            // // 写入图片数据
            // tempFile.write(imageData);
            // tempFile.close();

            // // 返回临时文件的路径
            // QUrl imageUrl;
            // QString tempFilePath =tempFile.fileName();
            // if (!tempFilePath.isEmpty()) {
            //     imageUrl = QUrl::fromLocalFile(tempFilePath);
            // }

            // QString filePath = imageUrl.toString();
            // // 去掉文件路径中的 "file:///"
            // filePath = filePath.mid(8);

            // // 检查文件是否存在
            // QFile file(filePath);
            // if (!file.exists()) {
            //     qDebug()<< "错误, 文件不存在！";

            // }

            // // 加载图片
            // QImage image(filePath);
            // //                if (image.isNull()) {
            // //                    qDebug()<<"错误, 无法加载图片！";
            // //                    return -1;
            // //                }
            // QString fileType = ".png";

            // // 修改文件扩展名
            // QString newFilePath = filePath.section('.', 0, -2) + fileType;

            // // 保存为PNG格式
            // if (!image.save(newFilePath, "PNG")) {
            //     qDebug()<<"错误, 保存失败！";
            // }
            // qDebug()<<"QTemporaryFile"<<newFilePath;

            // reconnaissanceCommunicationData["image_url"] = newFilePath;
            // 转换为格式化的JSON字符串
            QJsonDocument doc(reconnaissanceCommunicationData);
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
    return reconnaissanceCommunicationData;

}

bool ReconnaissanceCommunicationDao::updateReconnaissanceCommunicationData(const QJsonObject &object)
{
    try {
        // 1. 建立数据库连接
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        qDebug() << "Connecting to database...";

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction started";
        // 3. 从JSON创建实体对象
        ReconnaissanceCommunicationEntity entity;
        // 定义查询条件
        // unique_ptr<entity> john (
        //     db->query_one<entity> (query::first == "John" &&
        //                           query::last == "Doe"));
        // if (john.get () != 0)
        //     db->erase (*john);
        typedef odb::query<ReconnaissanceCommunicationEntity> query;
        // 3. 加载要修改的实体
        //std::shared_ptr<Person> person(db->load<Person>(1));  // 加载ID为1的记录
        // 获取要更新的记录ID
        // 从 QJsonObject 中提取 "id" 字段
        QJsonValue idValue = object.value("id");

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
        entity.reconnaissanceName_ =  object["reconnaissanceName"].toString().toStdString();;
        entity.usedUavModels_ = object["usedUavModels"].toString().toStdString();;
        entity.description_ =  object["description"].toString().toStdString();
        // 处理数值类型（示例）/******************** 尺寸参数 ********************/
        // entity.frequencyMinimum_ = object["frequencyMinimum"].toDouble(); // 假设返回float// 使用 QString::number 方法转换 float
        // entity.frequencyMaximum_ = object["frequencyMaximum"].toDouble();
        // entity.firstReconnaissanceRange_ = object["firstReconnaissanceRange"].toDouble();
        // entity.firstReconnaissanceFrequencyMinimum_ = object["firstReconnaissanceFrequencyMinimum"].toDouble();
        // entity.firstReconnaissanceFrequencyMaximum_ = object["firstReconnaissanceFrequencyMaximum"].toDouble();
        // entity.firstReconnaissanceRadiatedPower_ = object["firstReconnaissanceRadiatedPower"].toDouble();
        // entity.secondReconnaissanceRange_ = object["secondReconnaissanceRange"].toDouble();
        // entity.secondReconnaissanceFrequencyMinimum_ = object["secondReconnaissanceFrequencyMinimum"].toDouble();
        // entity.secondReconnaissanceFrequencyMaximum_ = object["secondReconnaissanceFrequencyMaximum"].toDouble();
        // entity.secondReconnaissanceRadiatedPower_ = object["secondReconnaissanceRadiatedPower"].toDouble();
        // entity.thirdReconnaissanceRange_ = object["thirdReconnaissanceRange"].toDouble();
        // entity.thirdReconnaissanceFrequencyMinimum_ = object["thirdReconnaissanceFrequencyMinimum"].toDouble();
        // entity.thirdReconnaissanceFrequencyMaximum_ = object["thirdReconnaissanceFrequencyMaximum"].toDouble();
        // entity.thirdReconnaissanceRadiatedPower_ = object["thirdReconnaissanceRadiatedPower"].toDouble();
        // entity.fourthReconnaissanceRange_ = object["fourthReconnaissanceRange"].toDouble();
        // entity.fourthReconnaissanceFrequencyMinimum_ = object["fourthReconnaissanceFrequencyMinimum"].toDouble();
        // entity.fourthReconnaissanceFrequencyMaximum_ = object["fourthReconnaissanceFrequencyMaximum"].toDouble();
        // entity.fourthReconnaissanceRadiatedPower_ = object["fourthReconnaissanceRadiatedPower"].toDouble();
        // entity.firstOrientationAccuracy_ = object["firstOrientationAccuracy"].toDouble();
        // entity.firstOrientationFrequencyMinimum_ = object["firstOrientationFrequencyMinimum"].toDouble();
        // entity.firstOrientationFrequencyMaximum_ = object["firstOrientationFrequencyMaximum"].toDouble();
        // entity.secondOrientationAccuracy_ = object["secondOrientationAccuracy"].toDouble();
        // entity.secondOrientationFrequencyMinimum_ = object["secondOrientationFrequencyMinimum"].toDouble();
        // entity.secondOrientationFrequencyMaximum_ = object["secondOrientationFrequencyMaximum"].toDouble();
        // entity.thirdOrientationAccuracy_ = object["thirdOrientationAccuracy"].toDouble();
        // entity.thirdOrientationFrequencyMinimum_ = object["thirdOrientationFrequencyMinimum"].toDouble();
        // entity.thirdOrientationFrequencyMaximum_ = object["thirdOrientationFrequencyMaximum"].toDouble();
        // entity.fourthOrientationAccuracy_ = object["fourthOrientationAccuracy"].toDouble();
        // entity.fourthOrientationFrequencyMinimum_ = object["fourthOrientationFrequencyMinimum"].toDouble();
        // entity.fourthOrientationFrequencyMaximum_ = object["fourthOrientationFrequencyMaximum"].toDouble();
        // entity.firstPositioningAccuracy_ = object["firstPositioningAccuracy"].toDouble();
        // entity.firstPositioningFrequencyMinimum_ = object["firstPositioningFrequencyMinimum"].toDouble();
        // entity.firstPositioningFrequencyMaximum_ = object["firstPositioningFrequencyMaximum"].toDouble();
        // entity.secondPositioningAccuracy_ = object["secondPositioningAccuracy"].toDouble();
        // entity.secondPositioningFrequencyMinimum_ = object["secondPositioningFrequencyMinimum"].toDouble();
        // entity.secondPositioningFrequencyMaximum_ = object["secondPositioningFrequencyMaximum"].toDouble();
        // entity.thirdPositioningAccuracy_ = object["thirdPositioningAccuracy"].toDouble();
        // entity.thirdPositioningFrequencyMinimum_ = object["thirdPositioningFrequencyMinimum"].toDouble();
        // entity.thirdPositioningFrequencyMaximum_ = object["thirdPositioningFrequencyMaximum"].toDouble();
        // entity.fourthPositioningAccuracy_ = object["fourthPositioningAccuracy"].toDouble();
        // entity.fourthPositioningFrequencyMinimum_ = object["fourthPositioningFrequencyMinimum"].toDouble();
        // entity.fourthPositioningFrequencyMaximum_ = object["fourthPositioningFrequencyMaximum"].toDouble();
        if(object["frequencyMinimum"].isNull()){

        }else{
            entity.frequencyMinimum_ = object["frequencyMinimum"].toDouble(); // 假设返回float// 使用 QString::number 方法转换 float
        }
        if(object["frequencyMaximum"].isNull()){

        }else{
            entity.frequencyMaximum_ = object["frequencyMaximum"].toDouble();
        }
        if(object["firstReconnaissanceRange"].isNull()){

        }else{
            entity.firstReconnaissanceRange_ = object["firstReconnaissanceRange"].toDouble();
        }
        if(object["firstReconnaissanceFrequencyMinimum"].isNull()){

        }else{
            entity.firstReconnaissanceFrequencyMinimum_ = object["firstReconnaissanceFrequencyMinimum"].toDouble();
        }
        if(object["firstReconnaissanceFrequencyMaximum"].isNull()){

        }else{
            entity.firstReconnaissanceFrequencyMaximum_ = object["firstReconnaissanceFrequencyMaximum"].toDouble();
        }
        if(object["firstReconnaissanceRadiatedPower"].isNull()){

        }else{
            entity.firstReconnaissanceRadiatedPower_ = object["firstReconnaissanceRadiatedPower"].toDouble();
        }
        if(object["secondReconnaissanceRange"].isNull()){

        }else{
            entity.secondReconnaissanceRange_ = object["secondReconnaissanceRange"].toDouble();
        }
        if(object["secondReconnaissanceFrequencyMinimum"].isNull()){

        }else{
            entity.secondReconnaissanceFrequencyMinimum_ = object["secondReconnaissanceFrequencyMinimum"].toDouble();
        }
        if(object["secondReconnaissanceFrequencyMaximum"].isNull()){

        }else{
            entity.secondReconnaissanceFrequencyMaximum_ = object["secondReconnaissanceFrequencyMaximum"].toDouble();
        }
        if(object["secondReconnaissanceRadiatedPower"].isNull()){

        }else{
            entity.secondReconnaissanceRadiatedPower_ = object["secondReconnaissanceRadiatedPower"].toDouble();
        }
        if(object["thirdReconnaissanceRange"].isNull()){

        }else{
            entity.thirdReconnaissanceRange_ = object["thirdReconnaissanceRange"].toDouble();
        }
        if(object["thirdReconnaissanceFrequencyMinimum"].isNull()){

        }else{
            entity.thirdReconnaissanceFrequencyMinimum_ = object["thirdReconnaissanceFrequencyMinimum"].toDouble();
        }
        if(object["thirdReconnaissanceFrequencyMaximum"].isNull()){

        }else{
            entity.thirdReconnaissanceFrequencyMaximum_ = object["thirdReconnaissanceFrequencyMaximum"].toDouble();
        }

        if(object["thirdReconnaissanceRadiatedPower"].isNull()){

        }else{
            entity.thirdReconnaissanceRadiatedPower_ = object["thirdReconnaissanceRadiatedPower"].toDouble();
        }
        if(object["fourthReconnaissanceRange"].isNull()){

        }else{
            entity.fourthReconnaissanceRange_ = object["fourthReconnaissanceRange"].toDouble();
        }
        if(object["fourthReconnaissanceFrequencyMinimum"].isNull()){

        }else{
            entity.fourthReconnaissanceFrequencyMinimum_ = object["fourthReconnaissanceFrequencyMinimum"].toDouble();
        }
        if(object["fourthReconnaissanceFrequencyMaximum"].isNull()){

        }else{
            entity.fourthReconnaissanceFrequencyMaximum_ = object["fourthReconnaissanceFrequencyMaximum"].toDouble();
        }
        if(object["fourthReconnaissanceRadiatedPower"].isNull()){

        }else{
            entity.fourthReconnaissanceRadiatedPower_ = object["fourthReconnaissanceRadiatedPower"].toDouble();
        }
        if(object["firstOrientationAccuracy"].isNull()){

        }else{
            entity.firstOrientationAccuracy_ = object["firstOrientationAccuracy"].toDouble();
        }
        if(object["firstOrientationFrequencyMinimum"].isNull()){

        }else{
            entity.firstOrientationFrequencyMinimum_ = object["firstOrientationFrequencyMinimum"].toDouble();
        }
        if(object["firstOrientationFrequencyMaximum"].isNull()){

        }else{
            entity.firstOrientationFrequencyMaximum_ = object["firstOrientationFrequencyMaximum"].toDouble();
        }

        if(object["secondOrientationAccuracy"].isNull()){

        }else{
            entity.secondOrientationAccuracy_ = object["secondOrientationAccuracy"].toDouble();
        }
        if(object["secondOrientationFrequencyMinimum"].isNull()){

        }else{
            entity.secondOrientationFrequencyMinimum_ = object["secondOrientationFrequencyMinimum"].toDouble();
        }
        if(object["secondOrientationFrequencyMaximum"].isNull()){

        }else{
            entity.secondOrientationFrequencyMaximum_ = object["secondOrientationFrequencyMaximum"].toDouble();
        }
        if(object["thirdOrientationAccuracy"].isNull()){

        }else{
            entity.thirdOrientationAccuracy_ = object["thirdOrientationAccuracy"].toDouble();
        }
        if(object["thirdOrientationFrequencyMinimum"].isNull()){

        }else{
            entity.thirdOrientationFrequencyMinimum_ = object["thirdOrientationFrequencyMinimum"].toDouble();
        }
        if(object["thirdOrientationFrequencyMaximum"].isNull()){

        }else{
            entity.thirdOrientationFrequencyMaximum_ = object["thirdOrientationFrequencyMaximum"].toDouble();
        }
        if(object["fourthOrientationAccuracy"].isNull()){

        }else{
            entity.fourthOrientationAccuracy_ = object["fourthOrientationAccuracy"].toDouble();
        }

        if(object["fourthOrientationFrequencyMinimum"].isNull()){

        }else{
            entity.fourthOrientationFrequencyMinimum_ = object["fourthOrientationFrequencyMinimum"].toDouble();
        }
        if(object["fourthOrientationFrequencyMaximum"].isNull()){

        }else{
            entity.fourthOrientationFrequencyMaximum_ = object["fourthOrientationFrequencyMaximum"].toDouble();
        }

        if(object["firstPositioningAccuracy"].isNull()){

        }else{
            entity.firstPositioningAccuracy_ = object["firstPositioningAccuracy"].toDouble();
        }
        if(object["firstPositioningFrequencyMinimum"].isNull()){

        }else{
            entity.firstPositioningFrequencyMinimum_ = object["firstPositioningFrequencyMinimum"].toDouble();
        }

        if(object["firstPositioningFrequencyMaximum"].isNull()){

        }else{
            entity.firstPositioningFrequencyMaximum_ = object["firstPositioningFrequencyMaximum"].toDouble();
        }
        if(object["secondPositioningAccuracy"].isNull()){

        }else{
            entity.secondPositioningAccuracy_ = object["secondPositioningAccuracy"].toDouble();
        }

        if(object["secondPositioningFrequencyMinimum"].isNull()){

        }else{
            entity.secondPositioningFrequencyMinimum_ = object["secondPositioningFrequencyMinimum"].toDouble();
        }
        if(object["secondPositioningFrequencyMaximum"].isNull()){

        }else{
            entity.secondPositioningFrequencyMaximum_ = object["secondPositioningFrequencyMaximum"].toDouble();
        }

        if(object["thirdPositioningAccuracy"].isNull()){

        }else{
            entity.thirdPositioningAccuracy_ = object["thirdPositioningAccuracy"].toDouble();
        }
        if(object["thirdPositioningFrequencyMinimum"].isNull()){

        }else{
            entity.thirdPositioningFrequencyMinimum_ = object["thirdPositioningFrequencyMinimum"].toDouble();
        }
        if(object["thirdPositioningFrequencyMaximum"].isNull()){

        }else{
            entity.thirdPositioningFrequencyMaximum_ = object["thirdPositioningFrequencyMaximum"].toDouble();
        }

        if(object["fourthPositioningAccuracy"].isNull()){

        }else{
            entity.fourthPositioningAccuracy_ = object["fourthPositioningAccuracy"].toDouble();
        }
        if(object["fourthPositioningFrequencyMinimum"].isNull()){

        }else{
            entity.fourthPositioningFrequencyMinimum_ = object["fourthPositioningFrequencyMinimum"].toDouble();
        }
        if(object["fourthPositioningFrequencyMaximum"].isNull()){

        }else{
            entity.fourthPositioningFrequencyMaximum_ = object["fourthPositioningFrequencyMaximum"].toDouble();
        }
        // 基础字段

        // entity.imageUrl_ = object["imageUrl"].toString().toStdString();
        // entity.recordCreationTime_ = QDateTime::currentDateTime();//object["record_creation_time"].toString().toStdString();//.toInt();
        // entity.useStatus_ =  true;//object["use_status"].toBool();
        // /******************** 系统记录 ********************/
        // //entity.uavCreatModelTime_ = recordCreationTime.toTime_t();
        // // 使用 QUrl 解析 URL 并提取本地路径
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

bool ReconnaissanceCommunicationDao::deleteReconnaissanceCommunicationData(const QJSValue &selectedData)
{
    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction delete deleteInterferencePodData started";
        // 3. 从JSON创建实体对象
        ReconnaissanceCommunicationEntity entity;
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

bool ReconnaissanceCommunicationDao::insertReconnaissanceCommunicationData(const QJsonObject &object)
{
    try {
        // 1. 建立数据库连接
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        qDebug() << "Connecting to database...";

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction started";
        // 3. 从JSON创建实体对象
        ReconnaissanceCommunicationEntity entity;
        // 定义查询条件
        // unique_ptr<entity> john (
        //     db->query_one<entity> (query::first == "John" &&
        //                           query::last == "Doe"));
        // if (john.get () != 0)
        //     db->erase (*john);
        //typedef odb::query<ReconnaissanceCommunicationEntity> query;
        // 3. 加载要修改的实体
        //std::shared_ptr<Person> person(db->load<Person>(1));  // 加载ID为1的记录
        // 获取要更新的记录ID
        // 从 QJsonObject 中提取 "id" 字段
        // QJsonValue idValue = object.value("id");

        // // 检查字段是否存在
        // if (idValue.isUndefined()) {
        //     qCritical() << "Error: JSON 中缺少 'id' 字段";
        //     return false;
        // }

        // // 将字段值转为 QString（无论原始类型是字符串还是数字）
        // QString idStr = idValue.toVariant().toString();

        // // 转换为整型并校验格式
        // bool ok;
        // int rid = idStr.toInt(&ok);
        // if (!ok) {
        //     qCritical() << "Error: 'id' 值无效，无法转换为整数：" << idStr;
        //     return false;
        // }

        // // 检查 ID 是否为正数（根据业务需求）
        // if (rid <= 0) {
        //     qCritical() << "Error: ID 必须为正整数，当前值：" << rid;
        //     return false;
        // }

        // // 此时 id 变量已包含正确的整数值
        // qDebug() << "成功获取 ID:" << rid;
        //db.load(rid, entity);
        entity.reconnaissanceName_ =  object["reconnaissanceName"].toString().toStdString();;
        entity.usedUavModels_ = object["usedUavModels"].toString().toStdString();;
        entity.description_ =  object["description"].toString().toStdString();
        // 处理数值类型（示例）/******************** 尺寸参数 ********************/
        if(object["frequencyMinimum"].isNull()){

        }else{
          entity.frequencyMinimum_ = object["frequencyMinimum"].toDouble(); // 假设返回float// 使用 QString::number 方法转换 float
        }
        if(object["frequencyMaximum"].isNull()){

        }else{
            entity.frequencyMaximum_ = object["frequencyMaximum"].toDouble();
        }
        if(object["firstReconnaissanceRange"].isNull()){

        }else{
           entity.firstReconnaissanceRange_ = object["firstReconnaissanceRange"].toDouble();
        }
        if(object["firstReconnaissanceFrequencyMinimum"].isNull()){

        }else{
            entity.firstReconnaissanceFrequencyMinimum_ = object["firstReconnaissanceFrequencyMinimum"].toDouble();
        }
        if(object["firstReconnaissanceFrequencyMaximum"].isNull()){

        }else{
            entity.firstReconnaissanceFrequencyMaximum_ = object["firstReconnaissanceFrequencyMaximum"].toDouble();
        }
        if(object["firstReconnaissanceRadiatedPower"].isNull()){

        }else{
            entity.firstReconnaissanceRadiatedPower_ = object["firstReconnaissanceRadiatedPower"].toDouble();
        }
        if(object["secondReconnaissanceRange"].isNull()){

        }else{
            entity.secondReconnaissanceRange_ = object["secondReconnaissanceRange"].toDouble();
        }
        if(object["secondReconnaissanceFrequencyMinimum"].isNull()){

        }else{
            entity.secondReconnaissanceFrequencyMinimum_ = object["secondReconnaissanceFrequencyMinimum"].toDouble();
        }
        if(object["secondReconnaissanceFrequencyMaximum"].isNull()){

        }else{
            entity.secondReconnaissanceFrequencyMaximum_ = object["secondReconnaissanceFrequencyMaximum"].toDouble();
        }
        if(object["secondReconnaissanceRadiatedPower"].isNull()){

        }else{
            entity.secondReconnaissanceRadiatedPower_ = object["secondReconnaissanceRadiatedPower"].toDouble();
        }
        if(object["thirdReconnaissanceRange"].isNull()){

        }else{
            entity.thirdReconnaissanceRange_ = object["thirdReconnaissanceRange"].toDouble();
        }
        if(object["thirdReconnaissanceFrequencyMinimum"].isNull()){

        }else{
            entity.thirdReconnaissanceFrequencyMinimum_ = object["thirdReconnaissanceFrequencyMinimum"].toDouble();
        }
        if(object["thirdReconnaissanceFrequencyMaximum"].isNull()){

        }else{
            entity.thirdReconnaissanceFrequencyMaximum_ = object["thirdReconnaissanceFrequencyMaximum"].toDouble();
        }

        if(object["thirdReconnaissanceRadiatedPower"].isNull()){

        }else{
            entity.thirdReconnaissanceRadiatedPower_ = object["thirdReconnaissanceRadiatedPower"].toDouble();
        }
        if(object["fourthReconnaissanceRange"].isNull()){

        }else{
            entity.fourthReconnaissanceRange_ = object["fourthReconnaissanceRange"].toDouble();
        }
        if(object["fourthReconnaissanceFrequencyMinimum"].isNull()){

        }else{
            entity.fourthReconnaissanceFrequencyMinimum_ = object["fourthReconnaissanceFrequencyMinimum"].toDouble();
        }
        if(object["fourthReconnaissanceFrequencyMaximum"].isNull()){

        }else{
            entity.fourthReconnaissanceFrequencyMaximum_ = object["fourthReconnaissanceFrequencyMaximum"].toDouble();
        }
        if(object["fourthReconnaissanceRadiatedPower"].isNull()){

        }else{
           entity.fourthReconnaissanceRadiatedPower_ = object["fourthReconnaissanceRadiatedPower"].toDouble();
        }
        if(object["firstOrientationAccuracy"].isNull()){

        }else{
            entity.firstOrientationAccuracy_ = object["firstOrientationAccuracy"].toDouble();
        }
        if(object["firstOrientationFrequencyMinimum"].isNull()){

        }else{
            entity.firstOrientationFrequencyMinimum_ = object["firstOrientationFrequencyMinimum"].toDouble();
        }
        if(object["firstOrientationFrequencyMaximum"].isNull()){

        }else{
            entity.firstOrientationFrequencyMaximum_ = object["firstOrientationFrequencyMaximum"].toDouble();
        }

        if(object["secondOrientationAccuracy"].isNull()){

        }else{
            entity.secondOrientationAccuracy_ = object["secondOrientationAccuracy"].toDouble();
        }
        if(object["secondOrientationFrequencyMinimum"].isNull()){

        }else{
            entity.secondOrientationFrequencyMinimum_ = object["secondOrientationFrequencyMinimum"].toDouble();
        }
        if(object["secondOrientationFrequencyMaximum"].isNull()){

        }else{
            entity.secondOrientationFrequencyMaximum_ = object["secondOrientationFrequencyMaximum"].toDouble();
        }
        if(object["thirdOrientationAccuracy"].isNull()){

        }else{
            entity.thirdOrientationAccuracy_ = object["thirdOrientationAccuracy"].toDouble();
        }
        if(object["thirdOrientationFrequencyMinimum"].isNull()){

        }else{
            entity.thirdOrientationFrequencyMinimum_ = object["thirdOrientationFrequencyMinimum"].toDouble();
        }
        if(object["thirdOrientationFrequencyMaximum"].isNull()){

        }else{
            entity.thirdOrientationFrequencyMaximum_ = object["thirdOrientationFrequencyMaximum"].toDouble();
        }
        if(object["fourthOrientationAccuracy"].isNull()){

        }else{
            entity.fourthOrientationAccuracy_ = object["fourthOrientationAccuracy"].toDouble();
        }

        if(object["fourthOrientationFrequencyMinimum"].isNull()){

        }else{
            entity.fourthOrientationFrequencyMinimum_ = object["fourthOrientationFrequencyMinimum"].toDouble();
        }
        if(object["fourthOrientationFrequencyMaximum"].isNull()){

        }else{
            entity.fourthOrientationFrequencyMaximum_ = object["fourthOrientationFrequencyMaximum"].toDouble();
        }

        if(object["firstPositioningAccuracy"].isNull()){

        }else{
            entity.firstPositioningAccuracy_ = object["firstPositioningAccuracy"].toDouble();
        }
        if(object["firstPositioningFrequencyMinimum"].isNull()){

        }else{
            entity.firstPositioningFrequencyMinimum_ = object["firstPositioningFrequencyMinimum"].toDouble();
        }

        if(object["firstPositioningFrequencyMaximum"].isNull()){

        }else{
            entity.firstPositioningFrequencyMaximum_ = object["firstPositioningFrequencyMaximum"].toDouble();
        }
        if(object["secondPositioningAccuracy"].isNull()){

        }else{
            entity.secondPositioningAccuracy_ = object["secondPositioningAccuracy"].toDouble();
        }

        if(object["secondPositioningFrequencyMinimum"].isNull()){

        }else{
            entity.secondPositioningFrequencyMinimum_ = object["secondPositioningFrequencyMinimum"].toDouble();
        }
        if(object["secondPositioningFrequencyMaximum"].isNull()){

        }else{
            entity.secondPositioningFrequencyMaximum_ = object["secondPositioningFrequencyMaximum"].toDouble();
        }

        if(object["thirdPositioningAccuracy"].isNull()){

        }else{
            entity.thirdPositioningAccuracy_ = object["thirdPositioningAccuracy"].toDouble();
        }
        if(object["thirdPositioningFrequencyMinimum"].isNull()){

        }else{
            entity.thirdPositioningFrequencyMinimum_ = object["thirdPositioningFrequencyMinimum"].toDouble();
        }
        if(object["thirdPositioningFrequencyMaximum"].isNull()){

        }else{
            entity.thirdPositioningFrequencyMaximum_ = object["thirdPositioningFrequencyMaximum"].toDouble();
        }

        if(object["fourthPositioningAccuracy"].isNull()){

        }else{
            entity.fourthPositioningAccuracy_ = object["fourthPositioningAccuracy"].toDouble();
        }
        if(object["fourthPositioningFrequencyMinimum"].isNull()){

        }else{
            entity.fourthPositioningFrequencyMinimum_ = object["fourthPositioningFrequencyMinimum"].toDouble();
        }
        if(object["fourthPositioningFrequencyMaximum"].isNull()){

        }else{
            entity.fourthPositioningFrequencyMaximum_ = object["fourthPositioningFrequencyMaximum"].toDouble();
        }

        // 基础字段

        entity.imageUrl_ = object["imageUrl"].toString().toStdString();
        //entity.recordCreationTime_ = QDateTime::currentDateTime();//object["record_creation_time"].toString().toStdString();//.toInt();
        entity.useStatus_ =  true;//object["use_status"].toBool();
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
        // auto id = db.persist(entity);
        // qDebug() << "Persisting entity..."<<id;

        //entity.uavName_("James");
        //entity.age("Newland");
        // 4. 持久化到数据库
        qDebug() << "Persisting entity...";
        auto id = db.persist(entity);
        // 提交事务
        trans.commit();
        qDebug()<<"当前函数名称:" << __FUNCTION__<<":" << "Transaction committed, 数据更新成功";
    } catch (const std::exception& e) {
        qCritical() << "Error:" << " 数据更新操作出错: " << e.what();
        return false;
    }
    return true;
}
