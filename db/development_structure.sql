CREATE TABLE "accounts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "surname" varchar(255), "email" varchar(255), "crypted_password" varchar(255), "role" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "championships" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "date" date, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "lifters" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "gender" integer, "birthday" date, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "records" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "lifter_id" integer, "championship_id" integer, "equipment" boolean, "weight" float, "squat" float, "benchpress" float, "deadlift" float, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('1');

INSERT INTO schema_migrations (version) VALUES ('2');

INSERT INTO schema_migrations (version) VALUES ('3');

INSERT INTO schema_migrations (version) VALUES ('4');