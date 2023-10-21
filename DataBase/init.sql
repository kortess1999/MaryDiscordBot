--drop database jira;
CREATE DATABASE mary;
GRANT ALL PRIVILEGES ON DATABASE mary TO postgres;

\connect mary;

CREATE TABLE "channel_user_permission"(
    "channel_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "permission_type" BIGINT NOT NULL,
    "enabled" BOOLEAN NOT NULL
);
ALTER TABLE "channel_user_permission" ADD PRIMARY KEY("channel_id", "user_id", "permission_type");

CREATE TABLE "channels"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "link" TEXT NOT NULL,
    "external_id" BIGINT NOT NULL
);
ALTER TABLE
    "channels" ADD PRIMARY KEY("id");
ALTER TABLE
    "channels" ADD CONSTRAINT "channels_external_id_unique" UNIQUE("external_id");
CREATE TABLE "permission_types"(
    "permission_type" VARCHAR(200) NOT NULL,
    "description" VARCHAR(200) NOT NULL
);
ALTER TABLE
    "permission_types" ADD PRIMARY KEY("permission_type");
CREATE TABLE "playlist_song"(
    "id" BIGINT NOT NULL,
    "service_id" BIGINT NOT NULL,
    "playlist_id" BIGINT NOT NULL,
    "link" TEXT NOT NULL,
    "displayed_name" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "playlist_song" ADD PRIMARY KEY("id");
CREATE TABLE "music_services"(
    "id" BIGINT NOT NULL,
    "code_name" VARCHAR(255) NOT NULL,
    "full_name" TEXT NOT NULL,
    "url" TEXT NOT NULL
);
ALTER TABLE
    "music_services" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "music_services"."code_name" IS 'service code name according to backend code';
COMMENT
ON COLUMN
    "music_services"."full_name" IS 'displayed name';
CREATE TABLE "playlists"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "playlists" ADD PRIMARY KEY("id");
CREATE TABLE "users"(
    "id" BIGINT NOT NULL,
    "url" TEXT NOT NULL,
    "external_id" BIGINT NULL
);
ALTER TABLE
    "users" ADD PRIMARY KEY("id");
ALTER TABLE
    "users" ADD CONSTRAINT "users_external_id_unique" UNIQUE("external_id");
ALTER TABLE
    "channel_user_permission" ADD CONSTRAINT "channel_user_permission_permission_type_foreign" FOREIGN KEY("permission_type") REFERENCES "permission_types"("permission_type");
ALTER TABLE
    "channel_user_permission" ADD CONSTRAINT "channel_user_permission_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "playlist_song" ADD CONSTRAINT "playlist_song_playlist_id_foreign" FOREIGN KEY("playlist_id") REFERENCES "playlists"("id");
ALTER TABLE
    "channel_user_permission" ADD CONSTRAINT "channel_user_permission_channel_id_foreign" FOREIGN KEY("channel_id") REFERENCES "channels"("id");
ALTER TABLE
    "playlists" ADD CONSTRAINT "playlists_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "playlist_song" ADD CONSTRAINT "playlist_song_service_id_foreign" FOREIGN KEY("service_id") REFERENCES "music_services"("id");