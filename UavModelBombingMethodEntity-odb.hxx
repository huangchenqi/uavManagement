// This file was generated by ODB, object-relational mapping (ORM)
// compiler for C++.
//

#ifndef UAV_MODEL_BOMBING_METHOD_ENTITY_ODB_HXX
#define UAV_MODEL_BOMBING_METHOD_ENTITY_ODB_HXX

#include <odb/version.hxx>

#if (ODB_VERSION != 20400UL)
#error ODB runtime version mismatch
#endif

#include <odb/pre.hxx>

#include "UavModelBombingMethodEntity.h"

#include <memory>
#include <cstddef>

#include <odb/core.hxx>
#include <odb/traits.hxx>
#include <odb/callback.hxx>
#include <odb/wrapper-traits.hxx>
#include <odb/pointer-traits.hxx>
#include <odb/container-traits.hxx>
#include <odb/session.hxx>
#include <odb/cache-traits.hxx>
#include <odb/result.hxx>
#include <odb/simple-object-result.hxx>

#include <odb/details/unused.hxx>
#include <odb/details/shared-ptr.hxx>

namespace odb
{
  // UavModelBombingMethodEntity
  //
  template <>
  struct class_traits< ::UavModelBombingMethodEntity >
  {
    static const class_kind kind = class_object;
  };

  template <>
  class access::object_traits< ::UavModelBombingMethodEntity >
  {
    public:
    typedef ::UavModelBombingMethodEntity object_type;
    typedef ::UavModelBombingMethodEntity* pointer_type;
    typedef odb::pointer_traits<pointer_type> pointer_traits;

    static const bool polymorphic = false;

    typedef long int id_type;

    static const bool auto_id = true;

    static const bool abstract = false;

    static id_type
    id (const object_type&);

    typedef
    odb::pointer_cache_traits<
      pointer_type,
      odb::session >
    pointer_cache_traits;

    typedef
    odb::reference_cache_traits<
      object_type,
      odb::session >
    reference_cache_traits;

    static void
    callback (database&, object_type&, callback_event);

    static void
    callback (database&, const object_type&, callback_event);
  };
}

#include <odb/details/buffer.hxx>

#include <odb/pgsql/version.hxx>
#include <odb/pgsql/forward.hxx>
#include <odb/pgsql/binding.hxx>
#include <odb/pgsql/pgsql-types.hxx>
#include <odb/pgsql/query.hxx>

namespace odb
{
  // UavModelBombingMethodEntity
  //
  template <typename A>
  struct query_columns< ::UavModelBombingMethodEntity, id_pgsql, A >
  {
    // id
    //
    typedef
    pgsql::query_column<
      pgsql::value_traits<
        long int,
        pgsql::id_bigint >::query_type,
      pgsql::id_bigint >
    id_type_;

    static const id_type_ id;

    // bombingMethodCode
    //
    typedef
    pgsql::query_column<
      pgsql::value_traits<
        ::std::string,
        pgsql::id_string >::query_type,
      pgsql::id_string >
    bombingMethodCode_type_;

    static const bombingMethodCode_type_ bombingMethodCode;

    // bombingMethodName
    //
    typedef
    pgsql::query_column<
      pgsql::value_traits<
        ::std::string,
        pgsql::id_string >::query_type,
      pgsql::id_string >
    bombingMethodName_type_;

    static const bombingMethodName_type_ bombingMethodName;
  };

  template <typename A>
  const typename query_columns< ::UavModelBombingMethodEntity, id_pgsql, A >::id_type_
  query_columns< ::UavModelBombingMethodEntity, id_pgsql, A >::
  id (A::table_name, "\"id\"", 0);

  template <typename A>
  const typename query_columns< ::UavModelBombingMethodEntity, id_pgsql, A >::bombingMethodCode_type_
  query_columns< ::UavModelBombingMethodEntity, id_pgsql, A >::
  bombingMethodCode (A::table_name, "\"bombingway_code\"", 0);

