#ifndef RECONNAISSANCECOMMUNICATIONENTITY_H
#define RECONNAISSANCECOMMUNICATIONENTITY_H
#include <string>
#include <ctime>
//#include "json.hpp"
// ODB编译器需要QDateTime与数据库类型的转换规则
//#include <odb/qt/date-time/pgsql/qdate-time-traits.hxx>
#include <odb/core.hxx> // ODB核心头文件
#include <QtCore/QDateTime>
#ifndef ODB_COMPILER
#include "datetime-traits.hxx"
#endif
#include "odb/nullable.hxx"
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
    odb::nullable<float> frequencyMinimum_;

#pragma db column("frequency_maximum") type("real") // 频率(GHz)
    odb::nullable<float> frequencyMaximum_;

#pragma db column("first_reconnaissance_range") type("real") //      REAL ,--COMMENT '第一个侦察距离',
    odb::nullable<float> firstReconnaissanceRange_;

#pragma db column("first_reconnaissance_frequency_minimum") type("real") //  REAL  ,--COMMENT '第一个最小侦察频率',
    odb::nullable<float> firstReconnaissanceFrequencyMinimum_;

#pragma db column("first_reconnaissance_frequency_maximum") type("real") // REAL ,--COMMENT '第一个最大侦察频率',
    odb::nullable<float> firstReconnaissanceFrequencyMaximum_;

#pragma db column("first_reconnaissance_radiated_power") type("real") //  REAL ,--COMMENT '第一个侦察辐射功率',
    odb::nullable<float> firstReconnaissanceRadiatedPower_;


#pragma db column("second_reconnaissance_range") type("real") //REAL ,--COMMENT '第二个侦察距离',
    odb::nullable<float> secondReconnaissanceRange_;

#pragma db column("second_reconnaissance_frequency_minimum") type("real") //REAL  ,--COMMENT '第二个最小侦察频率',
    odb::nullable<float> secondReconnaissanceFrequencyMinimum_;

#pragma db column("second_reconnaissance_frequency_maximum") type("real") //REAL ,--COMMENT '第二个最大侦察频率',
    odb::nullable<float> secondReconnaissanceFrequencyMaximum_;
#pragma db column("second_reconnaissance_radiated_power") type("real") //REAL ,--COMMENT '第二个侦察辐射功率',
    odb::nullable<float> secondReconnaissanceRadiatedPower_;

#pragma db column("third_reconnaissance_range") type("real") //REAL ,--COMMENT '第三个侦察距离',
    odb::nullable<float> thirdReconnaissanceRange_;

#pragma db column("third_reconnaissance_frequency_minimum") type("real") //REAL  ,--COMMENT '第三个最小侦察频率',
    odb::nullable<float> thirdReconnaissanceFrequencyMinimum_;

#pragma db column("third_reconnaissance_frequency_maximum") type("real") //REAL ,--COMMENT '第三个最大侦察频率',
    odb::nullable<float> thirdReconnaissanceFrequencyMaximum_;
#pragma db column("third_reconnaissance_radiated_power") type("real") //REAL ,--COMMENT '第三个侦察辐射功率',
    odb::nullable<float> thirdReconnaissanceRadiatedPower_;
#pragma db column("fourth_reconnaissance_range") type("real") //REAL ,--COMMENT '第四个侦察距离',
    odb::nullable<float> fourthReconnaissanceRange_;
#pragma db column("fourth_reconnaissance_frequency_minimum") type("real") //REAL  ,--COMMENT '第四个最小侦察频率',
    odb::nullable<float> fourthReconnaissanceFrequencyMinimum_;
#pragma db column("fourth_reconnaissance_frequency_maximum") type("real") //REAL ,--COMMENT '第四个最大侦察频率',
    odb::nullable<float> fourthReconnaissanceFrequencyMaximum_;
#pragma db column("fourth_reconnaissance_radiated_power") type("real") //REAL ,--COMMENT '第四个侦察辐射功率',
    odb::nullable<float> fourthReconnaissanceRadiatedPower_;
#pragma db column("first_orientation_accuracy") type("real") //REAL ,--COMMENT '第一测向精度',
    odb::nullable<float> firstOrientationAccuracy_;
#pragma db column("first_orientation_frequency_minimum") type("real") //REAL ,--COMMENT '第一测向精度频率最小',
    odb::nullable<float> firstOrientationFrequencyMinimum_;
