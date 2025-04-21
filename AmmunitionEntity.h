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
    //id BIGSERIAL PRIMARY KEY;
    //-- 基础标识信息
#pragma db not_null column("ammo_name")//            VARCHAR(100) NOT NULL ,--COMMENT '名称',
    std::string ammoName_;
#pragma db not_null column("short_name")//    short_name VARCHAR(50) ,--COMMENT '简称',
    std::string shortName_;

#pragma db not_null column("ammo_type")             // 弹药类型ammo_type VARCHAR(50) ,--COMMENT '炸弹类型',
    std::string ammoType_;

// #pragma db column("ammo_name")                      // 弹药名称
//     std::string ammoName_;

#pragma db not_null column("ammo_id")                        // 弹药编号
    std::string ammoId_;

#pragma db not_null column("ammo_to_uavmodel")                        // used_uav_models VARCHAR(200) NOT NULL ,--COMMENT '使用机型'
    std::string ammoToUavModel_;

#pragma db not_null column("description")                        //         description TEXT ,--COMMENT '用途描述',
    std::string ammoDescription_;
#pragma db not_null column("length")                        //-- 基础物理特性        length REAL NOT NULL ,--COMMENT '炸弹长度(m)',
    float ammoLenth_;
#pragma db not_null column("mass")    //mass REAL NOT NULL ,--COMMENT '炸弹质量(kg)',
    float ammoMass_;
#pragma db not_null column("diameter")   //        diameter REAL NOT NULL ,--COMMENT '直径(m)',
    float ammoDiameter_;
#pragma db not_null column("wingspan") //wingspan REAL NOT NULL ,--COMMENT '翼展(m)',
    float ammoWingspan_;
#pragma db not_null column("warhead_cg_distance") //warhead_cg_distance REAL NOT NULL ,--COMMENT '弹头端面至重心距离(m)',
    float ammoWarheadCgDistance_;
#pragma db not_null column("charge_mass") //charge_mass REAL NOT NULL ,--COMMENT '炸弹装药质量(kg)',
    float ammoChargeMass_;
#pragma db not_null column("charge_coefficient") //charge_coefficient REAL NOT NULL ,--COMMENT '装填系数',
    float ammoChargeCoefficient_;
#pragma db not_null column("max_release_height") //max_release_height REAL NOT NULL ,--COMMENT '投弹高度(最大)(m)',
    float ammoMaxReleaseHeight_;
#pragma db not_null column("min_release_height") //min_release_height REAL NOT NULL ,--COMMENT '投弹高度(最小)(m)',
    float ammoMinReleaseHeight;
#pragma db not_null column("min_release_speed") //min_release_speed REAL NOT NULL ,--COMMENT '投弹速度(最小)(m/s)',
    float ammoMinReleaseSpeed_;
#pragma db not_null column("max_release_speed") //max_release_speed REAL NOT NULL ,--COMMENT '投弹速度(最大)(m/s)',
    float ammoMaxReleaseSpeed_;
#pragma db not_null column("tail_length") //tail_length REAL NOT NULL ,--COMMENT '弹尾长(m)',
    float ammoTailLength_;
#pragma db not_null column("lug_spacing") //lug_spacing REAL NOT NULL ,--COMMENT '弹耳间距(m)',
    float ammoLugSpacing_;
#pragma db not_null column("killing_way") //-- 结构参数killing_way VARCHAR(50) ,--COMMENT '杀伤方式',
    std::string ammoKillingWway_;
#pragma db not_null column("penetration_depth") //penetration_depth REAL NOT NULL ,--COMMENT '侵彻深度',
    float ammoPenetrationDepth_;
#pragma db not_null column("quantity_soil_thrown") //quantity_soil_thrown REAL NOT NULL ,--COMMENT '抛土量',
    float ammoQuantitySoilThrown_;
#pragma db not_null column("crater_diameter") //  crater_diameter REAL NOT NULL ,--COMMENT '弹坑直径',
    float ammoCraterDiameter_;
#pragma db not_null column("crater_depth") //  crater_depth REAL NOT NULL ,--COMMENT '弹坑深度',
    float ammoCraterDepth_;
#pragma db not_null column("damaged_area") //damaged_area REAL NOT NULL ,--COMMENT '破坏面积',
    float ammoDamagedArea_;
