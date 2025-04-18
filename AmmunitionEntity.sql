/* This file was generated by ODB, object-relational mapping (ORM)
 * compiler for C++.
 */

DROP TABLE IF EXISTS "uav_type_man"."ammo_parameters" CASCADE;

CREATE TABLE "uav_type_man"."ammo_parameters" (
  "id" BIGSERIAL NOT NULL PRIMARY KEY,
  "ammo_type" TEXT NOT NULL,
  "ammo_name" TEXT NOT NULL,
  "ammo_id" TEXT NOT NULL,
  "ammo_to_uavmodel" TEXT NOT NULL,
  "length" REAL NOT NULL,
  "width" REAL NOT NULL,
  "weight" REAL NOT NULL,
  "guidance_type" TEXT NOT NULL,
  "launch_height_min" REAL NOT NULL,
  "launch_height_max" REAL NOT NULL,
  "launch_distance_min" REAL NOT NULL,
  "launch_distance_max" REAL NOT NULL,
  "launch_angle" REAL NOT NULL,
  "launch_method" TEXT NOT NULL,
  "approve_attack_target_type" TEXT NOT NULL,
  "killing_dose" REAL NOT NULL,
  "killing_method" TEXT NOT NULL,
  "killing_depth" REAL NOT NULL,
  "killing_range_min" REAL NOT NULL,
  "killing_range_max" REAL NOT NULL,
  "recordcreation_time" timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "image_url" TEXT NOT NULL,
  "image_name" REAL NOT NULL);

