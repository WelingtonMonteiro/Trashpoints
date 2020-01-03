/**
 * Created by Welington on 29/01/2019.
 */

const bodyParser = require('body-parser');
const express = require('express');
const morgan = require('morgan');
//noinspection SpellCheckingInspection
const cors = require('cors');
const helmet = require('helmet');
const compression = require('compression');
const busboy = require('connect-busboy');
const busboyBodyParser = require('busboy-body-parser');
const ejs =  require('ejs');
var path= require('path');


module.exports = loadMiddleware;

function loadMiddleware(app) {
    const PORT = process.env.PORT || 3003;

    app.set('port', PORT);
    app.set('json spaces', 4);
    // Setting .html as the default template extension
    // app.set('view engine', 'html');
    // // Initializing the ejs template engine
    // app.engine('html', ejs.renderFile);
    // // Telling express where it can find the templates
    // app.set('views', (__dirname + '/../views'));
    // //Files


    app.use(busboy());
    app.use(morgan('dev'));
    app.use(helmet());
    app.use(cors());
    // app.use(compression());
    app.use(bodyParser.json({limit: '5mb'}));
    app.use(bodyParser.urlencoded({extended: true, limit: '5mb'}));

    app.use(busboyBodyParser());
    app.use(express.static('public'));


    app.get('/memoryUsage', function (req, res) {
        'use strict';

        var megabyte = 1024 * 1024,
            mem = process.memoryUsage(),
            memoria = {
                rss: Math.ceil(mem.rss / megabyte * 100) / 100,
                heapTotal: Math.ceil(mem.heapTotal / megabyte * 100) / 100,
                heapUsed: Math.ceil(mem.heapUsed / megabyte * 100) / 100
            },
            texto;
        console.log('Consumo de memória: RSS: ' + memoria.rss + ', HeapTotal: ' + memoria.heapTotal + ', HeapUsado: ' + memoria.heapUsed);


        texto = 'Server  <p><p><p>Hora atual: <b>' + new Date(Date.now()) + '</b> <p>Servidor executando ' +
            '</b> em modo: <b>' + app.settings.env + '</b><p>Consumo de memória: </br>RSS: <b>' + memoria.rss + '(MB)</b>, </br>HeapTotal: <b>' + memoria.heapTotal + '(MB)</b>, <br>HeapUsado: <b>' + memoria.heapUsed + '(MB)</b>';

        res.status(200).send(texto);
    });

    return app;
}

