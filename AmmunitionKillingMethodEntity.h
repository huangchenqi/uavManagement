#ifndef AMMUNITIONKILLINGMETHODENTITY_H
#define AMMUNITIONKILLINGMETHODENTITY_H
//杀伤方式建立实体类对应建表
#include <string>
#include <odb/core.hxx> // ODB核心头文件
#pragma once
#pragma db object schema("uav_type_man") table("ammo_killing_way") // 指定表名
class AmmoKillingWayEntity
{
public:
//     // 构造函数
//     UavModelLoadTypeEntity() = default;

//     // Getter和Setter方法（示例，需根据业务逻辑补充完整）
//     long getId() const { return id_; }
//     void setId(long id) { id_ = id; }

//     const std::string& getLoadType() const { return loadTypeName_; }
//     void setLoadType(const std::string& type) { loadTypeName_ = type; }
// private:
//     friend class odb::access; // 允许ODB访问私有成员

/******************** 基础字段 ********************/
#pragma db id auto column("id")                    // 自增主键
    long id_;

#pragma db not_null column("killing_way_code")                        // 载荷编号
    std::string killingCode_;
#pragma db column("killing_way_name")                      // 载荷名称
    std::string killingName_;
#pragma db  column("status")                        // 载荷编号
    bool killingStatus_;
};
#endif // AMMUNITIONKILLINGMETHODENTITY_H
