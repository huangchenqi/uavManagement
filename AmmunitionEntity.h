#ifndef AMMUNITIONENTITY_H
#define AMMUNITIONENTITY_H
//弹药建立实体类对应建表
#include <string>
#include <ctime>
#include <QtCore/QDateTime>
#include "datetime-traits.hxx"
#include <odb/core.hxx> // ODB核心头文件

#pragma once
#pragma db object schema("uav_type_man") table("ammo_parameters") // 指定表名
class AmmunitionEntity
{
public:
    // 构造函数
    AmmunitionEntity() = default;

//     // Getter和Setter方法（示例，需根据业务逻辑补充完整）
//     unsigned long getId() const { return id_; }
//     void setId(long id) { id_ = id; }
//     //int age() const { return age_; }
//     const std::string&  getAmmunitionName_() const { return ammunitionName_; }
//     void setAmmunitionName_(const std::string& type) { ammunitionName_ = type; }
// private:
//     friend class odb::access; // 允许ODB访问私有成员

/******************** 基础字段 ********************/
#pragma db id auto column("id")                    // 自增主键
    long id_;

#pragma db not_null column("ammo_type")             // 弹药类型
    std::string ammoType_;

#pragma db column("ammo_name")                      // 弹药名称
    std::string ammoName_;

#pragma db not_null column("ammo_id")                        // 弹药编号
    std::string ammoId_;

#pragma db not_null column("ammo_to_uavmodel")                        // 弹药编号
    std::string ammoToUavModel_;

/******************** 尺寸参数 ********************/
#pragma db column("length")                        // 弹药长度(m)
    float ammoLength_;

#pragma db column("width")                         // 弹药直径(m)
    float ammoWidth_;

#pragma db column("weight")                        // 弹药重量(m)
    float ammoWeight_;

#pragma db column("guidance_type")                  // 制导类型
    std::string guidanceType_;


/******************** 飞行性能 ********************/
#pragma db column("launch_height_min")             // 投放高度范围最小值(m)
    float launchHeightMin_;

#pragma db column("launch_height_max")             // 投放高度范围最大值(m)
    float launchHeightMax_;

#pragma db column("launch_distance_min")              // 投放距离范围最小值(Km)
    float launchDistanceMin_;

#pragma db column("launch_distance_max")              // 投放距离范围最大值(Km)
    float launchDistanceMax_;

#pragma db column("launch_angle")           // 投放角度(°)
    float launchAngle_;

#pragma db column("launch_method")           // 投放方式
    std::string launchWay_;

#pragma db column("approve_attack_target_type")               // 可打击目标类型
    std::string approveAttackTargetType_;

#pragma db column("killing_dose")               // 杀伤药量
    float killingDose_;



#pragma db column("killing_method")              // 杀伤方式
    std::string killingMethod_;

#pragma db column("killing_depth")              // 杀伤深度(m)
    float killingDepth_;


/******************** 机动性能 ********************/
#pragma db column("killing_range_min")               // 杀伤范围最小值(m)
    float killingRangeMin_;

#pragma db column("killing_range_max")               // 杀伤范围最大值(m)
    float killingRangeMax_;


/******************** 系统记录 ********************/
    // 将time_t映射为TIMESTAMP类型
#pragma db column("recordcreation_time") type("timestamp(0)") options("DEFAULT CURRENT_TIMESTAMP")               // 创建时间
    QDateTime recordCreationTime_{QDateTime::currentDateTime()};
#pragma db column("image_url")                     // 模型图片路径
    std::string ammoImgUrl_;
#pragma db column("image_name")                 // 图片名称
    float ammoImageName_;
};
#endif // AMMUNITIONENTITY_H
