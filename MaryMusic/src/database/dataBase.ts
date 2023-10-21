import createConnectionPool, { sql } from '@databases/pg';
import tables from '@databases/pg-typed';
import DatabaseSchema from '../__generated__';
import 'reflect-metadata';

export { sql };

const db = createConnectionPool(process.env.DB_CONNECTION_STRING);
export default db;

// You can list whatever tables you actually have here:
const { users } = tables<DatabaseSchema>({
    databaseSchema: require('../__generated__/schema.json'),
});
export { users };