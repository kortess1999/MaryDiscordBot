# MaryDiscordBot
Discord music bot via Nest.js, PostgreSQL inside Docker containers. 
For this project you have to install:
Yarn 1.22.19
Node v18.12.1
npm 9.2.0

Instalation guide:

DB service generation:
* npx @databases/pg-schema-cli --database postgres://postgres:postgres@localhost:5432/mary --directory src/__generated__  