#pragma db not_null column("dense_killing_radius") //dense_killing_radius REAL NOT NULL ,--COMMENT '密集杀伤半径',
    float ammoDenseKillingRadius_;
#pragma db not_null column("initial_velocity_fragments") //initial_velocity_fragments REAL NOT NULL ,--COMMENT '破片初速',
    float ammoInitialVelocityFragments_;
#pragma db not_null column("number_fragments")  //number_fragments INT NOT NULL ,--COMMENT '破片数量',
    int ammoNumberFragments_;
#pragma db not_null column("armor_breaking_ability") //armor_breaking_ability VARCHAR(50) ,--COMMENT '破甲能力',
    std::string ammoArmorBreakingAbility_;
#pragma db not_null column("bullet_density_range_minimum") //bullet_density_range_minimum INT NOT NULL ,--COMMENT '子弹密度范围(最小)',
    int bullet_density_range_minimum;
#pragma db not_null column("bullet_density_range_maximum") //bullet_density_range_maximum INT NOT NULL ,--COMMENT '子弹密度范围(最大)',
    int bullet_density_range_maximum;
#pragma db not_null column("ground_ignition_rate")  //ground_ignition_rate  REAL NOT NULL ,--COMMENT '对地发火率',
    float ground_ignition_rate;
#pragma db not_null column("combustion_temperature") // combustion_temperature REAL NOT NULL ,--COMMENT '燃烧温度',
    float combustion_temperature;
#pragma db not_null column("combustion_time") //combustion_time REAL NOT NULL ,--COMMENT '燃烧时间',
    float combustion_time;
#pragma db not_null column("combustion_agent_spread_range")  //combustion_agent_spread_range REAL NOT NULL ,--COMMENT '烧剂散步范围',
    float combustion_agent_spread_range;
#pragma db not_null column("number_of_fragments")  //number_of_fragments INT NOT NULL ,--COMMENT '弹片数量',
    int number_of_fragments;
#pragma db not_null column("breakdown_distance") //breakdown_distance REAL NOT NULL ,--COMMENT '击穿距离',
    float breakdown_distance;
#pragma db not_null column("maximum_inclusive_coverage_quantity") //maximum_inclusive_coverage_quantity INT NOT NULL ,--COMMENT '最大包容覆盖数量',
    int maximum_inclusive_coverage_quantity;
#pragma db not_null column("number_of_spread")  //number_of_spread INT NOT NULL ,--COMMENT '散步数量',
    int number_of_spread;
#pragma db not_null column("surface_dc_resistivity") //surface_dc_resistivity REAL NOT NULL ,--COMMENT '表面直流电阻率',
    float surface_dc_resistivity;
#pragma db not_null column("probability_of_arc_discharge") //probability_of_arc_discharge REAL NOT NULL ,--COMMENT '引弧放电概率',
    float probability_of_arc_discharge;
#pragma db not_null column("fuel_dispersion_radius") //fuel_dispersion_radius  REAL NOT NULL ,--COMMENT '燃料分散半径',
    float fuel_dispersion_radius;
#pragma db not_null column("distance_from_center_explosion")  //distance_from_center_explosion REAL NOT NULL ,--COMMENT '距离爆心距离',
    float distance_from_center_explosion;
#pragma db not_null column("shock_wave_overpressure_value")  //shock_wave_overpressure_value REAL NOT NULL ,--COMMENT '冲击波超压值',
    float shock_wave_overpressure_value;
#pragma db not_null column("spread_area")  //-- 作战性能参数 spread_area REAL NOT NULL ,--COMMENT '散步面积',
    float spread_area;
#pragma db not_null column("use_description") //use_description TEXT ,--COMMENT '用途描述',
    std::string use_description;
#pragma db not_null column("interference_duration") //interference_duration REAL NOT NULL ,--COMMENT '干扰时长',
    float interference_duration;
#pragma db not_null column("interference_length_minimum") //Interference_length_minimum REAL NOT NULL ,--COMMENT '干扰长度(最小)',
    float interference_length_minimum;
#pragma db not_null column("interference_length_maximum")  //Interference_length_maximum REAL NOT NULL ,--COMMENT '干扰长度(最大)',
    float interference_length_maximum;
#pragma db not_null column("interference_width_minimum")  //interference_width_minimum REAL NOT NULL ,--COMMENT '干扰宽度(最小)',
    float interference_width_minimum;