#pragma db column("first_orientation_frequency_maximum") type("real") //REAL ,--COMMENT '第一测向精度频率最大',
    odb::nullable<float> firstOrientationFrequencyMaximum_;
#pragma db column("second_orientation_accuracy") type("real") //REAL ,--COMMENT '第二测向精度',
    odb::nullable<float> secondOrientationAccuracy_;
#pragma db column("second_orientation_frequency_minimum") type("real") //REAL ,--COMMENT '第二测向精度频率最小',
    odb::nullable<float> secondOrientationFrequencyMinimum_;
#pragma db column("second_orientation_frequency_maximum") type("real") //REAL ,--COMMENT '第二测向精度频率最大',
    odb::nullable<float> secondOrientationFrequencyMaximum_;
#pragma db column("third_orientation_accuracy") type("real") //REAL ,--COMMENT '第三测向精度',
    odb::nullable<float> thirdOrientationAccuracy_;
#pragma db column("third_orientation_frequency_minimum") type("real") //REAL ,--COMMENT '第三测向精度频率最小',
    odb::nullable<float> thirdOrientationFrequencyMinimum_;
#pragma db column("third_orientation_frequency_maximum") type("real") //REAL ,--COMMENT '第三测向精度频率最大',
    odb::nullable<float> thirdOrientationFrequencyMaximum_;
#pragma db column("fourth_orientation_accuracy") type("real") //REAL ,--COMMENT '第四测向精度',
    odb::nullable<float> fourthOrientationAccuracy_;
#pragma db column("fourth_orientation_frequency_minimum") type("real") //REAL ,--COMMENT '第四测向精度频率最小',
    odb::nullable<float> fourthOrientationFrequencyMinimum_;
#pragma db column("fourth_orientation_frequency_maximum") type("real") //REAL ,--COMMENT '第四测向精度频率最大',
    odb::nullable<float> fourthOrientationFrequencyMaximum_;
#pragma db column("first_positioning_accuracy") type("real") //REAL ,--COMMENT '第一定位精度',
    odb::nullable<float> firstPositioningAccuracy_;
#pragma db column("first_positioning_frequency_minimum") type("real") //REAL,--COMMENT '第一定位精度频率最小值',
    odb::nullable<float> firstPositioningFrequencyMinimum_;
#pragma db column("first_positioning_frequency_maximum") type("real") //REAL ,--COMMENT '第一定位精度频率最大值',
    odb::nullable<float> firstPositioningFrequencyMaximum_;
#pragma db column("second_positioning_accuracy") type("real") //REAL ,--COMMENT '第二定位精度',
    odb::nullable<float> secondPositioningAccuracy_;
#pragma db column("second_positioning_frequency_minimum") type("real") //REAL,--COMMENT '第二定位精度频率最小值',
    odb::nullable<float> secondPositioningFrequencyMinimum_;
#pragma db column("second_positioning_frequency_maximum") type("real") //REAL ,--COMMENT '第二定位精度频率最大值',
    odb::nullable<float> secondPositioningFrequencyMaximum_;
#pragma db column("third_positioning_accuracy") type("real") //REAL ,--COMMENT '第三定位精度',
    odb::nullable<float> thirdPositioningAccuracy_;
#pragma db column("third_positioning_frequency_minimum") type("real") //REAL,--COMMENT '第三定位精度频率最小值',
    odb::nullable<float> thirdPositioningFrequencyMinimum_;
#pragma db column("third_positioning_frequency_maximum") type("real") //REAL ,--COMMENT '第三定位精度频率最大值',
    odb::nullable<float> thirdPositioningFrequencyMaximum_;
#pragma db column("fourth_positioning_accuracy") type("real") //REAL ,--COMMENT '第四定位精度',
    odb::nullable<float> fourthPositioningAccuracy_;
#pragma db column("fourth_positioning_frequency_minimum") type("real") //REAL,--COMMENT ''第四定位精度频率最小值',
    odb::nullable<float> fourthPositioningFrequencyMinimum_;
#pragma db column("fourth_positioning_frequency_maximum") type("real") //REAL ,--COMMENT '第四定位精度频率最大值',
    odb::nullable<float> fourthPositioningFrequencyMaximum_;


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
