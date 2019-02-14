var loadMiddlewares = require('./bin/bin.middlewares');
var loadServer = require('./bin/bin.server.js');
var express = require('express');
var app = express();

module.exports = app;

loadMiddlewares(app, onLoadMiddleware);

function onLoadMiddleware() {
    loadServer(app);
}