#pragma db not_null column("interference_width_maximum")  //interference_width_maximum REAL NOT NULL ,--COMMENT '干扰宽度(最大)',
    float interference_width_maximum;
#pragma db not_null column("fuze_model") //fuze_model VARCHAR(50) ,--COMMENT '引信型号',
    std::string fuze_model;
#pragma db not_null column("number_of_fuses") //number_of_fuses INT NOT NULL ,--COMMENT '引信数量',
    int number_of_fuses;
#pragma db not_null column("storage_life") //storage_life REAL NOT NULL ,--COMMENT '储存寿命'
    float storage_life;

#pragma db not_null column("action_time") //action_time REAL NOT NULL ,--COMMENT '作用时间',
    float action_time;
#pragma db not_null column("available_extension_time") //available_extension_time REAL NOT NULL ,--COMMENT '可用延解时间',
    float available_extension_time;
#pragma db not_null column("rudder_width") //rudder_width REAL NOT NULL ,--COMMENT '舵宽',
    float rudder_width;
#pragma db not_null column("aerodynamic_configuration") //aerodynamic_configuration VARCHAR(50) ,--COMMENT '气动布局',
    std::string aerodynamic_configuration;
#pragma db not_null column("working_conditions")  //working_conditions  VARCHAR(50) ,--COMMENT '工作条件(白天/夜晚)(day/night)',
    std::string working_conditions;
#pragma db not_null column("working_temperature") //working_temperature REAL NOT NULL ,--COMMENT '工作环境温度',
    float working_temperature;
#pragma db not_null column("working_altitude") //working_altitude REAL NOT NULL ,--COMMENT '工作海拔高度',
    float working_altitude;
#pragma db not_null column("launch_way") //launch_way VARCHAR(50) ,--COMMENT '发射方式',
    std::string launch_way;

#pragma db not_null column("guidance_rule")  //guidance_rule VARCHAR(50) ,--COMMENT '导引规律',
    std::string guidance_rule;
#pragma db not_null column("minimum_visibility_emission") //minimum_visibility_emission REAL NOT NULL ,--COMMENT '发射最小能见度',
    float minimum_visibility_emission;
#pragma db not_null column("maximum_launch_altitude") //maximum_launch_altitude REAL NOT NULL ,--COMMENT '发射最大发射海拔高度',
    float maximum_launch_altitude;
#pragma db not_null column("launch_maximum_target_altitude") //launch_maximum_target_altitude REAL NOT NULL ,--COMMENT '发射最大目标海拔高度',
    float launch_maximum_target_altitude;
#pragma db not_null column("maximum_launch_relative_height") //maximum_launch_relative_height REAL NOT NULL ,--COMMENT '发射最大发射相对高度',
    float maximum_launch_relative_height;
#pragma db not_null column("minimum_relative_height_launch")  //minimum_relative_height_launch REAL NOT NULL ,--COMMENT '发射最小发射相对高度',
    float minimum_relative_height_launch;
#pragma db not_null column("launch_speed") //launch_speed REAL NOT NULL ,--COMMENT '发射速度',
    float launch_speed;
#pragma db not_null column("launch_conditions") //launch_conditions VARCHAR(50) ,--COMMENT '发射条件天气限制',
    std::string launch_conditions;
#pragma db not_null column("launch_off_axis_angle") //launch_off_axis_angle REAL NOT NULL ,--COMMENT '发射离轴角',
    float launch_off_axis_angle;
#pragma db not_null column("guidance_way") //guidance_way VARCHAR(50) ,--COMMENT '制导方式',
    std::string guidance_way;
#pragma db not_null column("effective_range") //effective_range REAL NOT NULL ,--COMMENT '射程',
    float effective_range;

#pragma db not_null column("hit_accuracy")  //hit_accuracy REAL NOT NULL ,--COMMENT '命中精度',
    float hit_accuracy;
#pragma db not_null column("hit_probability") // hit_probability REAL NOT NULL ,--COMMENT '命中概率',
    float hit_probability;
#pragma db not_null column("preparation_time") //preparation_time REAL NOT NULL ,--COMMENT '准备时间',
    float preparation_time;
#pragma db not_null column("allow_continuous_flight_time") //allow_continuous_flight_time REAL NOT NULL ,--COMMENT '允许连续载飞时间',
    float allow_continuous_flight_time;
#pragma db not_null column("guided_flight_time")  //guided_flight_time REAL NOT NULL ,--COMMENT '制导飞行时间',
    float guided_flight_time;
