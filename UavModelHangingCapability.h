#ifndef UAVMODELHANGINGCAPABILITY_H
#define UAVMODELHANGINGCAPABILITY_H
#include <string>
#
// ODB编译器需要QDateTime与数据库类型的转换规则
//#include <odb/qt/date-time/pgsql/qdate-time-traits.hxx>
#include <odb/core.hxx> // ODB核心头文件
#pragma once
#pragma db object schema("public") table("uav_models_hanging_capability") // 指定表名
class UavModelHangingCapability   //记录无人机挂载位置以及挂载点数量
{

public:
    // 构造函数
    UavModelHangingCapability() = default;

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
#pragma db id auto column("id")                    // 自增主键
    long id_;

#pragma db not_null column("uav_type")             // 无人机类型
    std::string uavType_;

#pragma db column("uav_name")                      // 无人机名称
    std::string uavName_;

#pragma db not_null column("uav_id")                        // 无人机编号
    std::string uavId_;
/******************** 挂载能力 ********************/
#pragma db column("hardpoint_loc")                 // 挂点位置
    std::string uavHangingLoction_;

#pragma db column("hardpoint_num")                 // 挂点数量
    int uavHangingpoints_;

#pragma db column("payload_capacity")              // 载弹量(kg)
    int uavPayloadcapacity_;
#pragma db column("opreation_method")              // 操控方式
    std::string uavOperationMethod_;
#pragma db column("bomb_method")                   // 投弹方式
    std::string uavBombingmethod_;
};
#endif // UAVMODELHANGINGCAPABILITY_H
