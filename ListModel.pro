QT += quick sql

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
# # 将配置文件复制到构建目录
# CONFIG += file_copies
# COPIES += config/database.ini
# 设置ODB和PostgreSQL的路径
MINGW_ROOT = $$PWD/pgsqlconnect

# 包含路径配置
INCLUDEPATH += $${MINGW_ROOT}/include
INCLUDEPATH += $${MINGW_ROOT}/include/postgresql
INCLUDEPATH += generated  # 存放ODB生成的代码

# 库路径配置
LIBS += -L$${MINGW_ROOT}/lib

# 需要链接的库
LIBS += -lodb          # ODB核心库
LIBS += -lodb-qt       # qt插件
LIBS += -lodb-pgsql    # PostgreSQL插件
LIBS += -lpq           # PostgreSQL客户端库

SOURCES += \
#        EasyTableModel.cpp \
#        TableModel.cpp \
    AmmunitionEntity-odb.cxx \
    UavModelBombingMethodEntity-odb.cxx \
    UavModelLoadTypeEntity-odb.cxx \
    UavModelMountLocationEntity-odb.cxx \
    UavModelOperationWayEntity-odb.cxx \
    UavModelRecoveryModeEntity-odb.cxx \
    ammodao.cpp \
    databaseconnection.cpp \
        main.cpp \
#        migration.cpp \
#        uavdataoperationmodel.cpp \
    uavmodelbombingmethoddao.cpp \
        uavmodeldao.cpp \
    uavmodelentity-odb.cxx \
    uavmodelloadtypedao.cpp \
    uavmodeloperationwaydao.cpp \
    uavmodelrecoverymodedao.cpp \
    uavmountlocationdao.cpp


RESOURCES += qml.qrc \
              res.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
#    EasyTableModel.h \
#    Sql.h \
#    TableModel.h \
#    migration.h \
#    uavdataoperationmodel.h \
    AmmunitionAttackTargetTypeEntity.h \
    AmmunitionDeliveryMethodEntity.h \
    AmmunitionEntity-odb.hxx \
    AmmunitionEntity.h \
    AmmunitionGuidanceTypeEntity.h \
    AmmunitionKillingMethodEntity.h \
    AmmunitionTypeEntity.h \
    MountingSchemeLoadConfigurationEntity.h \
    MountingSchemeMountingConfiguration.h \
    ReconnaissancePayloadEntity.h \
    UavModelBombingMethodEntity-odb.hxx \
    UavModelBombingMethodEntity.h \
    UavModelControlMethodEntity.h \
    UavModelDataToJson.h \
    UavModelHangingCapability.h \
    UavModelLoadTypeEntity-odb.hxx \
    UavModelLoadTypeEntity.h \
    UavModelMountLocationEntity-odb.hxx \
    UavModelMountLocationEntity.h \
    UavModelOperationWayEntity-odb.hxx \
    UavModelOperationWayEntity.h \
    UavModelRecoveryModeEntity-odb.hxx \
    UavModelRecoveryModeEntity.h \
    ammodao.h \
    databaseconnection.h \
    datetime-traits.hxx \
    json.hpp \
    uavmodelbombingmethoddao.h \
    uavmodeldao.h \
    uavmodelentity-odb.hxx \
    uavmodelentity.h \
    uavmodelloadtypedao.h \
    uavmodeloperationwaydao.h \
    uavmodelrecoverymodedao.h \
    uavmountlocationdao.h

DISTFILES += \
    AmmunitionEntity-odb.ixx \
    UavModelLoadTypeEntity-odb.ixx \
    uavmodelentity-odb.ixx


