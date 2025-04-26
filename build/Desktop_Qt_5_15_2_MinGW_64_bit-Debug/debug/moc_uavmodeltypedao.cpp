/****************************************************************************
** Meta object code from reading C++ file 'uavmodeltypedao.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../uavmodeltypedao.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'uavmodeltypedao.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_UavModelTypeDao_t {
    QByteArrayData data[12];
    char stringdata0[195];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_UavModelTypeDao_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_UavModelTypeDao_t qt_meta_stringdata_UavModelTypeDao = {
    {
QT_MOC_LITERAL(0, 0, 15), // "UavModelTypeDao"
QT_MOC_LITERAL(1, 16, 25), // "selectUavModelTypeAllData"
QT_MOC_LITERAL(2, 42, 0), // ""
QT_MOC_LITERAL(3, 43, 22), // "selectUavModelTypeData"
QT_MOC_LITERAL(4, 66, 21), // "queryUavModelTypeData"
QT_MOC_LITERAL(5, 88, 8), // "uavModel"
QT_MOC_LITERAL(6, 97, 22), // "updateUavModelTypeData"
QT_MOC_LITERAL(7, 120, 8), // "QJSValue"
QT_MOC_LITERAL(8, 129, 12), // "selectedData"
QT_MOC_LITERAL(9, 142, 22), // "deleteUavModelTypeData"
QT_MOC_LITERAL(10, 165, 22), // "insertUavModelTypeData"
QT_MOC_LITERAL(11, 188, 6) // "object"

    },
    "UavModelTypeDao\0selectUavModelTypeAllData\0"
    "\0selectUavModelTypeData\0queryUavModelTypeData\0"
    "uavModel\0updateUavModelTypeData\0"
    "QJSValue\0selectedData\0deleteUavModelTypeData\0"
    "insertUavModelTypeData\0object"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_UavModelTypeDao[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    0,   44,    2, 0x02 /* Public */,
       3,    0,   45,    2, 0x02 /* Public */,
       4,    1,   46,    2, 0x02 /* Public */,
       6,    1,   49,    2, 0x02 /* Public */,
       9,    1,   52,    2, 0x02 /* Public */,
      10,    1,   55,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::QJsonArray,
    QMetaType::QJsonArray,
    QMetaType::QJsonArray, QMetaType::QJsonObject,    5,
    QMetaType::Bool, 0x80000000 | 7,    8,
    QMetaType::Bool, 0x80000000 | 7,    8,
    QMetaType::Bool, QMetaType::QJsonObject,   11,

       0        // eod
};

void UavModelTypeDao::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<UavModelTypeDao *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { QJsonArray _r = _t->selectUavModelTypeAllData();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 1: { QJsonArray _r = _t->selectUavModelTypeData();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 2: { QJsonArray _r = _t->queryUavModelTypeData((*reinterpret_cast< const QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 3: { bool _r = _t->updateUavModelTypeData((*reinterpret_cast< const QJSValue(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->deleteUavModelTypeData((*reinterpret_cast< const QJSValue(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 5: { bool _r = _t->insertUavModelTypeData((*reinterpret_cast< const QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 3:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QJSValue >(); break;
            }
            break;
        case 4:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QJSValue >(); break;
            }
            break;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject UavModelTypeDao::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_UavModelTypeDao.data,
    qt_meta_data_UavModelTypeDao,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *UavModelTypeDao::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *UavModelTypeDao::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_UavModelTypeDao.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int UavModelTypeDao::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
