//noinspection SpellCheckingInspection
const bcryptjs = require('bcryptjs');
//noinspection JSUnresolvedFunction
const salt = bcryptjs.genSaltSync();

module.exports = {
    create: create,
    compare: compare
};

function create(password) {
    //noinspection JSUnresolvedFunction
    return bcryptjs.hashSync(password, salt);
}

//noinspection SpellCheckingInspection
function compare(password, passwordCrypted) {
    //noinspection JSUnresolvedFunction
    return bcryptjs.compareSync(password, passwordCrypted)
}

