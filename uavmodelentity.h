#ifndef UAVMODELENTITY_H
#define UAVMODELENTITY_H

#include <string>
#include <ctime>
// ODB编译器需要QDateTime与数据库类型的转换规则
//#include <odb/qt/date-time/pgsql/qdate-time-traits.hxx>
#include <odb/core.hxx> // ODB核心头文件
#pragma once
#pragma db object schema("public") table("uav_models_data") // 指定表名
class UavModelEntity
{

    public:
    // 构造函数
    UavModelEntity() = default;

    // Getter和Setter方法（示例，需根据业务逻辑补充完整）
    // long getId() const { return id_; }
    // void setId(long id) { id_ = id; }

    // const std::string& getUavType() const { return uavType_; }
    // void setUavType(const std::string& type) { uavType_ = type; }

    // const std::string& getUavName() const { return uavName_; }
    // void setUavName(const std::string& type) { uavName_ = type; }

    // const std::string& getUavId() const { return uavId_; }
    // void setUavId(const std::string& type) { uavId_ = type; }

    // const float getUavFlightHeightRangeMin() const { return uavFlightHeightRangeMin_; }
    // void setUavFlightHeightRangeMin(const float type) { uavFlightHeightRangeMin_ = type; }

// private:
//         friend class odb::access; // 允许ODB访问私有成员

    /******************** 基础字段 ********************/
    #pragma db id auto column("id") //type(int8(64))                   // 自增主键
        long id_;

    #pragma db not_null column("uav_type")  type("varchar(32)")           // 无人机类型
        std::string uavType_;

    #pragma db column("uav_name")  type("varchar(32)")                    // 无人机名称
        std::string uavName_;

    #pragma db not_null column("uav_id") type("varchar(32)")                       // 无人机编号
        std::string uavId_;


    /******************** 尺寸参数 ********************/
    #pragma db column("length") //type(float)                       // 机长(m)
        float uavLength_;

    #pragma db column("width") //type(float4(24))                        // 翼展(m)
        float uavWidth_;

    #pragma db column("height")  //type(float4(24))                      // 机高(m)
        float uavHeight_;

    #pragma db column("have_invisibility")  type("varchar(10)")                // 隐身能力
        std::string uavInvisibility_;


    /******************** 飞行性能 ********************/
    #pragma db column("flight_height_min") //type(float4(24))            // 飞行高度范围最小值(m)
        float uavFlightHeightRangeMin_;

    #pragma db column("flight_height_max") //type(float4(24))            // 飞行高度范围最大值(m)
        float uavFlightHeightRangeMax_;

    #pragma db column("flight_speed_min") //type(float4(24))            // 飞行速度范围最小值(m/s)
        float uavFlightSpeedRangeMin_;

    #pragma db column("flight_speed_max") //type(float4(24))             // 飞行速度范围最大值(m/s)
        float uavFlightSpeedRangeMax_;

    #pragma db column("flight_distance_min")  //type(float4(24))         // 航程范围最小值(km)
        float uavFlightDistanceRangeMin_;

    #pragma db column("flight_distance_max") //type(float4(24))          // 航程范围最大值(km)
        float uavFlightDistanceRangeMax_;

    #pragma db column("flight_time_min") //type(float4(24))              // 航时范围最小值(h)
        float uavFlightTimeRangeMin_;

    #pragma db column("flight_time_max") //type(float4(24))              // 航时范围最大值(h)
        float uavFlightTimeRangeMax_;


    /******************** 起降参数 ********************/
    #pragma db column("takeoff_distance")  //type(float4(24))            // 起飞滑跑距离(m)
        float uavTakeoffDistance_;

    #pragma db column("landing_distance") //type(float4(24))             // 着陆滑跑距离(m)
        float uavLandDistance_;


    /******************** 机动性能 ********************/
    #pragma db column("turn_radius_min") //type(float4(24))              // 转弯半径范围最小值(m)
        float uavTurningRadiusRangeMin_;

    #pragma db column("turn_radius_max") //type(float4(24))              // 转弯半径范围最大值(m)
        float uavTurningRadiusRangeMax_;

    #pragma db column("combat_radius")  //type(float4(24))               // 作战半径(km)
        float uavOperatioanalRadius_;


    /******************** 载荷配置 ********************/
    #pragma db column("payload_type")  type("varchar(120)")                // 侦察载荷类型
        std::string uavInvestigationPayloadType_;

    #pragma db column("bomb_way")  type("varchar(120)")                 // 投弹方式
        std::string uavBombingway_;

    #pragma db column("recon_range_min")  //type("float4(24)")             // 载荷侦察范围最小值(km)
        float uavLoadReconnaissanceRangeMin_;

