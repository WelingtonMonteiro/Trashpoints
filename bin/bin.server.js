module.exports = binServer;

var http = require('http');

function binServer(app) {
    //noinspection JSUnresolvedFunction
    http
        .createServer(app)
        .listen(app.get('port'), onListen(app));
}

function onListen(app) {
    return function () {
        console.log('Econform UI iniciado - Porta: ' + app.get('port'));
    };
}