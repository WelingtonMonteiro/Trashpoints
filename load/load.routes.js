/**
 * Created by Welington on 29/01/2019.
 */

module.exports = loadRoutes;

async function loadRoutes(app) {
    require('../api/address/address.route')(app);
}
