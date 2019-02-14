var cluster = require('cluster'),
    http,
    numCPUs = require('os').cpus().length;

if (cluster.isMaster) {
    var i;

    for (i = 0; i < numCPUs; i++) {
        cluster.fork();
    }

    cluster.on('listening', function (worker) {
        'use strict';

        console.log("Cluster %d conectado", worker.process.pid);
    });
    cluster.on('disconnect', function (worker) {
        'use strict';

        console.log('Cluster %d esta desconectado.', worker.process.pid);
    });
    cluster.on('exit', function (worker) {
        'use strict';

        console.log('Cluster %d foi desconectado.', worker.process.pid);
    });
} else {
    http = require('./app');
}