#ifndef UAVMODELDATATOJSON_H
#define UAVMODELDATATOJSON_H
#include "string"
#include "json.hpp"
namespace models {
struct uavModelData
{
/******************** 基础字段 ********************/
                  // 自增主键
    long id;

// 无人机类型
    std::string uavType;

// 无人机名称
    std::string uavName;

// 无人机编号
    std::string uavId;


/******************** 尺寸参数 ********************/
// 机长(m)
    float uavLength;

// 翼展(m)
    float uavWidth;

// 机高(m)
    float uavHeight;

// 隐身能力
    std::string uavInvisibility;


/******************** 飞行性能 ********************/
// 飞行高度范围最小值(m)
    float uavFlightHeightRangeMin;

// 飞行高度范围最大值(m)
    float uavFlightHeightRangeMax;

// 飞行速度范围最小值(m/s)
    float uavFlightSpeedRangeMin;

// 飞行速度范围最大值(m/s)
    float uavFlightSpeedRangeMax;

// 航程范围最小值(km)
    float uavFlightDistanceRangeMin;

// 航程范围最大值(km)
    float uavFlightDistanceRangeMax;

// 航时范围最小值(h)
    float uavFlightTimeRangeMin;

// 航时范围最大值(h)
    float uavFlightTimeRangeMax;


/******************** 起降参数 ********************/
// 起飞滑跑距离(m)
    float uavTakeoffDistance;

// 着陆滑跑距离(m)
    float uavLandDistance;


/******************** 机动性能 ********************/
// 转弯半径范围最小值(m)
    float uavTurningRadiusRangeMin;

// 转弯半径范围最大值(m)
    float uavTurningRadiusRangeMax;

// 作战半径(km)
    float uavOperatioanalRadius;


/******************** 载荷配置 ********************/
// 侦察载荷类型
    std::string uavInvestigationPayloadType;

// 投弹方式
    std::string uavBombingway;

// 载荷侦察范围最小值(km)
    float uavLoadReconnaissanceRangeMin;

// 载荷侦察范围最大值(km)
    float uavLoadReconnaissanceRangeMax;

// 载荷侦察精度(m)
    float uavLoadReconnaissanceAccuracy;


/******************** 回收与突防 ********************/
// 回收方式
    std::string uavRecoveryway;

// 低空突防速度(Km/h)
    float uavLowAltitudeBreakthroughSpeed;


/******************** 挂载能力 ********************/
// 挂点位置
    std::string uavHangingLoctionCapacity;

    // #pragma db column("hardpoint_num")                 // 挂点数量
    //     int uavHangingpoints;

    // #pragma db column("payload_capacity")              // 载弹量(kg)
    //     int uavPayloadcapacity;

// 操控方式
    std::string uavOperationWay;

// 攻击精度(CEP/m)
    float uavAttackaccuracy;


/******************** 雷达特征 ********************/
// 雷达反射面积(m²)
    float uavRadarCrossSection;


/******************** 重量与平衡 ********************/
// 重心前限(%MAC)
    float uavCenterOfGravityFrontLimit;

// 重心后限(%MAC)
    float uavCenterOfGravityAfterwardLimit;

// 最大起飞重量(kg)
    float uavMaximumTakeoffWeight;

// 空机重量(kg)
    float uavEmptyWeight;


/******************** 燃油与载重 ********************/
// 最大载油量(L)
    float uavMaximumFuelCapacity;

// 最大外挂重量(kg)
    float uavMaximumExternalWeight;


/******************** 高度性能 ********************/
// 最大飞行高度(m)
    float uavCeiling;

// 地面最大起动高度(m)
    float uavMaximumGroundStartingHeight;

// 空中最大起动高度(m)
    float uavMaximumAirStartingAltitude;


/******************** 续航性能 ********************/
// 最大续航时间(h)
    float uavMaximumEndurance;

// 最大飞行真空速(Km/h)
    float uavMaximumFlightVacuumSpeed;

// 最小飞行表速(Km/h)
    float uavMinimumFlightMeterSpeed;


/******************** 特殊场景性能 ********************/
// 海平面起飞滑跑距离(m)
    float sealLevelTakeoffAndRollDistance;

// 海平面着陆滑跑距离(m)
    float sealLevelLandingAndRollDistance;

// 侦察构型巡航高度(m)
    float cruiseAltitudeReconnaissanceConfiguration;

// 满外挂构型巡航高度(m)
    float cruiseAltitudeFullExternalConfiguration;


/******************** 系统记录 ********************/
// 创建时间
    std::time_t uavCreatModelTime;//QDateTime
// 模型图片名称
    std::string uavImgName;
// 模型图片路径
    std::string uavImgUrl;
NLOHMANN_DEFINE_TYPE_INTRUSIVE(uavModelData,
        uavType,uavName,uavId,uavLength,uavWidth,
        uavHeight,uavInvisibility,uavFlightHeightRangeMin,
        uavFlightHeightRangeMax,uavFlightSpeedRangeMin,
        uavFlightSpeedRangeMax,uavFlightDistanceRangeMin,
        uavFlightDistanceRangeMax,uavFlightTimeRangeMin,
        uavFlightTimeRangeMax,uavTakeoffDistance,
        uavLandDistance,uavTurningRadiusRangeMin,
        uavTurningRadiusRangeMax,
        uavOperatioanalRadius,uavInvestigationPayloadType,
        uavBombingway,uavLoadReconnaissanceRangeMin,
        uavLoadReconnaissanceRangeMax,uavLoadReconnaissanceAccuracy,
        uavRecoveryway,uavLowAltitudeBreakthroughSpeed,
        uavHangingLoctionCapacity,

        // #pragma db column("hardpoint_num")                 // 挂点数量
        //     int uavHangingpoints,

        // #pragma db column("payload_capacity")              // 载弹量(kg)
        //     int uavPayloadcapacity,

        uavOperationWay,uavAttackaccuracy,uavRadarCrossSection,
        uavCenterOfGravityFrontLimit,uavCenterOfGravityAfterwardLimit,
        uavMaximumTakeoffWeight,uavEmptyWeight,uavMaximumFuelCapacity,
        uavMaximumExternalWeight,uavCeiling,uavMaximumGroundStartingHeight,
        uavMaximumAirStartingAltitude,uavMaximumEndurance,
        uavMaximumFlightVacuumSpeed,uavMinimumFlightMeterSpeed,
        sealLevelTakeoffAndRollDistance,sealLevelLandingAndRollDistance,
        cruiseAltitudeReconnaissanceConfiguration,
        cruiseAltitudeFullExternalConfiguration,
        uavCreatModelTime,uavImgName,uavImgUrl)
};

}
#endif // UAVMODELDATATOJSON_H
