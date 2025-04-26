/****************************************************************************
** Meta object code from reading C++ file 'ammoguidancetypedao.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../ammoguidancetypedao.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ammoguidancetypedao.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_AmmoGuidanceTypeDao_t {
    QByteArrayData data[10];
    char stringdata0[192];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_AmmoGuidanceTypeDao_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_AmmoGuidanceTypeDao_t qt_meta_stringdata_AmmoGuidanceTypeDao = {
    {
QT_MOC_LITERAL(0, 0, 19), // "AmmoGuidanceTypeDao"
QT_MOC_LITERAL(1, 20, 29), // "selectAmmoGuidanceTypeAllData"
QT_MOC_LITERAL(2, 50, 0), // ""
QT_MOC_LITERAL(3, 51, 30), // "selectSomeAmmoGuidanceTypeData"
QT_MOC_LITERAL(4, 82, 12), // "selectedData"
QT_MOC_LITERAL(5, 95, 26), // "updateAmmoGuidanceTypeData"
QT_MOC_LITERAL(6, 122, 8), // "QJSValue"
QT_MOC_LITERAL(7, 131, 26), // "deleteAmmoGuidanceTypeData"
QT_MOC_LITERAL(8, 158, 26), // "insertAmmoGuidanceTypeData"
QT_MOC_LITERAL(9, 185, 6) // "object"

    },
    "AmmoGuidanceTypeDao\0selectAmmoGuidanceTypeAllData\0"
    "\0selectSomeAmmoGuidanceTypeData\0"
    "selectedData\0updateAmmoGuidanceTypeData\0"
    "QJSValue\0deleteAmmoGuidanceTypeData\0"
    "insertAmmoGuidanceTypeData\0object"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_AmmoGuidanceTypeDao[] = {

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
       7,    1,   46,    2, 0x02 /* Public */,
       8,    1,   49,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::QJsonArray,
    QMetaType::QJsonArray, QMetaType::QJsonObject,    4,
    QMetaType::Bool, 0x80000000 | 6,    4,
    QMetaType::Bool, 0x80000000 | 6,    4,
    QMetaType::Bool, QMetaType::QJsonObject,    9,

       0        // eod
};

void AmmoGuidanceTypeDao::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<AmmoGuidanceTypeDao *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { QJsonArray _r = _t->selectAmmoGuidanceTypeAllData();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 1: { QJsonArray _r = _t->selectSomeAmmoGuidanceTypeData((*reinterpret_cast< const QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 2: { bool _r = _t->updateAmmoGuidanceTypeData((*reinterpret_cast< const QJSValue(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: { bool _r = _t->deleteAmmoGuidanceTypeData((*reinterpret_cast< const QJSValue(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->insertAmmoGuidanceTypeData((*reinterpret_cast< const QJsonObject(*)>(_a[1])));
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

QT_INIT_METAOBJECT const QMetaObject AmmoGuidanceTypeDao::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_AmmoGuidanceTypeDao.data,
    qt_meta_data_AmmoGuidanceTypeDao,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *AmmoGuidanceTypeDao::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *AmmoGuidanceTypeDao::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_AmmoGuidanceTypeDao.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int AmmoGuidanceTypeDao::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
