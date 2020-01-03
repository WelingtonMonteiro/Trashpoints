/**
 * Created by Welington on 29/01/2019.
 */

module.exports = loadServer;

const http = require('http');

function loadServer(app) {

    let server = http
        .createServer(app);

    server.listen(app.get('port'), onListen(app));

    return server;
}

function onListen(app) {
    return function () {
        'use strict';

        let megabyte = 1024 * 1024,
            mem = process.memoryUsage(),
            memoria = {
                rss: Math.ceil(mem.rss / megabyte * 100) / 100,
                heapTotal: Math.ceil(mem.heapTotal / megabyte * 100) / 100,
                heapUsed: Math.ceil(mem.heapUsed / megabyte * 100) / 100
            };
        console.log(`API Node.js Modelo v1.0.0 \n\n- Porta: ${app.get('port')}\n- Em modo: ${process.env.ENV} \n\n`);
        console.log(`Consumo de memória\n\n- RSS: ${memoria.rss}(MB)\n- HeapTotal: ${memoria.heapTotal}(MB)\n- HeapUsado: ${memoria.heapUsed}(MB) \r`);
        console.log(`Listening on http://${ process.env.SERVER_HOSTNAME}`);
    };
}
