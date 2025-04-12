#ifndef DATETIME_TRAITS_HXX
#define DATETIME_TRAITS_HXX

#include "odb/core.hxx"
#include "odb/pgsql/traits.hxx"

#include <QDateTime>

namespace odb {
namespace pgsql {
template <>
struct value_traits<QDateTime, id_timestamp>
{
    typedef details::endian_traits endian_traits;

    typedef QDateTime value_type;
    typedef QDateTime query_type;
    typedef unsigned long long image_type;

    static void
    set_value (QDateTime& v, image_type i, bool is_null)
    {
        if (is_null)
            // Default constructor creates a null QDateTime.
            //
            v = QDateTime ();
        else
        {
            const QDateTime pg_epoch (QDate (2000, 1, 1), QTime (0, 0, 0));
            v = pg_epoch.addMSecs (
                static_cast <qint64> (endian_traits::ntoh (i) / 1000LL));
        }
    }

    static void
    set_image (image_type& i, bool& is_null, const QDateTime& v)
    {
        if (v.isNull ())
            is_null = true;
        else
        {
            is_null = false;
            const QDateTime pg_epoch (QDate (2000, 1, 1), QTime (0, 0, 0));
            i = endian_traits::hton (
                static_cast<long long> (pg_epoch.msecsTo (v)) * 1000LL);
        }
    }
};

template <>
struct type_traits<QDateTime>
{
    static const database_type_id db_type_id = id_timestamp;
};
}
}

#endif // DATETIME-TRAITS_HXX
