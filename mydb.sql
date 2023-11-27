DROP TABLE IF EXISTS "public"."_prisma_migrations";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."_prisma_migrations" (
    "id" varchar(36) NOT NULL,
    "checksum" varchar(64) NOT NULL,
    "finished_at" timestamptz,
    "migration_name" varchar(255) NOT NULL,
    "logs" text,
    "rolled_back_at" timestamptz,
    "started_at" timestamptz NOT NULL DEFAULT now(),
    "applied_steps_count" int4 NOT NULL DEFAULT 0,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."Category";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."Category" (
    "id" text NOT NULL,
    "createdAt" timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" text NOT NULL,
    "desc" text NOT NULL,
    "color" text NOT NULL,
    "img" text NOT NULL,
    "slug" text NOT NULL,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."Order";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."Order" (
    "id" text NOT NULL,
    "createdAt" timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "price" numeric(65,30) NOT NULL,
    "products" _jsonb,
    "status" text NOT NULL,
    "intent_id" text,
    "userEmail" text NOT NULL,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."Product";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."Product" (
    "id" text NOT NULL,
    "createdAt" timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" text NOT NULL,
    "desc" text NOT NULL,
    "img" text,
    "price" numeric(65,30) NOT NULL,
    "isFeatured" bool NOT NULL DEFAULT false,
    "options" _jsonb,
    "catSlug" text NOT NULL,
    CONSTRAINT "Product_catSlug_fkey" FOREIGN KEY ("catSlug") REFERENCES "public"."Category"("slug") ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."_prisma_migrations" ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES
('ec448165-231b-46cf-8993-57265586bdaf', '97fa17897505e22611f397d1cad685a54143c6865f0917a6f70c3ceafdf30b97', '2023-11-27 07:38:49.305827+00', '20231127073849_one', NULL, NULL, '2023-11-27 07:38:49.163592+00', 1);


INSERT INTO "public"."Category" ("id", "createdAt", "title", "desc", "color", "img", "slug") VALUES
('clpglrjje0000ram0tbgbo66p', '2023-11-27 07:43:40.202', 'Italian Pastas', 'Savor the taste of perfection with our exquisite Italian handmade pasta menu.', 'white', '/temporary/m1.png', 'pastas');
INSERT INTO "public"."Category" ("id", "createdAt", "title", "desc", "color", "img", "slug") VALUES
('clpglrjje0001ram0nqjvdqzr', '2023-11-27 07:43:40.202', 'Juicy Burgers', 'Burger Bliss: Juicy patties, bold flavors, and gourmet toppings galore.', 'black', '/temporary/m2.png', 'burgers');
INSERT INTO "public"."Category" ("id", "createdAt", "title", "desc", "color", "img", "slug") VALUES
('clpglrjje0002ram0isknivcp', '2023-11-27 07:43:40.202', 'Cheesy Pizzas', 'Pizza Paradise: Irresistible slices, mouthwatering toppings, and cheesy perfection.', 'white', '/temporary/m3.png', 'pizzas');



INSERT INTO "public"."Product" ("id", "createdAt", "title", "desc", "img", "price", "isFeatured", "options", "catSlug") VALUES
('clpgm0gq30003ram0qqcdtx3j', '2023-11-27 07:50:36.46', 'pizzas1', 'pizzas1 desc', NULL, 22.000000000000000000000000000000, 't', '{}', 'pizzas');
INSERT INTO "public"."Product" ("id", "createdAt", "title", "desc", "img", "price", "isFeatured", "options", "catSlug") VALUES
('clpgm0gq70004ram0hc32q2cz', '2023-11-27 07:50:36.46', 'pizzas2', 'pizzas2 desc', NULL, 33.000000000000000000000000000000, 'f', '{}', 'pizzas');
INSERT INTO "public"."Product" ("id", "createdAt", "title", "desc", "img", "price", "isFeatured", "options", "catSlug") VALUES
('clpgm0gq70005ram0337n8pm1', '2023-11-27 07:50:36.46', 'burgers', 'burgers desc', NULL, 55.000000000000000000000000000000, 't', '{}', 'burgers');