#pragma db not_null column("maximum_speed_of_missile")  //maximum_speed_of_missile REAL NOT NULL ,--COMMENT '导弹最大速度',
    float maximum_speed_of_missile;
#pragma db not_null column("guiding_head_working_wavelength")  //guiding_head_working_wavelength REAL NOT NULL ,--COMMENT '导引头工作波长(激光波长) (laser wavelength)',
    float guiding_head_working_wavelength;
#pragma db not_null column("guidance_head_operating_distance")  //guidance_head_operating_distance REAL NOT NULL ,--COMMENT '导引头作用距离',
    float guidance_head_operating_distance;
#pragma db not_null column("blind_spot_of_guidance_head")  //blind_spot_of_guidance_head REAL NOT NULL ,--COMMENT '导引头盲区',
    float blind_spot_of_guidance_head;
#pragma db not_null column("guidance_head_frame_angle")  //guidance_head_frame_angle REAL NOT NULL ,--COMMENT '导引头框架角',
    float guidance_head_frame_angle;
#pragma db not_null column("guidance_head_field_of_view_angle")  //guidance_head_field_of_view_angle REAL NOT NULL ,--COMMENT '导引头视场角',
    float guidance_head_field_of_view_angle;



#pragma db not_null column("adaptability_of_guidance_head_sunlight")  //adaptability_of_guidance_head_sunlight VARCHAR(50) ,--COMMENT '导引头对太阳光的适应性',
    std::string adaptability_of_guidance_head_sunlight;
#pragma db not_null column("guidance_head_operating_frequency")  //guidance_head_operating_frequency REAL NOT NULL ,--COMMENT '导引头工作频率',
    float guidance_head_operating_frequency;
#pragma db not_null column("fuse_firing_rate") //fuse_firing_rate REAL NOT NULL ,--COMMENT '引信发火率',
    float fuse_firing_rate;
#pragma db not_null column("fuse_type") //fuse_type VARCHAR(50) ,--COMMENT '引信类型',
    std::string fuse_type;
#pragma db not_null column("fuse_length") //fuse_length REAL NOT NULL ,--COMMENT '引信长度',
    float fuse_length;
#pragma db not_null column("fuse_diameter")  //fuse_diameter REAL NOT NULL ,--COMMENT '引信直径',
    float fuse_diameter;
#pragma db not_null column("fuze_quality")  //fuze_quality REAL NOT NULL ,--COMMENT '引信质量',
    float fuze_quality;
#pragma db not_null column("safe_distance_of_fuse")  //safe_distance_of_fuse REAL NOT NULL ,--COMMENT '引信安全距离',
    float safe_distance_of_fuse;
#pragma db not_null column("time_disarming_fuse")  //time_disarming_fuse REAL NOT NULL ,--COMMENT '引信解除保险时间',
    float time_disarming_fuse;
#pragma db not_null column("first_level_release_time_of_fuse")  //first_level_release_time_of_fuse REAL NOT NULL ,--COMMENT '引信一级解除保险时间',
    float first_level_release_time_of_fuse;
#pragma db not_null column("secondary_release_time_of_fuse")  //secondary_release_time_of_fuse REAL NOT NULL ,--COMMENT '引信二级解除保险时间',
    float secondary_release_time_of_fuse;
#pragma db not_null column("reliability_rate_of_fuse_action")  //reliability_rate_of_fuse_action REAL NOT NULL ,--COMMENT '引信作用可靠率',
    float reliability_rate_of_fuse_action;
#pragma db not_null column("fuse_self_destruct_time")  //fuse_self_destruct_time REAL NOT NULL ,--COMMENT '引信自毁时间',
    float fuse_self_destruct_time;
#pragma db not_null column("combat_department_quality")  //combat_department_quality REAL NOT NULL ,--COMMENT '战斗部质量',
    float combat_department_quality;
#pragma db not_null column("combat_quantity")  //combat_quantity REAL NOT NULL ,--COMMENT '战斗部装药量',
    float combat_quantity;
#pragma db not_null column("combat_unit_type")  //combat_unit_type VARCHAR(50) ,--COMMENT '战斗部类型',
    std::string combat_unit_type;
#pragma db not_null column("combat_length")  //combat_length  REAL NOT NULL ,--COMMENT '战斗部长度',
    float combat_length;

