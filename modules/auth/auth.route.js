let AuthController = require('../auth/auth.controller');
let B24Service = require('../../services/bitrix24.service');

module.exports = function (app, io) {
    app.get('/callback', AuthController.Rule.empty, AuthController.getTokenBitrix);

    app.get('/auth', AuthController.Rule.empty, AuthController.authBitrix);

};