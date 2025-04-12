#ifndef UAVMODELMOUNTLOCATIONENTITY_H
#define UAVMODELMOUNTLOCATIONENTITY_H
//挂载位置建立实体类对应建表
#include <string>
//#include <QDateTime>
#include <odb/core.hxx> // ODB核心头文件
#pragma once
#pragma db object schema("public") table("uav_model_mount_location") // 指定表名
class UavModelMountLocationEntity
{

public:
    // 构造函数
    UavModelMountLocationEntity() = default;

    // Getter和Setter方法（示例，需根据业务逻辑补充完整）
    // long getId() const { return id_; }
    // void setId(long id) { id_ = id; }

    // const std::string& getMountLocation() const { return mountLocationName_; }
    // void setMountLocation(const std::string& type) { mountLocationName_ = type; }
/******************** 基础字段 ********************/
#pragma db id auto column("id")                    // 自增主键
    long id_;

#pragma db column("mountlocation_code")                        // 挂载位置编号
    std::string mountLocationId_;
#pragma db not_null column("mountlocation_name")                      // 挂载位置名称
    std::string mountLocationName_;

private:
    //friend class odb::access; // 允许ODB访问私有成员

/******************** 基础字段 ********************/
// #pragma db id auto column("id")                    // 自增主键
//     long id_;

// #pragma db column("mount_location_id")                        // 挂载位置编号
//     std::string mountLocationId_;
// #pragma db not_null column("mountlocation_name")                      // 挂载位置名称
//     std::string mountLocationName_;
};
#endif // UAVMODELMOUNTLOCATIONENTITY_H