#pragma db not_null column("combat_diameter")  //combat_diameter REAL NOT NULL ,--COMMENT '战斗部直径',
    float combat_diameter;
#pragma db not_null column("combat_main_charge_type")  //combat_main_charge_type VARCHAR(50) ,--COMMENT '战斗部主装药类型',
    std::string combat_main_charge_type;
#pragma db not_null column("combat_charge_density")  //combat_charge_density REAL NOT NULL ,--COMMENT '战斗部装药密度',
    float combat_charge_density;
#pragma db not_null column("combat_loading_factor")  //combat_loading_factor REAL NOT NULL ,--COMMENT '战斗部装填系数',
    float combat_loading_factor;
#pragma db not_null column("combat_explosive")  //combat_explosive REAL NOT NULL ,--COMMENT '战斗部扩爆药',
    float combat_explosive;
#pragma db not_null column("combat_fragments_number")  //combat_fragments_number INT NOT NULL ,--COMMENT '战斗部破片数量',
    int combat_fragments_number;
#pragma db not_null column("combat_unit_invasion_capability")  //combat_unit_invasion_capability VARCHAR(50) ,--COMMENT '战斗部侵袭能力',
    std::string combat_unit_invasion_capability;
#pragma db not_null column("combat_effective_killing_radius_vehicles")  //combat_effective_killing_radius_vehicles REAL NOT NULL ,--COMMENT '战斗部对车辆的有效杀伤半径',
    float combat_effective_killing_radius_vehicles;
#pragma db not_null column("combat_effective_killing_radius_personnel")   //combat_effective_killing_radius_personnel REAL NOT NULL ,--COMMENT '战斗部对人员的有效杀伤半径',
    float combat_effective_killing_radius_personnel;
#pragma db not_null column("combat_vertical_static_armor_penetration_depth")  //combat_vertical_static_armor_penetration_depth REAL NOT NULL ,--COMMENT '战斗部垂直静破甲深度',
    float combat_vertical_static_armor_penetration_depth;
#pragma db not_null column("combat_department_quality_add")  //combat_department_quality_add REAL NOT NULL ,--COMMENT '第二个战斗部质量',
    float combat_department_quality_add;
#pragma db not_null column("combat_quantity_add")  //combat_quantity_add REAL NOT NULL ,--COMMENT '第二个战斗部装药量',
    float combat_quantity_add;

#pragma db not_null column("combat_unit_type_add")  //combat_unit_type_add VARCHAR(50) ,--COMMENT '第二个战斗部类型',
    std::string combat_unit_type_add;
#pragma db not_null column("combat_length_add")  //combat_length_add  REAL NOT NULL ,--COMMENT '第二个战斗部长度',
    float combat_length_add;
#pragma db not_null column("combat_diameter_add")  //combat_diameter_add REAL NOT NULL ,--COMMENT '第二个战斗部直径',
    float combat_diameter_add;
#pragma db not_null column("combat_main_charge_type_add")  //combat_main_charge_type_add VARCHAR(50) ,--COMMENT '第二个战斗部主装药类型',
    std::string combat_main_charge_type_add;
#pragma db not_null column("combat_charge_density_add")  //combat_charge_density_add REAL NOT NULL ,--COMMENT '第二个战斗部装药密度',
    float combat_charge_density_add;
#pragma db not_null column("combat_loading_factor_add")  //combat_loading_factor_add REAL NOT NULL ,--COMMENT '第二个战斗部装填系数',
    float combat_loading_factor_add;
#pragma db not_null column("combat_explosive_add")  //combat_explosive_add REAL NOT NULL ,--COMMENT '第二个战斗部扩爆药',
    float combat_explosive_add;
#pragma db not_null column("combat_fragments_number_add")  //combat_fragments_number_add INT NOT NULL ,--COMMENT '第二个战斗部破片数量',
    int combat_fragments_number_add;
#pragma db not_null column("combat_unit_invasion_capability_add")  //combat_unit_invasion_capability_add VARCHAR(50) ,--COMMENT '第二个战斗部侵袭能力',
    std::string combat_unit_invasion_capability_add;
#pragma db not_null column("combat_effective_killing_radius_vehicles_add")  //combat_effective_killing_radius_vehicles_add REAL NOT NULL ,--COMMENT '第二个战斗部对车辆的有效杀伤半径',
    float combat_effective_killing_radius_vehicles_add;

