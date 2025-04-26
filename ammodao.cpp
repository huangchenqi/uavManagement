#include "ammodao.h"
#include "AmmunitionEntity.h"
#include "AmmunitionEntity-odb.hxx"
#include <QDebug>
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

QJsonObject AmmoDao::selectSomeAmmoData(const QJsonObject &selectedData)
{
    QJsonObject object;
    return object;
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
// bool UavModelDao::insertModelDate(const QJsonObject& objectData)
// {
//     qDebug() << "Starting database insertion...";
//     QJsonObject checkResult;
//     QJsonObject object;
//     //checkResult = checkUavDataObject(object);
//     // 转换为格式化的JSON字符串
//     QJsonDocument doc(objectData);
//     QString jsonString = doc.toJson(QJsonDocument::Indented);
//     qDebug() << "图片的数据:" << jsonString;
//     // 解析 JSON 数据
//     QJsonDocument trDoc(objectData); //QJsonDocument::fromJson(jsonString.toUtf8());
//     if (!trDoc.isNull() && trDoc.isObject()) {
//         QJsonObject uavData = trDoc.object();

//         // 指定需要转换的字段
//         QStringList fieldsToTransform = {
//             "load_ammo_type",
//             "payload_type",
//             "bomb_method",
//             "operation_method",
//             "recovery_mode"
//         };

//         object  = transformArrayToStr(uavData, fieldsToTransform);

//         // 打印转换后的数据
//         QJsonDocument transformedDoc(object);
//         qDebug() << "转换后的数据:" << transformedDoc.toJson(QJsonDocument::Compact);
//     }        // 打印到控制台
//     qDebug()<<"Qt function UavModelDao insertModelDat JSON内容：\n" << jsonString;
//     try {
//         // 1. 建立数据库连接
//         qDebug() << "Connecting to database...";
//         // odb::pgsql::database db(
//         //     "postgres",       // username
//         //     "123456",         // password
//         //     "db_aux_prac_sys",// database
//         //     "192.168.0.101",  // host
//         //     5432              // port
//         //     );
//         auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库

//         // 2. 创建事务
//         odb::transaction trans(db.begin());
//         qDebug() << "Transaction insert started";

//         // 3. 从JSON创建实体对象
//         UavModelEntity entity;
//         QDateTime recordCreationTime;//创建记录时间

//         // 4. 映射JSON字段到实体属性
//         // 基础字段
//         entity.uavType_ = object["uav_type"].toString().toStdString();
//         entity.uavName_ = object["uav_name"].toString().toStdString();
//         entity.uavId_ = object["uav_id"].toString().toStdString();

//         /******************** 尺寸参数 ********************/
//         entity.uavLength_ = object["length"].toDouble();
//         entity.uavWidth_ = object["width"].toDouble();
//         entity.uavHeight_ = object["height"].toDouble();


//         /******************** 飞行性能 ********************/
//         entity.uavFlightHeightRangeMin_ = object["flight_height_min"].toDouble();
//         entity.uavFlightHeightRangeMax_ = object["flight_height_max"].toDouble();
//         entity.uavFlightSpeedRangeMin_ = object["flight_speed_min"].toDouble();
//         entity.uavFlightSpeedRangeMax_ = object["flight_speed_max"].toDouble();
//         entity.uavFlightDistanceRangeMin_ = object["flight_distance_min"].toDouble();
//         entity.uavFlightDistanceRangeMax_ = object["flight_distance_max"].toDouble();
//         entity.uavFlightTimeRangeMin_ = object["flight_time_min"].toDouble();
//         entity.uavFlightTimeRangeMax_ = object["flight_time_max"].toDouble();

//         /******************** 起降参数 ********************/
//         entity.uavTakeoffDistance_ = object["takeoff_distance"].toDouble();
//         entity.uavLandDistance_ = object["landing_distance"].toDouble();

//         /******************** 机动性能 ********************/
//         entity.uavTurningRadiusRangeMin_ = object["turn_radius_min"].toDouble();
//         entity.uavTurningRadiusRangeMax_ = object["turn_radius_max"].toDouble();
//         entity.uavOperatioanalRadius_ = object["combat_radius"].toDouble();

//         /******************** 载荷配置 ********************/
//         entity.uavInvestigationPayloadType_ = object["payload_type"].toString().toStdString();

//         entity.uavBombingway_ = object["bomb_method"].toString().toStdString();
//         entity.uavOperationWay_ = object["operation_method"].toString().toStdString();
//         entity.uavRecoveryway_ = object["recovery_mode"].toString().toStdString();
//         entity.uavHangingLoctionCapacity_ = object["hanging_capacity"].toString().toStdString();
//         entity.uavLoadAmmoType_ = object["load_ammo_type"].toString().toStdString();

//         entity.uavLoadReconnaissanceRangeMin_ = object["recon_range_min"].toDouble();
//         entity.uavLoadReconnaissanceRangeMax_ = object["recon_range_max"].toDouble();
//         entity.uavLoadReconnaissanceAccuracy_ = object["recon_accuracy"].toDouble();

//         /******************** 回收与突防 ********************/

//         entity.uavLowAltitudeBreakthroughSpeed_ = object["low_alt_speed"].toDouble();

//         /******************** 挂载能力 ********************/

//         // entity.uavPayloadcapacity_ = object["payload_capacity"].toInt();
//         entity.uavAttackaccuracy_ = object["attack_accuracy"].toDouble();

//         /******************** 雷达特征 ********************/
//         entity.uavRadarCrossSection_ = object["rcs"].toDouble();

//         /******************** 重量与平衡 ********************/
//         entity.uavCenterOfGravityFrontLimit_ = object["cg_front_limit"].toDouble();
//         entity.uavCenterOfGravityAfterwardLimit_ = object["cg_rear_limit"].toDouble();
//         entity.uavMaximumTakeoffWeight_ = object["max_takeoff_weight"].toDouble();
//         entity.uavEmptyWeight_ = object["empty_weight"].toDouble();

//         /******************** 燃油与载重 ********************/
//         entity.uavMaximumFuelCapacity_ = object["max_fuel"].toDouble();
//         entity.uavMaximumExternalWeight_ = object["max_external_weight"].toDouble();

//         /******************** 高度性能 ********************/
//         entity.uavCeiling_ = object["ceiling"].toDouble();
//         entity.uavMaximumGroundStartingHeight_ = object["ground_start_alt"].toDouble();
//         entity.uavMaximumAirStartingAltitude_ = object["air_start_alt"].toDouble();

//         /******************** 续航性能 ********************/
//         entity.uavMaximumEndurance_ = object["endurance"].toDouble();
//         entity.uavMaximumFlightVacuumSpeed_ = object["max_vacuum_speed"].toDouble();
//         entity.uavMinimumFlightMeterSpeed_ = object["min_meter_speed"].toDouble();

//         /******************** 特殊场景性能 ********************/
//         entity.sealLevelTakeoffAndRollDistance_ = object["sea_takeoff_roll"].toDouble();
//         entity.sealLevelLandingAndRollDistance_ = object["sea_landing_roll"].toDouble();
//         entity.cruiseAltitudeReconnaissanceConfiguration_ = object["recon_cruise_alt"].toDouble();
//         entity.cruiseAltitudeFullExternalConfiguration_ = object["full_external_cruise_alt"].toDouble();

//         /******************** 系统记录 ********************/
//         //entity.uavCreatModelTime_ = recordCreationTime.toTime_t();
//         // 使用 QUrl 解析 URL 并提取本地路径
//         QString image_url = object["image_url"].toString();
//         QUrl url(image_url);
//         QString localFilePath = url.toLocalFile();
//         QFile file(localFilePath);

//         qDebug()<<"image_url:"<<object["image_url"].toString();
//         file.open(QIODevice::ReadOnly);
//         QByteArray data = file.readAll();
//         file.close();
//         //std::vector  imagByteA = std::vector<unsigned char>(data.begin(),data.end());
//         entity.uavImgName_ = std::vector<char>(data.begin(),data.end());
//         std::vector<char> imagByteA(data.begin(), data.end());
//         std::cout << "imagByteA: "<<imagByteA.size()<<"Data size" << entity.uavImgName_.size() << std::endl;


//         // std::vector<unsigned char> content;

//         // // 文件写入方法
//         // bool save_to_file(const std::string& path) {
//         //     QFile file(QString::fromStdString(path));
//         //     if (!file.open(QIODevice::WriteOnly)) return false;
//         //     file.write(reinterpret_cast<const char*>(content.data()), content.size());
//         //     return file.flush();
//         // }

//         // // 文件加载方法
//         // static BinaryData load_from_file(const std::string& path) {
//         //     QFile file(QString::fromStdString(path));
//         //     file.open(QIODevice::ReadOnly);
//         //     QByteArray data = file.readAll();
//         //     return {std::vector<unsigned char>(data.begin(), data.end())};
//         // }
//         //entity.uavImgName_ = object["image_name"].toString().toStdString();
//         //entity.uavImgUrl_ = object["image_url"].toString().toStdString();

//         // 5. 数据验证
//         // if (entity.getUavType().empty()) {
//         //     throw std::invalid_argument("Missing required field: uav_type");
//         // }
//         // 6. 持久化到数据库
//         qDebug() << "Persisting entity...";
//         auto id = db.persist(entity);

//         // 7. 提交事务
//         trans.commit();
//         qDebug() <<"当前函数名称:" << __FUNCTION__<<":"<< "Transaction committed, ID:" << id;

//         //return id;
//     }
//     catch (const odb::exception& e) {
//         qCritical() << "Database error:" << e.what();
//         return false;
//         //throw;
//     }
//     catch (const std::exception& e) {
//         qCritical() << "Error:" << e.what();
//         return false;//throw;
//     }
//     return true;

// }