  template <typename A>
  const typename query_columns< ::UavModelBombingMethodEntity, id_pgsql, A >::bombingMethodName_type_
  query_columns< ::UavModelBombingMethodEntity, id_pgsql, A >::
  bombingMethodName (A::table_name, "\"bombingway_name\"", 0);

  template <typename A>
  struct pointer_query_columns< ::UavModelBombingMethodEntity, id_pgsql, A >:
    query_columns< ::UavModelBombingMethodEntity, id_pgsql, A >
  {
  };

  template <>
  class access::object_traits_impl< ::UavModelBombingMethodEntity, id_pgsql >:
    public access::object_traits< ::UavModelBombingMethodEntity >
  {
    public:
    struct id_image_type
    {
      long long id_value;
      bool id_null;

      std::size_t version;
    };

    struct image_type
    {
      // id_
      //
      long long id_value;
      bool id_null;

      // bombingMethodCode_
      //
      details::buffer bombingMethodCode_value;
      std::size_t bombingMethodCode_size;
      bool bombingMethodCode_null;

      // bombingMethodName_
      //
      details::buffer bombingMethodName_value;
      std::size_t bombingMethodName_size;
      bool bombingMethodName_null;

      std::size_t version;
    };

    struct extra_statement_cache_type;

    using object_traits<object_type>::id;

    static id_type
    id (const id_image_type&);

    static id_type
    id (const image_type&);

    static bool
    grow (image_type&,
          bool*);

    static void
    bind (pgsql::bind*,
          image_type&,
          pgsql::statement_kind);

    static void
    bind (pgsql::bind*, id_image_type&);

    static bool
    init (image_type&,
          const object_type&,
          pgsql::statement_kind);

    static void
    init (object_type&,
          const image_type&,
          database*);

    static void
    init (id_image_type&, const id_type&);

    typedef pgsql::object_statements<object_type> statements_type;

    typedef pgsql::query_base query_base_type;

    static const std::size_t column_count = 3UL;
    static const std::size_t id_column_count = 1UL;
    static const std::size_t inverse_column_count = 0UL;
    static const std::size_t readonly_column_count = 0UL;
    static const std::size_t managed_optimistic_column_count = 0UL;

    static const std::size_t separate_load_column_count = 0UL;
    static const std::size_t separate_update_column_count = 0UL;

    static const bool versioned = false;

    static const char persist_statement[];
    static const char find_statement[];
    static const char update_statement[];
    static const char erase_statement[];
    static const char query_statement[];
    static const char erase_query_statement[];

    static const char table_name[];

    static void
    persist (database&, object_type&);

    static pointer_type
    find (database&, const id_type&);

    static bool
    find (database&, const id_type&, object_type&);

    static bool
    reload (database&, object_type&);

    static void
    update (database&, const object_type&);

    static void
    erase (database&, const id_type&);

    static void
    erase (database&, const object_type&);

    static result<object_type>
    query (database&, const query_base_type&);

    static unsigned long long
    erase_query (database&, const query_base_type&);

    static const char persist_statement_name[];
    static const char find_statement_name[];
    static const char update_statement_name[];
    static const char erase_statement_name[];
    static const char query_statement_name[];
    static const char erase_query_statement_name[];

    static const unsigned int persist_statement_types[];
    static const unsigned int find_statement_types[];
    static const unsigned int update_statement_types[];

    public:
    static bool
    find_ (statements_type&,
           const id_type*);

    static void
    load_ (statements_type&,
           object_type&,
           bool reload);
  };

  template <>
  class access::object_traits_impl< ::UavModelBombingMethodEntity, id_common >:
    public access::object_traits_impl< ::UavModelBombingMethodEntity, id_pgsql >
  {
  };

  // UavModelBombingMethodEntity
  //
}

#include "UavModelBombingMethodEntity-odb.ixx"

#include <odb/post.hxx>

#endif // UAV_MODEL_BOMBING_METHOD_ENTITY_ODB_HXX
