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

DROP TABLE IF EXISTS "public"."Account";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."Account" (
    "id" text NOT NULL,
    "userId" text NOT NULL,
    "type" text NOT NULL,
    "provider" text NOT NULL,
    "providerAccountId" text NOT NULL,
    "refresh_token" text,
    "access_token" text,
    "expires_at" int4,
    "token_type" text,
    "scope" text,
    "id_token" text,
    "session_state" text,
    CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
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
    CONSTRAINT "Order_userEmail_fkey" FOREIGN KEY ("userEmail") REFERENCES "public"."User"("email") ON DELETE RESTRICT ON UPDATE CASCADE,
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

DROP TABLE IF EXISTS "public"."Session";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."Session" (
    "id" text NOT NULL,
    "sessionToken" text NOT NULL,
    "userId" text NOT NULL,
    "expires" timestamp(3) NOT NULL,
    CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."User";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."User" (
    "id" text NOT NULL,
    "name" text,
    "email" text,
    "emailVerified" timestamp(3),
    "image" text,
    "isAdmin" bool NOT NULL DEFAULT false,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."VerificationToken";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."VerificationToken" (
    "identifier" text NOT NULL,
    "token" text NOT NULL,
    "expires" timestamp(3) NOT NULL
);

INSERT INTO "public"."_prisma_migrations" ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES
('ec448165-231b-46cf-8993-57265586bdaf', '97fa17897505e22611f397d1cad685a54143c6865f0917a6f70c3ceafdf30b97', '2023-11-27 07:38:49.305827+00', '20231127073849_one', NULL, NULL, '2023-11-27 07:38:49.163592+00', 1);
INSERT INTO "public"."_prisma_migrations" ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES
('17473373-4b18-4bdc-a3d3-35c062ea6ebf', '7d26630419b588bb14cb9e5b538e36c08e62e291502ee58761599e1eb0fd1e52', '2023-11-27 09:28:52.824579+00', '20231127092852_add_user', NULL, NULL, '2023-11-27 09:28:52.755021+00', 1);
INSERT INTO "public"."_prisma_migrations" ("id", "checksum", "finished_at", "migration_name", "logs", "rolled_back_at", "started_at", "applied_steps_count") VALUES
('f8b1641a-00c3-413e-8624-f5b0cc6c4152', '41350161ccfa223f3847fa25fd01c25bda12a903cec40e3258d93ffd7c314159', '2023-11-27 10:09:55.721943+00', '20231127100955_add_user_to_order', NULL, NULL, '2023-11-27 10:09:55.705068+00', 1);

INSERT INTO "public"."Account" ("id", "userId", "type", "provider", "providerAccountId", "refresh_token", "access_token", "expires_at", "token_type", "scope", "id_token", "session_state") VALUES
('clpgpuqoq0002rag0sjeul7qy', 'clpgpuqoh0000rag0ocyilvi4', 'oauth', 'google', '111140968321241309812', NULL, 'ya29.a0AfB_byAe1_CQ8hPlsNQyISauZrqBC6fotDDIaCvX_P3jwWjJpkTnEWICyNcfh585Cwcv4-nGlwUTdy7KVNwr72hqQA5Nw4qaJ_My605e9K8D96zf6iQtBa2I1kYSFZrIrL10C3htJtKccRUCK3M4rQ3TRFowcjWAhWMaCgYKAf4SARASFQHGX2Mi4A1NG_F4esWO13ylIz0AAQ0170', 1701081486, 'Bearer', 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email openid', 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjBlNzJkYTFkZjUwMWNhNmY3NTZiZjEwM2ZkN2M3MjAyOTQ3NzI1MDYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI2ODA1ODg0OTEzNzgtbjdnZWZsbWFqYWI5M2N1dnVhaG9yY2lvdGY4NG50M28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI2ODA1ODg0OTEzNzgtbjdnZWZsbWFqYWI5M2N1dnVhaG9yY2lvdGY4NG50M28uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTExNDA5NjgzMjEyNDEzMDk4MTIiLCJlbWFpbCI6ImJkc3Rob2N1MjBAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiJJLVFXWDQ1VWR0THhJSVN0VkZwdUZ3IiwibmFtZSI6ImJkcyBzZyIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NMUzVKS3FfWklBQlQ4U21ISy02Y3BTYkxTZHA1a1JoWG0wN0RpT2FseC09czk2LWMiLCJnaXZlbl9uYW1lIjoiYmRzIiwiZmFtaWx5X25hbWUiOiJzZyIsImxvY2FsZSI6InZpIiwiaWF0IjoxNzAxMDc3ODg3LCJleHAiOjE3MDEwODE0ODd9.m7qBzgPCTHTrv05bnY1PgsjOFQxr9YHZYPV8qTCG3g4S7Qgqz1k_h1658KKcQQ_QgJL972FlRJPnvxq_or3CTjJC_MS9JHxq1c-mKo9CZ_fnYZF4jumW3EZgXXx6GHvo85LaHZnzd2xxm3TcsQfoWRWykqDgl76ay_q5lMqSmtmoI4GFRd5KQgsgJI1bOLHSX7Rqx1PEvhFcFMbEGT85Sg0T1D5jtkwVS57sIpDg-xZURNPxXPTf8_n2qyNL9kG1Th7g9eN-xLRfoQ1ofagHH2F1ncMkxJJBOB5lVoO40DqTekzMK3XJdp2l3sq-9bwOTakriwFRCXwKqP_jljJo_w', NULL);


INSERT INTO "public"."Category" ("id", "createdAt", "title", "desc", "color", "img", "slug") VALUES
('clpglrjje0000ram0tbgbo66p', '2023-11-27 07:43:40.202', 'Italian Pastas', 'Savor the taste of perfection with our exquisite Italian handmade pasta menu.', 'white', '/temporary/m1.png', 'pastas');
INSERT INTO "public"."Category" ("id", "createdAt", "title", "desc", "color", "img", "slug") VALUES
('clpglrjje0001ram0nqjvdqzr', '2023-11-27 07:43:40.202', 'Juicy Burgers', 'Burger Bliss: Juicy patties, bold flavors, and gourmet toppings galore.', 'black', '/temporary/m2.png', 'burgers');
INSERT INTO "public"."Category" ("id", "createdAt", "title", "desc", "color", "img", "slug") VALUES
('clpglrjje0002ram0isknivcp', '2023-11-27 07:43:40.202', 'Cheesy Pizzas', 'Pizza Paradise: Irresistible slices, mouthwatering toppings, and cheesy perfection.', 'white', '/temporary/m3.png', 'pizzas');

INSERT INTO "public"."Order" ("id", "createdAt", "price", "products", "status", "intent_id", "userEmail") VALUES
('clpgrgqmm0000rah4p338bk7b', '2023-11-27 10:23:13.871', 111.000000000000000000000000000000, '{"{\"title\": \"pizza1\"}"}', 'prepared', NULL, 'bdsthocu20@gmail.com');
INSERT INTO "public"."Order" ("id", "createdAt", "price", "products", "status", "intent_id", "userEmail") VALUES
('clpgrpvgl0000ral43pg1q97j', '2023-11-27 10:30:20.037', 222.000000000000000000000000000000, '{"{\"title\": \"burger1\"}"}', 'delivered', NULL, 'user@gmail.com');


INSERT INTO "public"."Product" ("id", "createdAt", "title", "desc", "img", "price", "isFeatured", "options", "catSlug") VALUES
('clpgm0gq70004ram0hc32q2cz', '2023-11-27 07:50:36.46', 'pizzas2', 'pizzas2 desc', NULL, 33.000000000000000000000000000000, 'f', '{}', 'pizzas');
INSERT INTO "public"."Product" ("id", "createdAt", "title", "desc", "img", "price", "isFeatured", "options", "catSlug") VALUES
('clpgm0gq70005ram0337n8pm1', '2023-11-27 07:50:36.46', 'burgers', 'burgers desc', NULL, 55.000000000000000000000000000000, 't', '{}', 'burgers');
INSERT INTO "public"."Product" ("id", "createdAt", "title", "desc", "img", "price", "isFeatured", "options", "catSlug") VALUES
('clpgm0gq30003ram0qqcdtx3j', '2023-11-27 07:50:36.46', 'Sicilian', 'Ignite your taste buds with a fiery combination of spicy pepperoni, jalapeños, crushed red pepper flakes, and melted mozzarella cheese, delivering a kick with every bite.', '/temporary/p1.png', 24.600000000000000000000000000000, 't', '{"{\"title\": \"Small\", \"additionalPrice\": 0}","{\"title\": \"Medium\", \"additionalPrice\": 4}","{\"title\": \"Large\", \"additionalPrice\": 6}"}', 'pizzas');

INSERT INTO "public"."Session" ("id", "sessionToken", "userId", "expires") VALUES
('clpgpveee0006rag0s4oc2ji8', '5157a86e-6e39-48ed-8d4f-50417aef8811', 'clpgpuqoh0000rag0ocyilvi4', '2023-12-27 09:38:38.623');


INSERT INTO "public"."User" ("id", "name", "email", "emailVerified", "image", "isAdmin") VALUES
('clpgrlbej0002ra2sh5fyg1na', 'regular user', 'user@gmail.com', NULL, NULL, 'f');
INSERT INTO "public"."User" ("id", "name", "email", "emailVerified", "image", "isAdmin") VALUES
('clpgpuqoh0000rag0ocyilvi4', 'bds sg', 'bdsthocu20@gmail.com', NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLS5JKq_ZIABT8SmHK-6cpSbLSdp5kRhXm07DiOalx-=s96-c', 't');



