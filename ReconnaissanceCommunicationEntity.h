#ifndef RECONNAISSANCECOMMUNICATIONENTITY_H
#define RECONNAISSANCECOMMUNICATIONENTITY_H
#include <string>
#include <ctime>
//#include "json.hpp"
// ODB编译器需要QDateTime与数据库类型的转换规则
//#include <odb/qt/date-time/pgsql/qdate-time-traits.hxx>
#include <odb/core.hxx> // ODB核心头文件
#include <QtCore/QDateTime>
#include "datetime-traits.hxx"
#pragma once
#pragma db object schema("uav_type_man") table("communication_reconnaissance") // 指定表名
class ReconnaissanceCommunicationEntity
{

public:
    // 构造函数
    ReconnaissanceCommunicationEntity() = default;

/******************** 基础字段 ********************/
#pragma db id auto column("id") //type(int8(64))                   // 自增主键
    long id_;

#pragma db not_null column("name") type("varchar(100)") // 侦察通信名称
    std::string reconnaissanceName_;

// #pragma db column("interference_pod_type") type("varchar(50)") // 干扰吊舱类型
//     std::string interferencePodType_;

// #pragma db column("interference_pod_id") type("varchar(50)") // 干扰吊舱型号
//     std::string interferencePodId_;

#pragma db not_null column("used_uav_models") type("varchar(200)") // 使用机型
    std::string usedUavModels_;

#pragma db column("description") type("text") // 用途描述
    std::string description_;

/******************** 基础物理特性 ********************/
#pragma db column("frequency_minimum") type("real") // 频率(GHz)
    float frequencyMinimum_;

#pragma db column("frequency_maximum") type("real") // 频率(GHz)
    float frequencyMaximum_;

#pragma db column("first_reconnaissance_range") type("real") //      REAL ,--COMMENT '第一个侦察距离',
    float firstReconnaissanceRange_;

#pragma db column("first_reconnaissance_frequency_minimum") type("real") //  REAL  ,--COMMENT '第一个最小侦察频率',
    float firstReconnaissanceFrequencyMinimum_;

#pragma db column("first_reconnaissance_frequency_maximum") type("real") // REAL ,--COMMENT '第一个最大侦察频率',
    float firstReconnaissanceFrequencyMaximum_;

#pragma db column("first_reconnaissance_radiated_power") type("real") //  REAL ,--COMMENT '第一个侦察辐射功率',
    float firstReconnaissanceRadiatedPower_;


#pragma db column("second_reconnaissance_range") type("real") //REAL ,--COMMENT '第二个侦察距离',
    float secondReconnaissanceRange_;

#pragma db column("second_reconnaissance_frequency_minimum") type("real") //REAL  ,--COMMENT '第二个最小侦察频率',
    float secondReconnaissanceFrequencyMinimum_;

#pragma db column("second_reconnaissance_frequency_maximum") type("real") //REAL ,--COMMENT '第二个最大侦察频率',
    float secondReconnaissanceFrequencyMaximum_;
#pragma db column("second_reconnaissance_radiated_power") type("real") //REAL ,--COMMENT '第二个侦察辐射功率',
    float secondReconnaissanceRadiatedPower_;

#pragma db column("third_reconnaissance_range") type("real") //REAL ,--COMMENT '第三个侦察距离',
    float thirdReconnaissanceRange_;

#pragma db column("third_reconnaissance_frequency_minimum") type("real") //REAL  ,--COMMENT '第三个最小侦察频率',
    float thirdReconnaissanceFrequencyMinimum_;

#pragma db column("third_reconnaissance_frequency_maximum") type("real") //REAL ,--COMMENT '第三个最大侦察频率',
    float thirdReconnaissanceFrequencyMaximum_;
#pragma db column("third_reconnaissance_radiated_power") type("real") //REAL ,--COMMENT '第三个侦察辐射功率',
    float thirdReconnaissanceRadiatedPower_;
#pragma db column("fourth_reconnaissance_range") type("real") //REAL ,--COMMENT '第四个侦察距离',
    float fourthReconnaissanceRange_;
#pragma db column("fourth_reconnaissance_frequency_minimum") type("real") //REAL  ,--COMMENT '第四个最小侦察频率',
    float fourthReconnaissanceFrequencyMinimum_;
#pragma db column("fourth_reconnaissance_frequency_maximum") type("real") //REAL ,--COMMENT '第四个最大侦察频率',
    float fourthReconnaissanceFrequencyMaximum_;
#pragma db column("fourth_reconnaissance_radiated_power") type("real") //REAL ,--COMMENT '第四个侦察辐射功率',
    float fourthReconnaissanceRadiatedPower_;
#pragma db column("first_orientation_accuracy") type("real") //REAL ,--COMMENT '第一测向精度',
    float firstOrientationAccuracy_;
#pragma db column("first_orientation_frequency_minimum") type("real") //REAL ,--COMMENT '第一测向精度频率最小',
    float firstOrientationFrequencyMinimum_;
#pragma db column("first_orientation_frequency_maximum") type("real") //REAL ,--COMMENT '第一测向精度频率最大',
    float firstOrientationFrequencyMaximum_;
#pragma db column("second_orientation_accuracy") type("real") //REAL ,--COMMENT '第二测向精度',
    float secondOrientationAccuracy_;
#pragma db column("second_orientation_frequency_minimum") type("real") //REAL ,--COMMENT '第二测向精度频率最小',
    float secondOrientationFrequencyMinimum_;
#pragma db column("second_orientation_frequency_maximum") type("real") //REAL ,--COMMENT '第二测向精度频率最大',
    float secondOrientationFrequencyMaximum_;
#pragma db column("third_orientation_accuracy") type("real") //REAL ,--COMMENT '第三测向精度',
    float thirdOrientationAccuracy_;
#pragma db column("third_orientation_frequency_minimum") type("real") //REAL ,--COMMENT '第三测向精度频率最小',
    float thirdOrientationFrequencyMinimum_;
#pragma db column("third_orientation_frequency_maximum") type("real") //REAL ,--COMMENT '第三测向精度频率最大',
    float thirdOrientationFrequencyMaximum_;
#pragma db column("fourth_orientation_accuracy") type("real") //REAL ,--COMMENT '第四测向精度',
    float fourthOrientationAccuracy_;
#pragma db column("fourth_orientation_frequency_minimum") type("real") //REAL ,--COMMENT '第四测向精度频率最小',
    float fourthOrientationFrequencyMinimum_;
#pragma db column("fourth_orientation_frequency_maximum") type("real") //REAL ,--COMMENT '第四测向精度频率最大',
    float fourthOrientationFrequencyMaximum_;
#pragma db column("first_positioning_accuracy") type("real") //REAL ,--COMMENT '第一定位精度',
    float firstPositioningAccuracy_;
#pragma db column("first_positioning_frequency_minimum") type("real") //REAL,--COMMENT '第一定位精度频率最小值',
    float firstPositioningFrequencyMinimum_;
#pragma db column("first_positioning_frequency_maximum") type("real") //REAL ,--COMMENT '第一定位精度频率最大值',
    float firstPositioningFrequencyMaximum_;
#pragma db column("second_positioning_accuracy") type("real") //REAL ,--COMMENT '第二定位精度',
    float secondPositioningAccuracy_;
#pragma db column("second_positioning_frequency_minimum") type("real") //REAL,--COMMENT '第二定位精度频率最小值',
    float secondPositioningFrequencyMinimum_;
#pragma db column("second_positioning_frequency_maximum") type("real") //REAL ,--COMMENT '第二定位精度频率最大值',
    float secondPositioningFrequencyMaximum_;
#pragma db column("third_positioning_accuracy") type("real") //REAL ,--COMMENT '第三定位精度',
    float thirdPositioningAccuracy_;
#pragma db column("third_positioning_frequency_minimum") type("real") //REAL,--COMMENT '第三定位精度频率最小值',
    float thirdPositioningFrequencyMinimum_;
#pragma db column("third_positioning_frequency_maximum") type("real") //REAL ,--COMMENT '第三定位精度频率最大值',
    float thirdPositioningFrequencyMaximum_;
#pragma db column("fourth_positioning_accuracy") type("real") //REAL ,--COMMENT '第四定位精度',
    float fourthPositioningAccuracy_;
#pragma db column("fourth_positioning_frequency_minimum") type("real") //REAL,--COMMENT ''第四定位精度频率最小值',
    float fourthPositioningFrequencyMinimum_;
#pragma db column("fourth_positioning_frequency_maximum") type("real") //REAL ,--COMMENT '第四定位精度频率最大值',
    float fourthPositioningFrequencyMaximum_;


#pragma db column("image_name") type("BYTEA")//type("varchar(50)") // 图片名称
    std::vector<char> imageName_; //std::string

#pragma db column("image_url") type("varchar(50)") // 图片路径
    std::string imageUrl_;

/******************** 系统记录 ********************/
#pragma db column("record_creation_time") type("timestamp(0)") options("DEFAULT CURRENT_TIMESTAMP") // 记录创建时间
    QDateTime recordCreationTime_{QDateTime::currentDateTime()};

#pragma db column("status") type("bool") // 使用状态
    bool useStatus_;
};
#endif // RECONNAISSANCECOMMUNICATIONENTITY_H
