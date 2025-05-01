#include "ammodao.h"
#include "AmmunitionEntity.h"
#include "AmmunitionEntity-odb.hxx"

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
#include <QUrl>
#include <QDebug>
#include <QTemporaryFile>
#include <QImage>
AmmoDao::AmmoDao(QObject* parent) : QObject(parent){ //::UavModelDao() {
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

QJsonArray AmmoDao::selectAmmoAllData(const QJsonObject &selectedData)
{
    QJsonArray ammoModelData;
    QJsonDocument adoc(selectedData);
    qDebug()<<"当前xASRA wae  q函数名称:" << __FUNCTION__<<":";
    qDebug().noquote() << adoc.toJson(QJsonDocument::Indented);

//    using query_t = odb::query<AmmunitionEntity>;
//    // 1. 建立数据库连接
//    qDebug() << "Connecting to database...";

//    auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

//    // 2. 创建事务
//    odb::transaction trans(db.begin());
//    qDebug() << "Transaction started";



//        if (object["uavId"] == ""){
//            qDebug()<<"查询全部无人机型号";
//        }else{
//            if (object.contains("uavId") && object["uavId"].isString()) {
//                QString uav_id = object["uavId"].toString();
//                if (!uav_id.isEmpty()) {
//                    q = q && (query_t::uavId == uav_id.toStdString());
//                }
//            }
//        }


    try{
        // 1. 建立数据库连接
        qDebug() << "Connecting to selectAmmoAllData database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction select all started";
        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<AmmunitionEntity>;

        // 3. 从JSON创建实体对象
        AmmunitionEntity entity;

        query_t q(query_t::use_status == true); // 初始化为无条件query_t::true_expr

        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<AmmunitionEntity>;
        if (selectedData["ammoType"] == "请选择:"){
            qDebug()<<"查询全部无人机类型";
        }else{
            if (selectedData.contains("ammoType") && selectedData["ammoType"].isString()) {
                auto ammoType = selectedData["ammoType"].toString();
                q = q && (query_t::ammoType == ammoType.toStdString());
            }
        }
        if (selectedData["ammoName"] == ""){
            qDebug()<<"查询全部无人机名称";
        }else{
            // 处理 name 字段（使用 == 条件）
            if (selectedData.contains("ammoName") && selectedData["ammoName"].isString()) {
                QString ammoName = selectedData["ammoName"].toString();
                if (!ammoName.isEmpty()) {
                    q = q && (query_t::ammoName == ammoName.toStdString());
                }
            }
        }
        odb::result<AmmunitionEntity> result = db.query<AmmunitionEntity>(q);
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

        for (AmmunitionEntity entity : result) { //auto&& entity : result) {
            QJsonObject obj;
            qDebug() << "Processing record ID:" << entity.id_;  // 输出当前记录ID
            // 手动转换实体到 JSON（需要根据实际字段补充）
            obj["index"] = sum;
            obj["recordId"] = QString::number(entity.id_);
            obj["ammoId"] = QString::fromStdString(entity.ammoId_);
            obj["ammoName"] = QString::fromStdString(entity.ammoName_);
            obj["ammoType"] = QString::fromStdString(entity.ammoType_);
            obj["ammoToUavModel"] = QString::fromStdString(entity.ammoToUavModel_);
            obj["length"] = QString::number(entity.ammoLenth_);
            obj["wingspan"] = QString::number(entity.ammoWingspan_);
            obj["mass"] = QString::number(entity.ammoMass_);
            obj["diameter"] = QString::number(entity.ammoDiameter_);
            obj["description"] = QString::fromStdString(entity.ammoDescription_);

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

QJsonObject AmmoDao::selectSomeAmmoData(const QJsonObject &object)
{
    QJsonObject ammoData;
    using query_t = odb::query<AmmunitionEntity>;
    // 1. 建立数据库连接
    qDebug() << "Connecting to database...";

    auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

    // 2. 创建事务
    odb::transaction trans(db.begin());
    qDebug() << "Transaction started";
    try {

        // 3. 从JSON创建实体对象
        AmmunitionEntity entity;

        query_t q(query_t::true_expr); // 初始化为无条件
        if (object.contains("recordId") && object["recordId"].isString()) {
            auto uav_recordId = object["recordId"].toString();
            q = q && (query_t::id == uav_recordId.toInt());
        }

        // 执行查询
        auto result = db.query_one<AmmunitionEntity>(q);
        if (result) {
            const AmmunitionEntity& entity = *result;

            // 手动转换每个字段到QJsonObject// 基础字段
            ammoData["recordId"] = QString::number(entity.id_);
            ammoData["ammoName"] = QString::fromStdString(entity.ammoName_);
            ammoData["shortName"] = QString::fromStdString(entity.shortName_);
            ammoData["ammoType"] = QString::fromStdString(entity.ammoType_);
            ammoData["ammoId"] = QString::fromStdString(entity.ammoId_);
            ammoData["ammoToUavModel"] = QString::fromStdString(entity.ammoToUavModel_);
            ammoData["ammoDescription"] = QString::fromStdString(entity.ammoDescription_);

            ammoData["ammoLenth"] = QString::number(entity.ammoLenth_); // 假设返回float// 使用 QString::number 方法转换 float
            ammoData["ammoMass"] = QString::number(entity.ammoMass_);
            ammoData["ammoDiameter"] = QString::number(entity.ammoDiameter_);

            // 格式化为字符串（保留5位小数）
            // QString formattedValue = QString::number(entity.uavLength_, 'f', 5);
            // ammoData["uavLengthhangingCapacityStr"] = formattedValue;
            /******************** 飞行性能 ********************/
            ammoData["ammoWingspan"] = QString::number(entity.ammoWingspan_);
            ammoData["ammoWarheadCgDistance"] = QString::number(entity.ammoWarheadCgDistance_) ;
            ammoData["ammoChargeMass"] = QString::number(entity.ammoChargeMass_);
            ammoData["ammoChargeCoefficient"] = QString::number(entity.ammoChargeCoefficient_);
            ammoData["ammoMaxReleaseHeight"] = QString::number(entity.ammoMaxReleaseHeight_);
            ammoData["ammoMinReleaseHeight"] = QString::number(entity.ammoMinReleaseHeight);
            ammoData["ammoMinReleaseSpeed"] = QString::number(entity.ammoMinReleaseSpeed_);
            ammoData["ammoMaxReleaseSpeed"] = QString::number(entity.ammoMaxReleaseSpeed_);
            ammoData["ammoTailLength"] = QString::number(entity.ammoTailLength_);
            ammoData["ammoLugSpacing"] = QString::number(entity.ammoLugSpacing_);

            ammoData["ammoKillingWay"] = QString::fromStdString(entity.ammoKillingWway_);
            ammoData["ammoPenetrationDepth"] = QString::number(entity.ammoPenetrationDepth_);
            ammoData["ammoQuantitySoilThrown"] = QString::number(entity.ammoQuantitySoilThrown_);
            ammoData["ammoCraterDiameter"] = QString::number(entity.ammoCraterDiameter_);
            ammoData["ammoCraterDepth"] = QString::number(entity.ammoCraterDepth_);
            ammoData["ammoDamagedArea"] = QString::number(entity.ammoDamagedArea_);
            ammoData["ammoDenseKillingRadius"] = QString::number(entity.ammoDenseKillingRadius_);
            ammoData["ammoInitialVelocityFragments"] = QString::number(entity.ammoInitialVelocityFragments_);
            ammoData["ammoNumberFragments"] = QString::number(entity.ammoNumberFragments_);
            ammoData["ammoArmorBreakingAbility"] = QString::fromStdString(entity.ammoArmorBreakingAbility_);
            ammoData["bullet_density_range_minimum"] = QString::number(entity.bullet_density_range_minimum);
            ammoData["bullet_density_range_maximum"] = QString::number(entity.bullet_density_range_maximum);
            ammoData["ground_ignition_rate"] = QString::number(entity.ground_ignition_rate);
            ammoData["combustion_temperature"] = QString::number(entity.combustion_temperature);
            ammoData["combustion_time"] = QString::number(entity.combustion_time);
            ammoData["combustion_agent_spread_range"] = QString::number(entity.combustion_agent_spread_range);
            ammoData["number_of_fragments"] = QString::number(entity.number_of_fragments);
            ammoData["breakdown_distance"] = QString::number(entity.breakdown_distance);
            ammoData["maximum_inclusive_coverage_quantity"] = QString::number(entity.maximum_inclusive_coverage_quantity);
            ammoData["number_of_spread"] = QString::number(entity.number_of_spread);
            ammoData["surface_dc_resistivity"] = QString::number(entity.surface_dc_resistivity);
            ammoData["probability_of_arc_discharge"] = QString::number(entity.probability_of_arc_discharge);
            ammoData["fuel_dispersion_radius"] = QString::number(entity.fuel_dispersion_radius);
            ammoData["distance_from_center_explosion"] = QString::number(entity.distance_from_center_explosion);
            ammoData["shock_wave_overpressure_value"] = QString::number(entity.shock_wave_overpressure_value);
            ammoData["spread_area"] = QString::number(entity.spread_area);
            ammoData["use_description"] = QString::fromStdString(entity.use_description);
            ammoData["interference_duration"] = QString::number(entity.interference_duration);
            ammoData["interference_length_minimum"] = QString::number(entity.interference_length_minimum);

            /******************** 挂载能力 ********************/
            //ammoData["hardpoint_loc"] = QString::fromStdString(entity.uavHangingLoctionCapacity_);
            // entity.uavHangingpoints_ = ammoData["hardpoint_num"].toInt();
            // entity.uavPayloadcapacity_ = ammoData["payload_capacity"].toInt();

            ammoData["interference_length_maximum"] = QString::number(entity.interference_length_maximum);
            ammoData["interference_width_minimum"] = QString::number(entity.interference_width_minimum);
            ammoData["interference_width_maximum"] = QString::number(entity.interference_width_maximum);
            ammoData["fuze_model"] = QString::fromStdString(entity.fuze_model);
            ammoData["number_of_fuses"] = QString::number(entity.number_of_fuses);
            ammoData["storage_life"] = QString::number(entity.storage_life);
            ammoData["action_time"] = QString::number(entity.action_time);
            ammoData["available_extension_time"] = QString::number(entity.available_extension_time);
            ammoData["rudder_width"] = QString::number(entity.rudder_width);
            ammoData["aerodynamic_configuration"] = QString::fromStdString(entity.aerodynamic_configuration);
            ammoData["working_conditions"] = QString::fromStdString(entity.working_conditions);
            ammoData["working_temperature"] = QString::number(entity.working_temperature);
            ammoData["working_altitude"] = QString::number(entity.working_altitude);
            ammoData["launch_way"] = QString::fromStdString(entity.launch_way);
            ammoData["guidance_rule"] = QString::fromStdString(entity.guidance_rule);
            ammoData["minimum_visibility_emission"] = QString::number(entity.minimum_visibility_emission);
            ammoData["maximum_launch_altitude"] = QString::number(entity.maximum_launch_altitude);
            ammoData["launch_maximum_target_altitude"] = QString::number(entity.launch_maximum_target_altitude);
            ammoData["maximum_launch_relative_height"] = QString::number(entity.maximum_launch_relative_height);
            ammoData["minimum_relative_height_launch"] = QString::number(entity.minimum_relative_height_launch);
            ammoData["launch_speed"] = QString::number(entity.launch_speed);
            ammoData["launch_conditions"] = QString::fromStdString(entity.launch_conditions);
            ammoData["launch_off_axis_angle"] = QString::number(entity.launch_off_axis_angle);
            ammoData["guidance_way"] = QString::fromStdString(entity.guidance_way);
            ammoData["effective_range"] = QString::number(entity.effective_range);
            ammoData["hit_accuracy"] = QString::number(entity.hit_accuracy);
            ammoData["hit_probability"] = QString::number(entity.hit_probability);
            ammoData["preparation_time"] = QString::number(entity.preparation_time);
            ammoData["allow_continuous_flight_time"] = QString::number(entity.allow_continuous_flight_time);
            ammoData["guided_flight_time"] = QString::number(entity.guided_flight_time);
            ammoData["maximum_speed_of_missile"] = QString::number(entity.maximum_speed_of_missile);
            ammoData["guiding_head_working_wavelength"] = QString::number(entity.guiding_head_working_wavelength);
            ammoData["blind_spot_of_guidance_head"] = QString::number(entity.blind_spot_of_guidance_head);
            ammoData["guidance_head_frame_angle"] = QString::number(entity.guidance_head_frame_angle);
            ammoData["guidance_head_operating_distance"] = QString::number(entity.guidance_head_operating_distance);
            ammoData["guidance_head_field_of_view_angle"] = QString::number(entity.guidance_head_field_of_view_angle);
            ammoData["guidance_head_field_of_view_angle_linearregion"] = QString::number(entity.guidance_head_field_of_view_angle_linearregion);
            ammoData["guidance_head_field_of_view_angle_instantaneous"] = QString::number(entity.guidance_head_field_of_view_angle_instantaneous);

            ammoData["adaptability_of_guidance_head_sunlight"] = QString::fromStdString(entity.adaptability_of_guidance_head_sunlight);
            ammoData["guidance_head_operating_frequency"] = QString::number(entity.guidance_head_operating_frequency);
            ammoData["fuse_firing_rate"] = QString::number(entity.fuse_firing_rate);
            ammoData["fuse_type"] = QString::fromStdString(entity.fuse_type);
            ammoData["fuse_length"] = QString::number(entity.fuse_length);
            ammoData["fuse_diameter"] = QString::number(entity.fuse_diameter);
            ammoData["fuze_quality"] = QString::number(entity.fuze_quality);
            ammoData["safe_distance_of_fuse"] = QString::number(entity.safe_distance_of_fuse);
            ammoData["time_disarming_fuse"] = QString::number(entity.time_disarming_fuse);
            ammoData["first_level_release_time_of_fuse"] = QString::number(entity.first_level_release_time_of_fuse);
            ammoData["secondary_release_time_of_fuse"] = QString::number(entity.secondary_release_time_of_fuse);
            ammoData["reliability_rate_of_fuse_action"] = QString::number(entity.reliability_rate_of_fuse_action);
            ammoData["fuse_self_destruct_time"] = QString::number(entity.fuse_self_destruct_time);
            ammoData["combat_department_quality"] = QString::number(entity.combat_department_quality);
            ammoData["combat_quantity"] = QString::number(entity.combat_quantity);
            ammoData["combat_unit_type"] = QString::fromStdString(entity.combat_unit_type);
            ammoData["combat_length"] = QString::number(entity.combat_length);
            ammoData["combat_diameter"] = QString::number(entity.combat_diameter);
            ammoData["combat_main_charge_type"] = QString::fromStdString(entity.combat_main_charge_type);
            ammoData["combat_charge_density"] = QString::number(entity.combat_charge_density);
            ammoData["combat_loading_factor"] = QString::number(entity.combat_loading_factor);
            ammoData["combat_explosive"] = QString::number(entity.combat_explosive);
            ammoData["combat_fragments_number"] = QString::number(entity.combat_fragments_number);
            ammoData["combat_unit_invasion_capability"] = QString::fromStdString(entity.combat_unit_invasion_capability);
            ammoData["combat_effective_killing_radius_vehicles"] = QString::number(entity.combat_effective_killing_radius_vehicles);
            ammoData["combat_effective_killing_radius_personnel"] = QString::number(entity.combat_effective_killing_radius_personnel);
            ammoData["combat_vertical_static_armor_penetration_depth"] = QString::number(entity.combat_vertical_static_armor_penetration_depth);
            ammoData["combat_department_quality_add"] = QString::number(entity.combat_department_quality_add);
            ammoData["combat_quantity_add"] = QString::number(entity.combat_quantity_add);

            ammoData["combat_unit_type_add"] = QString::fromStdString(entity.combat_unit_type_add);
            ammoData["combat_length_add"] = QString::number(entity.combat_length_add);
            ammoData["combat_diameter_add"] = QString::number(entity.combat_diameter_add);
            ammoData["combat_main_charge_type_add"] = QString::fromStdString(entity.combat_main_charge_type_add);
            ammoData["combat_charge_density_add"] = QString::number(entity.combat_charge_density_add);
            ammoData["combat_loading_factor_add"] = QString::number(entity.combat_loading_factor_add);
            ammoData["combat_explosive_add"] = QString::number(entity.combat_explosive_add);
            ammoData["combat_fragments_number_add"] = QString::number(entity.combat_fragments_number_add);
            ammoData["combat_unit_invasion_capability_add"] = QString::fromStdString(entity.combat_unit_invasion_capability_add);
            ammoData["combat_effective_killing_radius_vehicles_add"] = QString::number(entity.combat_effective_killing_radius_vehicles_add);
            ammoData["combat_effective_killing_radius_personnel_add"] = QString::number(entity.combat_effective_killing_radius_personnel_add);
            ammoData["combat_vertical_static_armor_penetration_depth_add"] = QString::number(entity.combat_vertical_static_armor_penetration_depth_add);
            ammoData["service_life"] = QString::number(entity.service_life);
            ammoData["distance_between_center_mass_end"] = QString::number(entity.distance_between_center_mass_end);
            ammoData["lifting_lug"] = QString::fromStdString(entity.lifting_lug);
            ammoData["distance_suspension_lifting_lug"] = QString::number(entity.distance_suspension_lifting_lug);
            //ammoData["image_url"] = QString::fromStdString(entity.image_url);
           /******************** 系统记录 ********************/
            //entity.uavCreatModelTime_ = recordCreationTime.toTime_t();
            //ammoData["image_name"] = QString::fromStdString(entity.uavImgName_);

            QByteArray imageData(entity.image_name.data(), entity.image_name.size());
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

            ammoData["image_url"] = newFilePath;
            // 转换为格式化的JSON字符串
            QJsonDocument doc(ammoData);
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
    return ammoData;
}

bool AmmoDao::updateAmmoData(const QJSValue &selectedData)
{
    return true;
}

bool AmmoDao::deleteAmmoData(const QJSValue &selectedData)
{    try {
        // 1. 建立数据库连接
        qDebug() << "Connecting to database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction delete started";
        // 3. 从JSON创建实体对象
        AmmunitionEntity entity;
        //typedef odb::query<AmmunitionEntity> query;
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
            //entity.ammoGuidanceCode_ = ammoIdStr.toInt();
            //entity.ammoGuidanceName_= ammoNameStr.toStdString();
            entity.use_status = ammoStatusStr;
            qDebug() << "before update";
            // 4. 修改数据
            db.update(entity);
            // auto rst = db.erase_query<AmmoGuidanceEntity>(//db.erase_query<UavModelEntity>
            //     query::id == recordId
            //     && query::ammoGuidanceName == ammoNameStr.toStdString().c_str()
            //     //&& query::mountLocationId == mountLocationIdStr.toInt()//.c_str()
            //     ); // 替换 condition1、condition2 为实际的字段名，value1、value2 为实际的值
            qDebug() << "recordId:" << dataMap["recordId"].toInt();
            qDebug() << "ammoName:" << dataMap["ammoName"].toString();
            qDebug() << "ammoId:" << dataMap["ammoCode"].toString();
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

bool AmmoDao::insertAmmoData(const QJsonObject &object)
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
        AmmunitionEntity entity;
        QDateTime recordCreationTime;//创建记录时间

        // 4. 映射JSON字段到实体属性
        // 基础字段
        //#pragma db not_null column("ammo_name")//            VARCHAR(100) NOT NULL ,--COMMENT '名称',


        entity.ammoName_ = object["ammoName"].toString().toStdString();//.toInt();
        entity.shortName_= object["shortName"].toString().toStdString();
        entity.ammoType_ = object["ammoType"].toString().toStdString();
        entity.ammoId_ = object["ammoId"].toString().toStdString();
        entity.ammoToUavModel_ = object["ammoToUavModel"].toString().toStdString();
        entity.ammoDescription_ = object["ammoDescription"].toString().toStdString();//.toInt();
        entity.ammoLenth_ = object["ammoLenth"].toDouble();
        entity.ammoMass_ = object["ammoMass"].toDouble();
        entity.ammoDiameter_ = object["ammoDiameter"].toDouble();
        entity.ammoWingspan_ = object["ammoWingspan"].toDouble();
        entity.ammoWarheadCgDistance_ = object["ammoWarheadCgDistance"].toDouble();//.toInt();
        entity.ammoChargeMass_ = object["ammoChargeMass"].toDouble();
        entity.ammoChargeCoefficient_ = object["ammoChargeCoefficient"].toBool();
        entity.ammoMaxReleaseHeight_ = object["ammoMaxReleaseHeight"].toDouble();
        entity.ammoMinReleaseHeight = object["ammoMinReleaseHeight"].toDouble();
        entity.ammoMinReleaseSpeed_ = object["ammoMinReleaseSpeed"].toDouble();//.toInt();
        entity.ammoMaxReleaseSpeed_ = object["ammoMaxReleaseSpeed"].toDouble();
        entity.ammoTailLength_ = object["ammoTailLength"].toDouble();
        entity.ammoLugSpacing_ = object["ammoLugSpacing"].toDouble();



        entity.ammoKillingWway_ = object["ammoKillingWay"].toString().toStdString();
        entity.ammoPenetrationDepth_ = object["ammoPenetrationDepth"].toDouble();//.toInt();
        entity.ammoQuantitySoilThrown_ = object["ammoQuantitySoilThrown"].toDouble();
        entity.ammoCraterDiameter_ = object["ammoCraterDiameter"].toDouble();
        entity.ammoCraterDepth_ = object["ammoCraterDepth"].toDouble();
        entity.ammoDamagedArea_ = object["ammoDamagedArea"].toDouble();
        entity.ammoDenseKillingRadius_ = object["ammoDenseKillingRadius"].toDouble();//.toInt();
        entity.ammoInitialVelocityFragments_ = object["ammoInitialVelocityFragments"].toDouble();
        entity.ammoNumberFragments_ = object["ammoNumberFragments"].toInt();
        entity.ammoArmorBreakingAbility_ = object["ammoArmorBreakingAbility"].toString().toStdString();
        entity.bullet_density_range_minimum = object["bullet_density_range_minimum"].toInt();
        entity.bullet_density_range_maximum = object["bullet_density_range_maximum"].toInt();//.toInt();
        entity.ground_ignition_rate = object["ground_ignition_rate"].toDouble();
        entity.combustion_temperature = object["combustion_temperature"].toDouble();
        entity.combustion_time = object["combustion_time"].toDouble();
        entity.combustion_agent_spread_range = object["combustion_agent_spread_range"].toDouble();
        entity.number_of_fragments = object["number_of_fragments"].toInt();//.toInt();
        entity.breakdown_distance = object["breakdown_distance"].toDouble();
        entity.maximum_inclusive_coverage_quantity = object["maximum_inclusive_coverage_quantity"].toInt();
        entity.number_of_spread = object["number_of_spread"].toInt();
        entity.surface_dc_resistivity = object["surface_dc_resistivity"].toDouble();
        entity.probability_of_arc_discharge = object["probability_of_arc_discharge"].toDouble();//.toInt();
        entity.fuel_dispersion_radius = object["fuel_dispersion_radius"].toDouble();
        entity.distance_from_center_explosion = object["distance_from_center_explosion"].toDouble();
        entity.shock_wave_overpressure_value = object["shock_wave_overpressure_value"].toDouble();
        entity.spread_area = object["spread_area"].toDouble();
        entity.use_description = object["use_description"].toString().toStdString();//.toInt();
        entity.interference_duration = object["interference_duration"].toDouble();
        entity.interference_length_minimum = object["interference_length_minimum"].toDouble();

        entity.interference_length_maximum = object["interference_length_maximum"].toDouble();
        entity.interference_width_minimum = object["interference_width_minimum"].toDouble();
        entity.interference_width_maximum = object["interference_width_maximum"].toDouble();//.toInt();
        entity.fuze_model = object["fuze_model"].toString().toStdString();
        entity.number_of_fuses = object["number_of_fuses"].toInt();
        entity.storage_life = object["storage_life"].toDouble();
        entity.action_time = object["action_time"].toDouble();
        entity.available_extension_time = object["available_extension_time"].toDouble();//.toInt();
        entity.rudder_width = object["rudder_width"].toDouble();
        entity.aerodynamic_configuration = object["aerodynamic_configuration"].toString().toStdString();
        entity.working_conditions = object["working_conditions"].toString().toStdString();
        entity.working_temperature = object["working_temperature"].toDouble();
        entity.working_altitude = object["working_altitude"].toDouble();//.toInt();
        entity.launch_way = object["launch_way"].toString().toStdString();
        entity.guidance_rule = object["guidance_rule"].toString().toStdString();
        entity.minimum_visibility_emission = object["minimum_visibility_emission"].toDouble();
        entity.maximum_launch_altitude = object["maximum_launch_altitude"].toDouble();
        entity.launch_maximum_target_altitude = object["launch_maximum_target_altitude"].toDouble();//.toInt();
        entity.maximum_launch_relative_height = object["maximum_launch_relative_height"].toDouble();
        entity.minimum_relative_height_launch = object["minimum_relative_height_launch"].toDouble();
        entity.launch_speed = object["launch_speed"].toDouble();
        entity.launch_conditions = object["launch_conditions"].toString().toStdString();
        entity.launch_off_axis_angle = object["launch_off_axis_angle"].toDouble();//.toInt();
        entity.guidance_way = object["guidance_way"].toString().toStdString();
        entity.effective_range = object["effective_range"].toDouble();
        entity.hit_accuracy = object["hit_accuracy"].toDouble();
        entity.hit_probability = object["hit_probability"].toDouble();
        entity.preparation_time = object["preparation_time"].toDouble();//.toInt();
        entity.allow_continuous_flight_time = object["allow_continuous_flight_time"].toDouble();
        entity.guided_flight_time = object["guided_flight_time"].toDouble();
        entity.maximum_speed_of_missile = object["maximum_speed_of_missile"].toDouble();
        entity.guiding_head_working_wavelength = object["guiding_head_working_wavelength"].toDouble();
        entity.blind_spot_of_guidance_head = object["blind_spot_of_guidance_head"].toDouble();//.toInt();
        entity.guidance_head_frame_angle = object["guidance_head_frame_angle"].toDouble();
        entity.guidance_head_operating_distance = object["guidance_head_operating_distance"].toDouble();
        entity.guidance_head_field_of_view_angle = object["guidance_head_field_of_view_angle"].toDouble();
        entity.guidance_head_field_of_view_angle_linearregion = object["guidance_head_field_of_view_angle_linearregion"].toDouble();
        entity.guidance_head_field_of_view_angle_instantaneous = object["guidance_head_field_of_view_angle_instantaneous"].toDouble();


        entity.adaptability_of_guidance_head_sunlight = object["adaptability_of_guidance_head_sunlight"].toString().toStdString();
        entity.guidance_head_operating_frequency = object["guidance_head_operating_frequency"].toDouble();
        entity.fuse_firing_rate = object["fuse_firing_rate"].toDouble();//.toInt();
        entity.fuse_type = object["fuse_type"].toString().toStdString();
        entity.fuse_length = object["fuse_length"].toDouble();
        entity.fuse_diameter = object["fuse_diameter"].toDouble();
        entity.fuze_quality = object["fuze_quality"].toDouble();
        entity.safe_distance_of_fuse = object["safe_distance_of_fuse"].toDouble();//.toInt();
        entity.time_disarming_fuse = object["time_disarming_fuse"].toDouble();
        entity.first_level_release_time_of_fuse = object["first_level_release_time_of_fuse"].toDouble();
        entity.secondary_release_time_of_fuse = object["secondary_release_time_of_fuse"].toDouble();
        entity.reliability_rate_of_fuse_action = object["reliability_rate_of_fuse_action"].toDouble();
        entity.fuse_self_destruct_time = object["fuse_self_destruct_time"].toDouble();//.toInt();
        entity.combat_department_quality = object["combat_department_quality"].toDouble();
        entity.combat_quantity = object["combat_quantity"].toDouble();
        entity.combat_unit_type = object["combat_unit_type"].toString().toStdString();
        entity.combat_length = object["combat_length"].toDouble();
        entity.combat_diameter = object["combat_diameter"].toDouble();//.toInt();
        entity.combat_main_charge_type = object["combat_main_charge_type"].toString().toStdString();
        entity.combat_charge_density = object["combat_charge_density"].toDouble();
        entity.combat_loading_factor = object["combat_loading_factor"].toDouble();
        entity.combat_explosive = object["combat_explosive"].toDouble();
        entity.combat_fragments_number = object["combat_fragments_number"].toInt();//.toInt();
        entity.combat_unit_invasion_capability = object["combat_unit_invasion_capability"].toString().toStdString();

        entity.combat_effective_killing_radius_vehicles = object["combat_effective_killing_radius_vehicles"].toDouble();
        entity.combat_effective_killing_radius_personnel = object["combat_effective_killing_radius_personnel"].toDouble();
        entity.combat_vertical_static_armor_penetration_depth = object["combat_vertical_static_armor_penetration_depth"].toDouble();
        entity.combat_department_quality_add = object["combat_department_quality_add"].toDouble();//.toInt();
        entity.combat_quantity_add = object["combat_quantity_add"].toDouble();


        entity.combat_unit_type_add = object["combat_unit_type_add"].toString().toStdString();
        entity.combat_length_add = object["combat_length_add"].toDouble();
        entity.combat_diameter_add = object["combat_diameter_add"].toDouble();
        entity.combat_main_charge_type_add = object["combat_main_charge_type_add"].toString().toStdString();//.toInt();
        entity.combat_charge_density_add = object["combat_charge_density_add"].toDouble();
        entity.combat_loading_factor_add = object["combat_loading_factor_add"].toDouble();
        entity.combat_explosive_add = object["combat_explosive_add"].toDouble();
        entity.combat_fragments_number_add = object["combat_fragments_number_add"].toInt();
        entity.combat_unit_invasion_capability_add = object["combat_unit_invasion_capability_add"].toString().toStdString();//.toInt();
        entity.combat_effective_killing_radius_vehicles_add = object["combat_effective_killing_radius_vehicles_add"].toDouble();
        entity.combat_effective_killing_radius_personnel_add = object["combat_effective_killing_radius_personnel_add"].toDouble();
        entity.combat_vertical_static_armor_penetration_depth_add = object["combat_vertical_static_armor_penetration_depth_add"].toDouble();
        entity.service_life = object["service_life"].toDouble();
        entity.distance_between_center_mass_end = object["distance_between_center_mass_end"].toDouble();//.toInt();
        entity.lifting_lug = object["lifting_lug"].toString().toStdString();
        entity.distance_suspension_lifting_lug = object["distance_suspension_lifting_lug"].toDouble();
        //entity.image_name = object["image_name"].toString().toStdString();
        entity.image_url = object["image_url"].toString().toStdString();
        entity.record_creation_time = QDateTime::currentDateTime();//object["record_creation_time"].toString().toStdString();//.toInt();
        entity.use_status =  true;//object["use_status"].toBool();
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
        entity.image_name = std::vector<char>(data.begin(),data.end());
        std::vector<char> imagByteA(data.begin(), data.end());
        std::cout << "imagByteA: "<<imagByteA.size()<<"Data size" << entity.image_name.size() << std::endl;
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
