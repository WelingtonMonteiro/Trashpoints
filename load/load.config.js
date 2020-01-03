/**
 * Created by Welington on 29/01/2019.
 */

let env = (process.env.ENV || 'developer');
const opts = {debug: process.env.DEBUG, path: `${ process.cwd()}/env/${env}.env`};
const result = require('dotenv').config(opts);
const colorService = require('../services/log.color.service');

if (result.error) {
    console.error(colorService.FgRed, result.error);
    process.env.ENV = "";
}
console.log("\n\n", colorService.FgGreen, result.parsed);
console.log(colorService.FgBlue);


module.exports = config();

function config() {
    return {
        Db: {
            url: process.env.MONGO_CONNECTION_STRING,
            type: process.env.MONGO_TYPE,
            host: process.env.MONGO_HOST,
            port: process.env.MONGO_PORT,
            dbName: process.env.MONGO_DB_NAME,
            dbNameEvents: process.env.MONGO_DB_NAME_EVENTS,
            psw: process.env.MONGO_DB_PASSWORD,
            user: process.env.MONGO_DB_USER
        }
    };
}
