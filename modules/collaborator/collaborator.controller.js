const CollaboratorService = require('./collaborator.service.js');
const ApiResponseService = require('../../services/api.response.service.js');
const StringService = require('../../services/string.service.js');


module.exports = {
    getAll
};


async function getAll(req, res) {
    let messageId = req.params.messageId;
    let userId = req.params.userId;

    if (!StringService.isObjectId(messageId)) {
        return ApiResponseService.error(res, {message: 'Campo "userId" é obrigatório'});
    }

    if (userId) {
        userId = userId.replace(/undefined|null| /gi, "");
        req.params.userId = userId;
    }

    await CollaboratorService.getAll(req, res);
}
