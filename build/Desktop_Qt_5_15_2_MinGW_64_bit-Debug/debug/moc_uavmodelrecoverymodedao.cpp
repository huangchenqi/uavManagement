/****************************************************************************
** Meta object code from reading C++ file 'uavmodelrecoverymodedao.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../uavmodelrecoverymodedao.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'uavmodelrecoverymodedao.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_UavModelRecoveryModeDao_t {
    QByteArrayData data[9];
    char stringdata0[169];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_UavModelRecoveryModeDao_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_UavModelRecoveryModeDao_t qt_meta_stringdata_UavModelRecoveryModeDao = {
    {
QT_MOC_LITERAL(0, 0, 23), // "UavModelRecoveryModeDao"
QT_MOC_LITERAL(1, 24, 30), // "selectModelRecoveryModeAllData"
QT_MOC_LITERAL(2, 55, 0), // ""
QT_MOC_LITERAL(3, 56, 27), // "updateModelRecoveryModeDate"
QT_MOC_LITERAL(4, 84, 8), // "QJSValue"
QT_MOC_LITERAL(5, 93, 12), // "selectedData"
QT_MOC_LITERAL(6, 106, 27), // "deleteModelRecoveryModeDate"
QT_MOC_LITERAL(7, 134, 27), // "insertModelRecoveryModeDate"
QT_MOC_LITERAL(8, 162, 6) // "object"

    },
    "UavModelRecoveryModeDao\0"
    "selectModelRecoveryModeAllData\0\0"
    "updateModelRecoveryModeDate\0QJSValue\0"
    "selectedData\0deleteModelRecoveryModeDate\0"
    "insertModelRecoveryModeDate\0object"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_UavModelRecoveryModeDao[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    0,   34,    2, 0x02 /* Public */,
       3,    1,   35,    2, 0x02 /* Public */,
       6,    1,   38,    2, 0x02 /* Public */,
       7,    1,   41,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::QJsonArray,
    QMetaType::Bool, 0x80000000 | 4,    5,
    QMetaType::Bool, 0x80000000 | 4,    5,
    QMetaType::Bool, QMetaType::QJsonObject,    8,

       0        // eod
};

void UavModelRecoveryModeDao::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<UavModelRecoveryModeDao *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { QJsonArray _r = _t->selectModelRecoveryModeAllData();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 1: { bool _r = _t->updateModelRecoveryModeDate((*reinterpret_cast< const QJSValue(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 2: { bool _r = _t->deleteModelRecoveryModeDate((*reinterpret_cast< const QJSValue(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: { bool _r = _t->insertModelRecoveryModeDate((*reinterpret_cast< const QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 1:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QJSValue >(); break;
            }
            break;
        case 2:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QJSValue >(); break;
            }
            break;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject UavModelRecoveryModeDao::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_UavModelRecoveryModeDao.data,
    qt_meta_data_UavModelRecoveryModeDao,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *UavModelRecoveryModeDao::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *UavModelRecoveryModeDao::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_UavModelRecoveryModeDao.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int UavModelRecoveryModeDao::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
