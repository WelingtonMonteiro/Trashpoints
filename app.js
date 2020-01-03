const loadDb = require('./load/load.db.js');
const loadMiddlewares = require('./load/load.middlewares');
const loadRoutes = require('./load/load.routes.js');
const loadServer = require('./load/load.server.js');
const express = require('express');
const app = express();

const db = loadDb();
const middeware = loadMiddlewares(app);
const server = loadServer(app);

loadRoutes(app);

module.exports = app;
