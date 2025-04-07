#ifndef UAVMODELRECOVERYMODEENTITY_H
#define UAVMODELRECOVERYMODEENTITY_H
//回收方式建立实体类对应建表
#include <string>
#include <QDateTime>
#include <odb/core.hxx> // ODB核心头文件
#pragma once
#pragma db object schema("uav_type_man") table("uav_model_recoverymode") // 指定表名
class UavModelRecoveryModeEntity
{

public:
    // 构造函数
    UavModelRecoveryModeEntity() = default;

    // Getter和Setter方法（示例，需根据业务逻辑补充完整）
    long getId() const { return id_; }
    void setId(long id) { id_ = id; }

    const std::string& getRecoveryMode() const { return recoveryModeName_; }
    void setRecoveryMode(const std::string& type) { recoveryModeName_ = type; }
private:
    friend class odb::access; // 允许ODB访问私有成员

/******************** 基础字段 ********************/
#pragma db id auto column("id")                    // 自增主键
    long id_;

#pragma db not_null column("recoverymode_id")                        // 无人机编号
    std::string recoveryModeId_;
#pragma db column("recoverymode_name")                      // 无人机名称
    std::string recoveryModeName_;
};
#endif // UAVMODELRECOVERYMODEENTITY_H
