var cluster = require('cluster'),
  http,
  numCPUs = require('os').cpus().length;

if (cluster.isMaster) {
    var i;

    for (i = 0; i < numCPUs; i++) {
        cluster.fork();
    }

    cluster.on('listening',     (worker) =>     console.log("Cluster %d conectado", worker.process.pid));
    cluster.on('disconnect',    (worker) =>     console.log('Cluster %d esta desconectado.', worker.process.pid));
    cluster.on('exit',          (worker) =>     console.log('Cluster %d foi desconectado.', worker.process.pid));

} else {
    http = require('./app');
}
