#ifndef MOUNTINGSCHEMEMOUNTINGCONFIGURATION_H
#define MOUNTINGSCHEMEMOUNTINGCONFIGURATION_H
//挂载方案挂载配置建立实体类对应建表
#include <string>
#include <vector>
#include <ctime>
#include <odb/core.hxx> // ODB核心头文件
#include <QtCore/QDateTime>
#ifndef ODB_COMPILER
#include "datetime-traits.hxx"
#endif

#pragma once

#pragma db object schema("uav_type_man") table("uav_mount_scheme") // 指定表名
class UavMountSchemeEntity
{
public:
    // 构造函数
    UavMountSchemeEntity() = default;

    /******************** 基础字段 ********************/
    #pragma db id auto column("id") // 自增主键
    long id_;

    #pragma db not_null column("mount_scheme_name") type("varchar(100)") // 挂载方案名称
    std::string mountSchemeName_;

    #pragma db column("uav_name") type("varchar(100)") // 无人机名称
    std::string uavName_;

    /******************** 基础物理特性 ********************/
    #pragma db column("max_takeoff_weight") type("real") // 无人机最大起飞重量(kg)
    float maxTakeoffWeight_;

    #pragma db column("empty_weight") type("real") // 无人机空机重量(kg)
    float emptyWeight_;

    /******************** 挂点信息 ********************/
    #pragma db column("one_hanging_point") type("varchar(100)") // 1号挂点编号
    std::string oneHangingPoint_;

    #pragma db column("one_location") type("varchar(100)") // 1号挂点位置
    std::string oneLocation_;

    #pragma db column("one_ammo_name") type("varchar(100)") // 1号挂载弹药名称
    std::string oneAmmoName_;

    #pragma db column("two_hanging_point") type("varchar(100)") // 2号挂点编号
    std::string twoHangingPoint_;

    #pragma db column("two_location") type("varchar(100)") // 2号挂点位置
    std::string twoLocation_;

    #pragma db column("two_ammo_name") type("varchar(100)") // 2号挂载弹药名称
    std::string twoAmmoName_;

    #pragma db column("three_hanging_point") type("varchar(100)") // 3号挂点编号
    std::string threeHangingPoint_;

    #pragma db column("three_location") type("varchar(100)") // 3号挂点位置
    std::string threeLocation_;

    #pragma db column("three_ammo_name") type("varchar(100)") // 3号挂载弹药名称
    std::string threeAmmoName_;

    #pragma db column("four_hanging_point") type("varchar(100)") // 4号挂点编号
    std::string fourHangingPoint_;

    #pragma db column("four_location") type("varchar(100)") // 4号挂点位置
    std::string fourLocation_;

    #pragma db column("four_ammo_name") type("varchar(100)") // 4号挂载弹药名称
    std::string fourAmmoName_;

    #pragma db column("five_hanging_point") type("varchar(100)") // 5号挂点编号
    std::string fiveHangingPoint_;

    #pragma db column("five_location") type("varchar(100)") // 5号挂点位置
    std::string fiveLocation_;

    #pragma db column("five_ammo_name") type("varchar(100)") // 5号挂载弹药名称
    std::string fiveAmmoName_;

    #pragma db column("six_hanging_point") type("varchar(100)") // 6号挂点编号
    std::string sixHangingPoint_;

    #pragma db column("six_location") type("varchar(100)") // 6号挂点位置
    std::string sixLocation_;

    #pragma db column("six_ammo_name") type("varchar(100)") // 6号挂载弹药名称
    std::string sixAmmoName_;

    #pragma db column("seven_hanging_point") type("varchar(100)") // 7号挂点编号
    std::string sevenHangingPoint_;

    #pragma db column("seven_location") type("varchar(100)") // 7号挂点位置
    std::string sevenLocation_;

    #pragma db column("seven_ammo_name") type("varchar(100)") // 7号挂载弹药名称
    std::string sevenAmmoName_;

    #pragma db column("eight_hanging_point") type("varchar(100)") // 8号挂点编号
    std::string eightHangingPoint_;

    #pragma db column("eight_location") type("varchar(100)") // 8号挂点位置
    std::string eightLocation_;

    #pragma db column("eight_ammo_name") type("varchar(100)") // 8号挂载弹药名称
    std::string eightAmmoName_;

    #pragma db column("nine_hanging_point") type("varchar(100)") // 9号挂点编号
    std::string nineHangingPoint_;

    #pragma db column("nine_location") type("varchar(100)") // 9号挂点位置
    std::string nineLocation_;

    #pragma db column("nine_ammo_name") type("varchar(100)") // 9号挂载弹药名称
    std::string nineAmmoName_;

    #pragma db column("ten_hanging_point") type("varchar(100)") // 10号挂点编号
    std::string tenHangingPoint_;

    #pragma db column("ten_location") type("varchar(100)") // 10号挂点位置
    std::string tenLocation_;

    #pragma db column("ten_ammo_name") type("varchar(100)") // 10号挂载弹药名称
    std::string tenAmmoName_;

    /******************** 续航性能 ********************/
    #pragma db column("running_distance") type("real") // 滑跑距离(m)
    float runningDistance_;

    #pragma db column("endurance") type("real") // 航时(h)
    float endurance_;

    #pragma db column("fight_radius") type("real") // 作战半径(Km)
    float fightRadius_;

    #pragma db column("max_fuel") type("real") // 最大载油量(L)
    float maxFuel_;

    #pragma db column("max_external_weight") type("real") // 最大外挂重量(KG)
    float maxExternalWeight_;

    /******************** 系统记录 ********************/
    #pragma db column("recordcreation_time") type("timestamp(0)") options("DEFAULT CURRENT_TIMESTAMP") // 记录创建时间
    QDateTime recordCreationTime_{QDateTime::currentDateTime()};

    #pragma db column("status") type("bool") // 使用状态
    bool status_;
};
#endif // MOUNTINGSCHEMEMOUNTINGCONFIGURATION_H
