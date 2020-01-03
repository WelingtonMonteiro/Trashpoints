const forever = require('forever-monitor');
const Monitor = forever.Monitor;
const config = {
    max: 10,
    silent: false,
    killTree: true,
    logFile: 'forever.log',
    outFile: 'app.log',
    errFile: 'error.log'
};

const child = new Monitor('app.js', config);

child.on('exit', onExit);

function onExit() {
    'use strict';

    console.log('O server foi finalizado.');
}

child.start();