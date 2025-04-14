#ifndef UAVMODELOPERATIONWAYENTITY_H
#define UAVMODELOPERATIONWAYENTITY_H
//操控方式建立实体类对应建表
#include <string>
#include <odb/core.hxx> // ODB核心头文件
#pragma once
#pragma db object schema("uav_type_man") table("uav_model_operation_way") // 指定表名
class UavModelOpreationWayEntity
{

public:
    // 构造函数
    UavModelOpreationWayEntity() = default;

//     // Getter和Setter方法（示例，需根据业务逻辑补充完整）
//     long getId() const { return id_; }
//     void setId(long id) { id_ = id; }

//     const std::string& getControlMethod() const { return controlMethodName_; }
//     void setControlMethod(const std::string& type) { controlMethodName_ = type; }
// private:
//     friend class odb::access; // 允许ODB访问私有成员

/******************** 基础字段 ********************/
#pragma db id auto column("id")                    // 自增主键
    long id_;

#pragma db not_null column("operationway_code")                        // 无人机编号
    std::string operationWayCode_;
#pragma db column("operationway_name")                      // 无人机名称
    std::string operationWayName_;
};
#endif // UAVMODELOPERATIONWAYENTITY_H
