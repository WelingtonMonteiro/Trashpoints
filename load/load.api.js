module.exports = loadRoutes;

async function loadRoutes(app) {
    require('../modules/message/message.route')(app);
    require('../modules/collaborator/collaborator.route')(app);
    require('../modules/notification/notification.route')(app);
}