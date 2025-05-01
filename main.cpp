#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QTextCodec>
#include "odb/database.hxx"
#include "odb/pgsql/database.hxx"
//#include "UavModelEntity-odb.hxx"
#include "uavmodeldao.h"
#include "uavmountlocationdao.h"
#include "uavmodelbombingmethoddao.h"
#include "uavmodeloperationwaydao.h"
#include "uavmodelrecoverymodedao.h"
#include "uavmodelloadtypedao.h"
#include "uavmodeltypedao.h"
#include "ammodao.h"
#include "ammokillingwaydao.h"
#include "ammolaunchwaydao.h"
#include "ammoattacktargetdao.h"
#include "ammoguidancetypedao.h"
#include "ammotypedao.h"
#include "ammoaerodynamicconfigurationdao.h"
#include "interferencepoddao.h"
#include "mountingschemedao.h"
#include "reconnaissanceCommunicationdao.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    // {
    //     QStringList files = { ":/migrations/001_books.sql" };
    //     Migration migration(Sql::database("data.db"));
    //     if(!migration.run(files))
    //     {
    //         qWarning() << "Create migration table(s) failed in database"
    //                    << migration.connection().databaseName();
    //     }
    // }
    // 设置默认编码为 UTF-8
        QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));
    QQmlApplicationEngine engine;

    qmlRegisterType<UavModelDao>("UavDaoModel",1,0,"UavModelDaoTableModel");
    qmlRegisterType<UavMountLocationDao>("UavMountLocationDaoModel",1,0,"UavMountLocationDaoTableModel");
    qmlRegisterType<UavModelBombingMethodDao>("UavBombingMethodDaoModel",1,0,"UavBombingMethodDaoTableModel");
    qmlRegisterType<UavModelOperationWayDao>("UavModelOperationWayDaoModel",1,0,"UavModelOperationWayDaoTableModel");
    qmlRegisterType<UavModelRecoveryModeDao>("UavModelRecoveryModeDaoModel",1,0,"UavModelRecoveryModeDaoTableModel");
    qmlRegisterType<UavModelLoadTypeDao>("UavModelLoadTypeDaoModel",1,0,"UavModelLoadTypeDaoTableModel");
    qmlRegisterType<UavModelTypeDao>("UavModelTypeDaoModel",1,0,"UavModelTypeDaoTableModel");
    qmlRegisterType<AmmoDao>("AmmoDaoModel",1,0,"AmmoDaoTableModel");
    qmlRegisterType<AmmoKillingWayDao>("AmmoKillingWayDaoModel",1,0,"AmmoKillingWayDaoTableModel");
    qmlRegisterType<AmmoLaunchWayDao>("AmmoLaunchWayDaoModel",1,0,"AmmoLaunchWayDaoTableModel");
    qmlRegisterType<AmmoAttackTargetDao>("AmmoAttackTargetDaoModel",1,0,"AmmoAttackTargetDaoTableModel");
    qmlRegisterType<AmmoGuidanceTypeDao>("AmmoGuidanceTypeDaoModel",1,0,"AmmoGuidanceTypeDaoTableModel");
    qmlRegisterType<AmmoTypeDao>("AmmoTypeDaoModel",1,0,"AmmoTypeDaoTableModel");
    qmlRegisterType<AmmoAerodynamicConfigurationDao>("AmmoAerodynamicConfigurationDaoModel",1,0,"AmmoAerodynamicConfigurationDaoTableModel");
    qmlRegisterType<InterferencePodDao>("InterferencePodDaoModel",1,0,"InterferencePodDaoTableModel");
    qmlRegisterType<ReconnaissanceCommunicationDao>("ReconnaissanceCommunicationDaoModel",1,0,"ReconnaissanceCommunicationDaoTableModel");
    qmlRegisterType<MountingSchemeDao>("MountingSchemeDaoModel",1,0,"MountingSchemeDaoTableModel");
    //qmlRegisterType<TableModel>("Macai.App", 1, 0, "SqlTableModel");
    const QUrl url(QStringLiteral("qrc:/main.qml"));//mainUavDataTableView.qmlUavManageCommon
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    // UavModelDao dao;
    // QJsonObject obj;
    // dao.checkUavDataObject(obj);
    // dao.test();
    return app.exec();
}
