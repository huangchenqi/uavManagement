#ifndef UAVMODELLOADTYPEENTITY_H
#define UAVMODELLOADTYPEENTITY_H
//载荷类型建立实体类对应建表
#include <string>
#include <odb/core.hxx> // ODB核心头文件
#pragma once
#pragma db object schema("uav_type_man") table("uav_model_load_type") // 指定表名
class UavModelLoadTypeEntity
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

#pragma db not_null column("loadtype_code")                        // 载荷编号
    std::string loadTypeCode_;
#pragma db column("loadtype_name")                      // 载荷名称
    std::string loadTypeName_;
};
#endif // UAVMODELLOADTYPEENTITY_H