#pragma db not_null column("combat_effective_killing_radius_personnel_add")  //combat_effective_killing_radius_personnel_add REAL NOT NULL ,--COMMENT '第二个战斗部对人员的有效杀伤半径',
    float combat_effective_killing_radius_personnel_add;
#pragma db not_null column("combat_vertical_static_armor_penetration_depth_add")  //combat_vertical_static_armor_penetration_depth_add REAL NOT NULL ,--COMMENT '第二个战斗部垂直静破甲深度',
    float combat_vertical_static_armor_penetration_depth_add;
#pragma db not_null column("service_life")  //service_life REAL NOT NULL ,--COMMENT '使用寿命',
    float service_life;
#pragma db not_null column("distance_between_center_mass_end")  //distance_between_center_mass_end REAL NOT NULL ,--COMMENT '质心距弹头端面距离',
    float distance_between_center_mass_end;
#pragma db not_null column("lifting_lug")  //lifting_lug VARCHAR(50) ,--COMMENT '吊耳',
    std::string lifting_lug;
#pragma db not_null column("distance_suspension_lifting_lug")  //distance_suspension_lifting_lug  REAL NOT NULL ,--COMMENT '吊耳间距',
    float distance_suspension_lifting_lug;
#pragma db not_null column("image_name")  //image_name VARCHAR(50) ,--COMMENT '图片名称',
    std::string image_name;
#pragma db not_null column("image_url")   //image_url VARCHAR(50) ,--COMMENT '图片路径',
    std::string image_url;
#pragma db not_null column("record_creation_time") type("timestamp(0)") options("DEFAULT CURRENT_TIMESTAMP") //record_creation_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,--COMMENT '记录创建时间',
    QDateTime record_creation_time{QDateTime::currentDateTime()};
#pragma db not_null column("use_status")  // use_status bool  --COMMENT '使用状态',
    float use_status;
// #pragma db column("recordcreation_time") type("timestamp(0)") options("DEFAULT CURRENT_TIMESTAMP")               // 创建时间
//     QDateTime recordCreationTime_{QDateTime::currentDateTime()};
// #pragma db column("image_url")                     // 模型图片路径

// /******************** 尺寸参数 ********************/
// #pragma db column("length")                        // 弹药长度(m)
//     float ammoLength_;

// #pragma db column("width")                         // 弹药直径(m)
//     float ammoWidth_;

// #pragma db column("weight")                        // 弹药重量(m)
//     float ammoWeight_;

// #pragma db column("guidance_type")                  // 制导类型
//     std::string guidanceType_;


// /******************** 飞行性能 ********************/
// #pragma db column("launch_height_min")             // 投放高度范围最小值(m)
//     float launchHeightMin_;

// #pragma db column("launch_height_max")             // 投放高度范围最大值(m)
//     float launchHeightMax_;

// #pragma db column("launch_distance_min")              // 投放距离范围最小值(Km)
//     float launchDistanceMin_;

// #pragma db column("launch_distance_max")              // 投放距离范围最大值(Km)
//     float launchDistanceMax_;

// #pragma db column("launch_angle")           // 投放角度(°)
//     float launchAngle_;

// #pragma db column("launch_method")           // 投放方式
//     std::string launchWay_;

// #pragma db column("approve_attack_target_type")               // 可打击目标类型
//     std::string approveAttackTargetType_;

// #pragma db column("killing_dose")               // 杀伤药量
//     float killingDose_;



// #pragma db column("killing_method")              // 杀伤方式
//     std::string killingMethod_;

// #pragma db column("killing_depth")              // 杀伤深度(m)
//     float killingDepth_;


/******************** 机动性能 ********************/
// #pragma db column("killing_range_min")               // 杀伤范围最小值(m)
//     float killingRangeMin_;

// #pragma db column("killing_range_max")               // 杀伤范围最大值(m)
//     float killingRangeMax_;


/******************** 系统记录 ********************/
    // 将time_t映射为TIMESTAMP类型
// #pragma db column("recordcreation_time") type("timestamp(0)") options("DEFAULT CURRENT_TIMESTAMP")               // 创建时间
//     QDateTime recordCreationTime_{QDateTime::currentDateTime()};
// #pragma db column("image_url")                     // 模型图片路径
//     std::string ammoImgUrl_;
// #pragma db column("image_name")                 // 图片名称
//     float ammoImageName_;
};
#endif // AMMUNITIONENTITY_H
