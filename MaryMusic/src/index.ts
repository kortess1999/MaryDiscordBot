
require('dotenv').config();
import 'reflect-metadata';
import { registerCommands, registerEvents } from './utils/registry';
import config from '../slappey.json';
import DiscordClient from './client/client';
import { GatewayIntentBits } from 'discord.js';
import { getUser } from './database/services/users';
const client = new DiscordClient({ intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages ] });

(async () => {
  client.prefix = config.prefix || client.prefix;
  await registerCommands(client, '../commands');
  await registerEvents(client, '../events');
  await client.login(process.env.BOT_TOKEN); // At the first start, add BOT_TOKEN to .env file

  const user = await getUser('test@mail.ru');
  console.log('user =', user);
})();

