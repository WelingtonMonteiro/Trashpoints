const CollaboratorModel = require('./collaborator.model.js');
const ApiReponseService = require('../../services/api.response.service.js');
const SocketResponseService = require('../../services/socketio.response.service');
const StringService = require('../../services/string.service.js');
const Linq = require('linq');


module.exports = {
    getAll
};


async function getAll(req, res) {
    try {

        let messageId = req.params.messageId;
        let userId = req.params.userId;
        let skip = 0;
        let limit = 0;

        let query = {
            messageId: messageId
        };
        let setUpdate = {};

        if (userId) {
            setUpdate = {'to.isRead': true};
            query.$or = [{"to.id": userId}, {"from.id": userId}];
        }


        let total = await CollaboratorModel
            .countDocuments(query);

        if (userId) {
            let updated = await CollaboratorModel
                .updateMany(query, {$set: setUpdate});
        }
        let comments = await CollaboratorModel
            .find(query, {skip: skip * limit, limit: limit})
            .sort({dateTime: 1})
            .lean();

        return ApiReponseService.success(res, {
            message: 'Comentários encontrados',
            data: comments,
            total: total
        });

    } catch (error) {
        return ApiReponseService.error(res, {message: error});
    }
}


