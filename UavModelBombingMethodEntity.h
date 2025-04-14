#ifndef UAVMODELBOMBINGMETHODENTITY_H
#define UAVMODELBOMBINGMETHODENTITY_H
//投弹方式建立实体类对应建表
#include <string>

#include <odb/core.hxx> // ODB核心头文件
#pragma once
#pragma db object schema("uav_type_man") table("uav_model_bombing_way") // 指定表名
class UavModelBombingMethodEntity
{

public:
    // 构造函数
    UavModelBombingMethodEntity() = default;

    // Getter和Setter方法（示例，需根据业务逻辑补充完整）
//     long getId() const { return id_; }
//     void setId(long id) { id_ = id; }

//     const std::string& getBombingMethod() const { return bombingMethodName_; }
//     void setBombingMethod(const std::string& type) { bombingMethodName_ = type; }
// private:
//     friend class odb::access; // 允许ODB访问私有成员

/******************** 基础字段 ********************/
#pragma db id auto column("id")                    // 自增主键
    long id_;

#pragma db not_null column("bombingway_code")                        // 无人机编号
    std::string bombingMethodCode_;
#pragma db column("bombingway_name")                      // 无人机名称
    std::string bombingMethodName_;
};
#endif // UAVMODELBOMBINGMETHODENTITY_H
