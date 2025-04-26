/****************************************************************************
** Meta object code from reading C++ file 'uavmountlocationdao.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../uavmountlocationdao.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'uavmountlocationdao.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_UavMountLocationDao_t {
    QByteArrayData data[11];
    char stringdata0[190];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_UavMountLocationDao_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_UavMountLocationDao_t qt_meta_stringdata_UavMountLocationDao = {
    {
QT_MOC_LITERAL(0, 0, 19), // "UavMountLocationDao"
QT_MOC_LITERAL(1, 20, 29), // "selectUavMountLocationAllData"
QT_MOC_LITERAL(2, 50, 0), // ""
QT_MOC_LITERAL(3, 51, 19), // "queryUavToMountData"
QT_MOC_LITERAL(4, 71, 8), // "uavModel"
QT_MOC_LITERAL(5, 80, 26), // "updateUavMountLocationDate"
QT_MOC_LITERAL(6, 107, 8), // "QJSValue"
QT_MOC_LITERAL(7, 116, 12), // "selectedData"
QT_MOC_LITERAL(8, 129, 26), // "deleteUavMountLocationDate"
QT_MOC_LITERAL(9, 156, 26), // "insertUavMountLocationDate"
QT_MOC_LITERAL(10, 183, 6) // "object"

    },
    "UavMountLocationDao\0selectUavMountLocationAllData\0"
    "\0queryUavToMountData\0uavModel\0"
    "updateUavMountLocationDate\0QJSValue\0"
    "selectedData\0deleteUavMountLocationDate\0"
    "insertUavMountLocationDate\0object"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_UavMountLocationDao[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    0,   39,    2, 0x02 /* Public */,
       3,    1,   40,    2, 0x02 /* Public */,
       5,    1,   43,    2, 0x02 /* Public */,
       8,    1,   46,    2, 0x02 /* Public */,
       9,    1,   49,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::QJsonArray,
    QMetaType::QJsonArray, QMetaType::QJsonObject,    4,
    QMetaType::Bool, 0x80000000 | 6,    7,
    QMetaType::Bool, 0x80000000 | 6,    7,
    QMetaType::Bool, QMetaType::QJsonObject,   10,

       0        // eod
};

void UavMountLocationDao::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<UavMountLocationDao *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { QJsonArray _r = _t->selectUavMountLocationAllData();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 1: { QJsonArray _r = _t->queryUavToMountData((*reinterpret_cast< const QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 2: { bool _r = _t->updateUavMountLocationDate((*reinterpret_cast< const QJSValue(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: { bool _r = _t->deleteUavMountLocationDate((*reinterpret_cast< const QJSValue(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->insertUavMountLocationDate((*reinterpret_cast< const QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 2:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QJSValue >(); break;
            }
            break;
        case 3:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QJSValue >(); break;
            }
            break;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject UavMountLocationDao::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_UavMountLocationDao.data,
    qt_meta_data_UavMountLocationDao,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *UavMountLocationDao::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *UavMountLocationDao::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_UavMountLocationDao.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int UavMountLocationDao::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
