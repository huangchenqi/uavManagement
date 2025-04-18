/* This file was generated by ODB, object-relational mapping (ORM)
 * compiler for C++.
 */

DROP TABLE IF EXISTS "uav_type_man"."uav_model_mount_location" CASCADE;

CREATE TABLE "uav_type_man"."uav_model_mount_location" (
  "id" BIGSERIAL NOT NULL PRIMARY KEY,
  "mountlocation_code" INTEGER NOT NULL,
  "mountlocation_name" TEXT NOT NULL,
  "mountlocation_quantity" REAL NOT NULL,
  "mountlocation_capacity" REAL NOT NULL,
  "uavmodel_name" TEXT NOT NULL);

