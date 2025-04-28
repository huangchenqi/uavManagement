#ifndef INTERFERENCEPODENTITY_H
#define INTERFERENCEPODENTITY_H
#include <string>
#include <ctime>
//#include "json.hpp"
// ODB编译器需要QDateTime与数据库类型的转换规则
//#include <odb/qt/date-time/pgsql/qdate-time-traits.hxx>
#include <odb/core.hxx> // ODB核心头文件
#include <QtCore/QDateTime>
#include "datetime-traits.hxx"
#pragma once
#pragma db object schema("uav_type_man") table("interference_pod") // 指定表名
class InterferencePodEntity
{

    public:
    // 构造函数
    InterferencePodEntity() = default;

    /******************** 基础字段 ********************/
    #pragma db id auto column("id") //type(int8(64))                   // 自增主键
        long id_;

    #pragma db not_null column("interference_pod_name") type("varchar(100)") // 干扰吊舱名称
    std::string interferencePodName_;

    #pragma db column("interference_pod_type") type("varchar(50)") // 干扰吊舱类型
    std::string interferencePodType_;

    #pragma db column("interference_pod_id") type("varchar(50)") // 干扰吊舱型号
    std::string interferencePodId_;

    #pragma db not_null column("used_uav_models") type("varchar(200)") // 使用机型
    std::string usedUavModels_;

    #pragma db column("description") type("text") // 用途描述
    std::string description_;

    /******************** 基础物理特性 ********************/
    #pragma db column("main_length") type("real") // 主舱长度(m)
    float mainLength_;
     #pragma db column("interference_length") type("real") // 吊舱长度(m)
     float interferenceLength_;
    #pragma db column("mass") type("real") // 单吊舱质量(kg)
    float mass_;

    #pragma db column("front_cover_length") type("real") // 前罩长(m)
    float frontCoverLength_;

    #pragma db column("rear_cover_length") type("real") // 后罩长(m)
    float rearCoverLength_;

    #pragma db column("main_cabin_section") type("real") // 主舱截面(m)
    float mainCabinSection_;

    #pragma db column("maximum_weight_pod_fully_loaded") type("real") // 单吊舱满载最大重量(kg)
    float maximumWeightPodFullyLoaded_;

    #pragma db column("interference_band") type("varchar(100)") // 干扰波段  由于是多选设置成字符串
    std::string interferenceBand_;

    #pragma db column("effective_reflection_area") type("varchar(100)") // 有效反射面积(m) 由于是多选设置成字符串
    std::string effectiveReflectionArea_;

    #pragma db column("delivery_control_way") type("varchar(100)") // 投放控制方式 由于是多选设置成字符串
    std::string deliveryControlWay_;

    #pragma db column("delivery_speed") type("varchar(100)") // 投放速度(m/s) 由于是多选设置成字符串
    std::string deliverySpeed_;

    #pragma db column("loading_capacity") type("real") // 装载容量(kg)
    float loadingCapacity_;

    #pragma db column("interference_intensity") type("varchar(100)") // 干扰强度
    std::string interferenceIntensity_;

    #pragma db column("image_name") type("BYTEA")//type("varchar(50)") // 图片名称
    std::vector<char> imageName_; //std::string

    #pragma db column("image_url") type("varchar(50)") // 图片路径
    std::string imageUrl_;

    /******************** 系统记录 ********************/
    #pragma db column("record_creation_time") type("timestamp(0)") options("DEFAULT CURRENT_TIMESTAMP") // 记录创建时间
    QDateTime recordCreationTime_{QDateTime::currentDateTime()};

    #pragma db column("use_status") type("bool") // 使用状态
    bool useStatus_;

};
#endif // INTERFERENCEPODENTITY_H
