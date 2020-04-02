/**
 * Created by Welington on 29/01/2019.
 */

delete process.env.DEBUG_FD;

const mongoose = require('mongoose');
const Config = require('./load.config');

const options = {
    //useMongoClient: true,
    useUnifiedTopology: true,
    useNewUrlParser: true,
    useCreateIndex: true,
    useFindAndModify: false,
    autoIndex: false, // Don't build indexes
    poolSize: 10, // Maintain up to 10 socket connections
    // If not connected, return errors immediately rather than waiting for reconnect
    bufferCommands: false, // Disable mongoose buffering
    bufferMaxEntries: 0, // and MongoDB driver buffering
    connectTimeoutMS: 10000, // Give up initial connection after 10 seconds
    socketTimeoutMS: 45000, // Close sockets after 45 seconds of inactivity
    family: 4 , // Use IPv4, skip trying IPv6
    auth:{
        authdb:"admin"
    }
};


mongoose.Promise = global.Promise;

async function loadDB() {
    mongoose.set('debug', true);
    return mongoose.connect(Config.Db.url, options);
}

module.exports = loadDB;
