/****************************************************************************
** Meta object code from reading C++ file 'uavmodeldao.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../uavmodeldao.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'uavmodeldao.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_UavModelDao_t {
    QByteArrayData data[17];
    char stringdata0[242];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_UavModelDao_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_UavModelDao_t qt_meta_stringdata_UavModelDao = {
    {
QT_MOC_LITERAL(0, 0, 11), // "UavModelDao"
QT_MOC_LITERAL(1, 12, 21), // "selectUavModelAllData"
QT_MOC_LITERAL(2, 34, 0), // ""
QT_MOC_LITERAL(3, 35, 17), // "queryUavModelData"
QT_MOC_LITERAL(4, 53, 7), // "jsonStr"
QT_MOC_LITERAL(5, 61, 21), // "queryUavModelPartData"
QT_MOC_LITERAL(6, 83, 21), // "transformQueryAllData"
QT_MOC_LITERAL(7, 105, 11), // "processData"
QT_MOC_LITERAL(8, 117, 6), // "aArray"
QT_MOC_LITERAL(9, 124, 22), // "QHash<QString,QString>"
QT_MOC_LITERAL(10, 147, 5), // "idMap"
QT_MOC_LITERAL(11, 153, 22), // "selectSomeUavModelDate"
QT_MOC_LITERAL(12, 176, 15), // "updateModelDate"
QT_MOC_LITERAL(13, 192, 15), // "deleteModelDate"
QT_MOC_LITERAL(14, 208, 6), // "object"
QT_MOC_LITERAL(15, 215, 15), // "insertModelDate"
QT_MOC_LITERAL(16, 231, 10) // "objectData"

    },
    "UavModelDao\0selectUavModelAllData\0\0"
    "queryUavModelData\0jsonStr\0"
    "queryUavModelPartData\0transformQueryAllData\0"
    "processData\0aArray\0QHash<QString,QString>\0"
    "idMap\0selectSomeUavModelDate\0"
    "updateModelDate\0deleteModelDate\0object\0"
    "insertModelDate\0objectData"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_UavModelDao[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    0,   59,    2, 0x02 /* Public */,
       3,    1,   60,    2, 0x02 /* Public */,
       5,    0,   63,    2, 0x02 /* Public */,
       6,    0,   64,    2, 0x02 /* Public */,
       7,    2,   65,    2, 0x02 /* Public */,
      11,    1,   70,    2, 0x02 /* Public */,
      12,    1,   73,    2, 0x02 /* Public */,
      13,    1,   76,    2, 0x02 /* Public */,
      15,    1,   79,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::QJsonArray,
    QMetaType::QJsonArray, QMetaType::QString,    4,
    QMetaType::QJsonArray,
    QMetaType::QJsonArray,
    QMetaType::QJsonArray, QMetaType::QJsonArray, 0x80000000 | 9,    8,   10,
    QMetaType::QJsonObject, QMetaType::QString,    4,
    QMetaType::Bool, QMetaType::QString,    4,
    QMetaType::Bool, QMetaType::QJsonArray,   14,
    QMetaType::Bool, QMetaType::QJsonObject,   16,

       0        // eod
};

void UavModelDao::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<UavModelDao *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { QJsonArray _r = _t->selectUavModelAllData();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 1: { QJsonArray _r = _t->queryUavModelData((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 2: { QJsonArray _r = _t->queryUavModelPartData();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 3: { QJsonArray _r = _t->transformQueryAllData();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 4: { QJsonArray _r = _t->processData((*reinterpret_cast< const QJsonArray(*)>(_a[1])),(*reinterpret_cast< const QHash<QString,QString>(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 5: { QJsonObject _r = _t->selectSomeUavModelDate((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 6: { bool _r = _t->updateModelDate((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 7: { bool _r = _t->deleteModelDate((*reinterpret_cast< const QJsonArray(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 8: { bool _r = _t->insertModelDate((*reinterpret_cast< const QJsonObject(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject UavModelDao::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_UavModelDao.data,
    qt_meta_data_UavModelDao,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *UavModelDao::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *UavModelDao::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_UavModelDao.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int UavModelDao::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 9)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 9;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
