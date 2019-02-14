var express = require('express');
//noinspection SpellCheckingInspection
var helmet = require('helmet');
var compression = require('compression');
var cors = require('cors');

module.exports = binMiddleware;

function binMiddleware(app, done) {
    var PORT = process.env.PORT || 3002;

    app.set('port', PORT);
    app.set('json spaces', 4);
    app.use(helmet());
    app.use(cors());
    app.use(ignoreFavicon);
    //noinspection JSUnresolvedFunction
    app.use(compression());
    //noinspection JSUnresolvedFunction
    app.use(express.static('public'));
    done();
}

function ignoreFavicon(req, res, next) {
    if (req.originalUrl === '/favicon.ico') {
        res.status(204).json({nope: true});
    } else {
        next();
    }
}