    #pragma db column("recon_range_max") //type(float4(24))              // 载荷侦察范围最大值(km)
        float uavLoadReconnaissanceRangeMax_;

    #pragma db column("recon_accuracy")  //type(float4(24))              // 载荷侦察精度(m)
        float uavLoadReconnaissanceAccuracy_;


    /******************** 回收与突防 ********************/
    #pragma db column("recovery_way")  //type(float4(24))               // 回收方式
        std::string uavRecoveryway_;

    #pragma db column("low_alt_speed")   //type(float4(24))              // 低空突防速度(Km/h)
        float uavLowAltitudeBreakthroughSpeed_;


    /******************** 挂载能力 ********************/
    #pragma db column("hanging_capacity")  type("varchar(200)")               // 挂点位置
        std::string uavHangingLoctionCapacity_;

    // #pragma db column("hardpoint_num")                 // 挂点数量
    //     int uavHangingpoints_;

    // #pragma db column("payload_capacity")              // 载弹量(kg)
    //     int uavPayloadcapacity_;

    #pragma db column("operation_way")  type("varchar(120)")            // 操控方式
        std::string uavOperationWay_;

    #pragma db column("attack_accuracy")   //type(float4(24))            // 攻击精度(CEP/m)
        float uavAttackaccuracy_;


    /******************** 雷达特征 ********************/
    #pragma db column("rcs")     //type(float4(24))                      // 雷达反射面积(m²)
        float uavRadarCrossSection_;


    /******************** 重量与平衡 ********************/
    #pragma db column("cg_front_limit")    //type(float4(24))            // 重心前限(%MAC)
        float uavCenterOfGravityFrontLimit_;

    #pragma db column("cg_rear_limit")  //type(float4(24))               // 重心后限(%MAC)
        float uavCenterOfGravityAfterwardLimit_;

    #pragma db column("max_takeoff_weight") //type(float4(24))           // 最大起飞重量(kg)
        float uavMaximumTakeoffWeight_;

    #pragma db column("empty_weight")  //type(float4(24))                // 空机重量(kg)
        float uavEmptyWeight_;


    /******************** 燃油与载重 ********************/
    #pragma db column("max_fuel") //type(float4(24))                     // 最大载油量(L)
        float uavMaximumFuelCapacity_;

    #pragma db column("max_external_weight") //type(float4(24))          // 最大外挂重量(kg)
        float uavMaximumExternalWeight_;


    /******************** 高度性能 ********************/
    #pragma db column("ceiling")  //type(float4(24))                     // 最大飞行高度(m)
        float uavCeiling_;

    #pragma db column("ground_start_alt")  //type(float4(24))            // 地面最大起动高度(m)
        float uavMaximumGroundStartingHeight_;

    #pragma db column("air_start_alt")  //type(float4(24))               // 空中最大起动高度(m)
        float uavMaximumAirStartingAltitude_;


    /******************** 续航性能 ********************/
    #pragma db column("endurance")   //type(float4(24))                  // 最大续航时间(h)
        float uavMaximumEndurance_;

    #pragma db column("max_vacuum_speed")   //type(float4(24))           // 最大飞行真空速(Km/h)
        float uavMaximumFlightVacuumSpeed_;

    #pragma db column("min_meter_speed")  //type(float4(24))             // 最小飞行表速(Km/h)
        float uavMinimumFlightMeterSpeed_;


    /******************** 特殊场景性能 ********************/
    #pragma db column("sea_takeoff_roll")  //type(float4(24))            // 海平面起飞滑跑距离(m)
        float sealLevelTakeoffAndRollDistance_;

    #pragma db column("sea_landing_roll")  //type(float4(24))            // 海平面着陆滑跑距离(m)
        float sealLevelLandingAndRollDistance_;

    #pragma db column("recon_cruise_alt") //type(float4(24))             // 侦察构型巡航高度(m)
        float cruiseAltitudeReconnaissanceConfiguration_;

    #pragma db column("full_external_cruise_alt") //type(float4(24))      // 满外挂构型巡航高度(m)
        float cruiseAltitudeFullExternalConfiguration_;


    /******************** 系统记录 ********************/
    #pragma db column("recordcreation_time")   type("timestamp")                // 创建时间
        std::time_t uavCreatModelTime_;//QDateTime
    #pragma db column("image_name") type("varchar(30)")                    // 模型图片名称
        std::string uavImgName_;
    #pragma db column("image_url") type("varchar(30)")                  // 模型图片路径
        std::string uavImgUrl_;
};
//QX_REGISTER_HPP_EXPORT_DLL(UavModelEntity,qx::trait::no_base_class_defined,0)
#endif // UAVMODELENTITY_H
