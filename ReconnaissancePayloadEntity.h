#ifndef RECONNAISSANCEPAYLOADENTITY_H
#define RECONNAISSANCEPAYLOADENTITY_H
//侦察载荷建立实体类对应建表
#include <string>
#include <ctime>
// ODB编译器需要QDateTime与数据库类型的转换规则
//#include <odb/qt/date-time/pgsql/qdate-time-traits.hxx>
#include <odb/core.hxx> // ODB核心头文件
#pragma once
#pragma db object schema("uav_type_man") table("reconnaissance_payload") // 指定表名
class ReconnaissancePayloadEntity
{

public:
    // 构造函数
    ReconnaissancePayloadEntity() = default;

    // Getter和Setter方法（示例，需根据业务逻辑补充完整）
    long getId() const { return id_; }
    void setId(long id) { id_ = id; }

    const std::string& getReconnaissancePayload() const { return reconnaissancePayloadName_; }
    void setReconnaissancePayload(const std::string& type) { reconnaissancePayloadName_ = type; }
private:
    friend class odb::access; // 允许ODB访问私有成员

/******************** 基础字段 ********************/
#pragma db id auto column("id")                    // 自增主键
    long id_;

// #pragma db  column("reconnaissancepayload_type")             // 无人机类型
//     QString reconnaissancePayloadType_;

#pragma db column("reconnaissancepayload_name")                      // 载荷类型名称
    std::string reconnaissancePayloadName_;

#pragma db not_null column("reconnaissancepayload_id")                        // 载荷类型编号
    std::string reconnaissancePayloadId_;


/******************** 尺寸参数 ********************/
#pragma db column("length")                        // 机长(m)
    float reconnaissancePayloadLength_;

#pragma db column("width")                         // 翼展(m)
    float reconnaissancePayloadWidth_;

#pragma db column("height")                        // 机高(m)
    float reconnaissancePayloadHeight_;

/******************** 载荷性能 ********************/
#pragma db column("reconnaissance_accuracy")                  // 侦察精度
    std::string reconnaissanceAccuracy_;

#pragma db column("data_returndeadline")             // 数据回传时限(s)
    float dataReturnDeadline_;
#pragma db column("working_height_minimum")             // 工作高度范围最小值(m)
    float  workingHeightMinimum_;
#pragma db column("working_height_maximum")             // 工作高度范围最大值(m)
    float  workingHeightMaximum_;

#pragma db column("working_speed_minimum")              // 工作速度最小值(m/s)
    float workingSpeedMinimum_;

#pragma db column("working_speed_maximum")              // 工作速度最大值(m/s)
    float workingSpeedMaximum_;

#pragma db column("working_pitch_minimum")           // 工作俯仰最小值(°)
    float workingPitchMinimum_;

#pragma db column("working_pitch_maximum")           // 工作俯仰最大值(°)
    float workingPitchMaximum_;

// #pragma db column("flight_time_min")               // 航时范围最小值(h)
//     float uavFlightTimeRangeMin_;

// #pragma db column("flight_time_max")               // 航时范围最大值(h)
//     float uavFlightTimeRangeMax_;


/******************** 起降参数 ********************/
#pragma db column("image_name")              // 图片名称
    float imageName_;

#pragma db column("loadimage_path")              // 载荷图片路径
    float loadImagePath_;

#pragma db column("recordcreation_time")              // 记录创建时间
    std::string recordCreationTime_;//QDateTime
};
#endif // RECONNAISSANCEPAYLOADENTITY_H
