const ListService = require('./list.service');
const StringService = require('./string.service');
const async = require('async');

module.exports = {
    insert
};


function insert(Model, NewObject, done, objectId) {
    let newArray = [];
    if (!StringService.isEmpty(NewObject) && !Array.isArray(NewObject)) {
        NewObject = [NewObject];
    }
    async.eachSeries(NewObject, eachToInsert, endInsert);

    // ListService.each(NewObject, eachToInsert(Model), endInsert(done));


    function eachToInsert(item, next) {

        if (item.hasOwnProperty('_id')) {
            delete item._id;
        }
        const ObjectToInsert = new Model(item);

        if (objectId) {
            ObjectToInsert.organization = objectId;
        }

        //noinspection JSIgnoredPromiseFromCall
        ObjectToInsert.save(onInsert);

        function onInsert(ResponseError, ObjectCreated) {
            if (ResponseError) {
                return next(ResponseError);
            }
            if (ObjectCreated) {
                newArray.push({_id: ObjectCreated._id});
            }

            next();
        }
    }

    function endInsert(ResponseError, Result) {
        done(ResponseError, newArray);
    }

}
