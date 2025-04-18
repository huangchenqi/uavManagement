#include "ammodao.h"
#include "AmmunitionEntity.h"
#include "AmmunitionEntity-odb.hxx"
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

QJsonArray AmmoDao::selectAmmoAllData()
{
    QJsonArray ammoModelData;

    try{
        // 1. 建立数据库连接
        qDebug() << "Connecting to selectAmmoAllData database...";
        auto& db = dbConn_->getDatabase(); // 使用成员变量获取数据库
        // 2. 创建事务
        odb::transaction trans(db.begin());
        qDebug() << "Transaction select all started";
        // 关键修正1：使用 query<UavModelEntity> 获取结果集
        using query_t = odb::query<AmmunitionEntity>;

        odb::result<AmmunitionEntity> result = db.query<AmmunitionEntity>(query_t::true_expr);
        qDebug() << "Query returned" << result.size() << "records";  // 添加此行
        // 关键修正2：遍历所有结果
        int sum = 0;
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
            obj["length"] = QString::number(entity.ammoLength_);
            obj["width"] = QString::number(entity.ammoWidth_);
            obj["weight"] = QString::number(entity.ammoWeight_);
            obj["guidangce_type"] = QString::fromStdString(entity.guidanceType_);
            obj["launch_height_min"] = QString::number(entity.launchHeightMin_);
            obj["launch_height_max"] = QString::number(entity.launchHeightMax_);
            obj["launch_distance_min"] = QString::number(entity.launchDistanceMin_);
            obj["launch_distance_max"] = QString::number(entity.launchDistanceMax_);
            obj["launch_angle"] = QString::number(entity.launchAngle_);
            obj["launch_method"] = QString::fromStdString(entity.launchWay_);
            obj["approve_attack_target_type"] = QString::fromStdString(entity.approveAttackTargetType_);
            obj["killing_dose"] = QString::number(entity.killingDose_);
            obj["killing_method"] = QString::fromStdString(entity.killingMethod_);
            obj["killing_depth"] = QString::number(entity.killingDepth_);
            obj["killing_range_min"] = QString::number(entity.killingRangeMin_);
            obj["killing_range_max"] = QString::number(entity.killingRangeMax_);
            // 使用 QDateTime 转换 std::time_t 到 QString
            obj["image_url"] = QString::fromStdString(entity.ammoImgUrl_);
            obj["image_name"] = QString::fromStdString(entity.ammoName_);
            QDateTime dateTime;
            dateTime = entity.recordCreationTime_;
            qDebug() <<"recordcreation_time"<< entity.recordCreationTime_;
            obj["recordcreation_time"] = entity.recordCreationTime_.toString(Qt::ISODate);


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

QJsonObject AmmoDao::selectSomeAmmoDate(const QJSValue &selectedData)
{
    QJsonObject object;
    return object;
}

bool AmmoDao::updateAmmoDate(const QJSValue &selectedData)
{
    return true;
}

bool AmmoDao::deleteAmmoDate(const QJSValue &selectedData)
{
    return true;
}

bool AmmoDao::insertAmmoDate(const QJSValue &selectedData)
{
    return true;
}
