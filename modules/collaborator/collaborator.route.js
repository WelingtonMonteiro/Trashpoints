let CollaboratorController = require('./collaborator.controller.js');
let AuthController = require('../auth/auth.controller');

module.exports = function (app) {
    app.get('/api/collaborator', AuthController.Rule.empty, CollaboratorController.getAll);
    app.post('/api/collaborator', AuthController.Rule.empty, CollaboratorController.create);
};