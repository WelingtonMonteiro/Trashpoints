const Collaborator = require('./collaborator.model.js');
const Address = require('../shared/address.model.js');
const ApiReponseService = require('../../services/api.response.service.js');
const StringService = require('../../services/string.service.js');
const Linq = require('linq');

module.exports = {
    getAll, create
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


        let total = await Collaborator
            .countDocuments(query);

        if (userId) {
            let updated = await Collaborator
                .updateMany(query, {$set: setUpdate});
        }
        let comments = await Collaborator
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

async function create(req, res) {
    try {   
        let requestDTO = req.body; 

        let address = new Address(requestDTO);
        address.normalizedName = StringService.searchName(address.state.concat(address.city).concat(address.suburb));

        let collaborator = new Collaborator(requestDTO);

        let errorAddress = address.validateSync();
        if(errorAddress != null)
            return ApiReponseService.error(res, {message: errorAddress});

        collaborator.addressId = address.id;
        let errorCollaborator = collaborator.validateSync();

        if(errorCollaborator != null)
            return ApiReponseService.error(res, {message: errorCollaborator});

        //send email        

        await address.save(address);
        await collaborator.save(collaborator);

        return ApiReponseService.success(res, {
            message: 'Dados salvos com sucesso'
        });

    } catch (error) {
        return ApiReponseService.error(res, {message: error});
    }
}


