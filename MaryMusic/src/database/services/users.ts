import db, { users } from '../dataBase';

// async function insertUser(email: string) {
//     await users(db).insert({ email });
// }

// async function updateUser(email: string, favoriteColor: string) {
//     await users(db).update({ email }, { favorite_color: favoriteColor });
// }

// async function deleteUser(email: string) {
//     await users(db).delete({ email });
// }

export async function getUser(email: string) {
    return await users(db).findOne({ email });
}

async function run() {

    const user = await getUser('test@mail.ru');
    console.log('user =', user);

    // await deleteUser('me@example.com');

    // await db.dispose();
}

run().catch((err) => {
    console.error(err);
    process.exit(1);
});