#ifndef AMMUNITIONENTITY_H
#define AMMUNITIONENTITY_H
//弹药建立实体类对应建表
#include <string>
#include <ctime>
//#include <QDateTime>
#include <odb/core.hxx> // ODB核心头文件

#pragma once
#pragma db object schema("uav_type_man") table("ammunition_data") // 指定表名
class AmmunitionEntity
{
public:
    // 构造函数
    AmmunitionEntity() = default;

    // Getter和Setter方法（示例，需根据业务逻辑补充完整）
    unsigned long getId() const { return id_; }
    void setId(long id) { id_ = id; }
    //int age() const { return age_; }
    const std::string&  getAmmunitionName_() const { return ammunitionName_; }
    void setAmmunitionName_(const std::string& type) { ammunitionName_ = type; }
private:
    friend class odb::access; // 允许ODB访问私有成员

/******************** 基础字段 ********************/
#pragma db id auto column("id")                    // 自增主键
    long id_;

#pragma db not_null column("ammunition_type")             // 弹药类型
    std::string ammunitionType_;

#pragma db column("ammunition_name")                      // 弹药名称
    std::string ammunitionName_;

#pragma db not_null column("ammunition_id")                        // 弹药编号
    std::string ammunitionId_;


/******************** 尺寸参数 ********************/
#pragma db column("length")                        // 弹药长度(m)
    float ammunitionLength_;

#pragma db column("width")                         // 弹药直径(m)
    float ammunitionWidth_;

#pragma db column("weight")                        // 弹药重量(m)
    float ammunitionWeight_;

#pragma db column("guidance_type")                  // 制导类型
    std::string guidanceType_;


/******************** 飞行性能 ********************/
#pragma db column("placement_height_min")             // 投放高度范围最小值(m)
    float placementHeightMin_;

#pragma db column("placement_height_max")             // 投放高度范围最大值(m)
    float placementHeightMax_;

#pragma db column("placement_distance_min")              // 投放距离范围最小值(Km)
    float placementDistanceMin_;

#pragma db column("placement_distance_max")              // 投放距离范围最大值(Km)
    float placementDistanceMax_;

#pragma db column("projection_angle")           // 投放角度(°)
    float projectionAngle_;

#pragma db column("delivery_method")           // 投放方式
    float deliveryMethod_;

#pragma db column("attack_target_type")               // 可打击目标类型
    float attackTargetType_;

#pragma db column("lethal_dose")               // 杀伤药量
    float lethalDose_;



#pragma db column("killing_method")              // 杀伤方式
    float killingMethod_;

#pragma db column("damage_depth")              // 杀伤深度(m)
    float damageDepth_;


/******************** 机动性能 ********************/
#pragma db column("killing_range_min")               // 杀伤范围最小值(m)
    float killingRangeMin_;

#pragma db column("killing_range_max")               // 杀伤范围最大值(m)
    float killingRangeMax_;


/******************** 系统记录 ********************/
    // 将time_t映射为TIMESTAMP类型
#pragma db column("create_time")// type("TIMESTAMP") null                  // 创建时间
    std::string ammunitionCreatModelTime_;//QDateTime ammunitionCreatModelTime_;

#pragma db column("image_url")                     // 模型图片路径
    std::string uavImgUrl_;
#pragma db column("image_name")                 // 图片名称
    float imageName_;
};
#endif // AMMUNITIONENTITY_H
