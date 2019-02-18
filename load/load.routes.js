module.exports = loadRoutes;

async function loadRoutes(app) {
    require('../modules/auth/auth.route')(app);
    require('../modules/collaborator/collaborator.route')(app);
}