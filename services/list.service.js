const async = require('async');
const mongoose = require('mongoose');
const ObjectId = mongoose.Types.ObjectId;
const _ = require('lodash');

module.exports = {
    each: each,
    ensureObjectIds: ensureObjectIds
};

function ensureObjectIds(ListIds) {
    return _.map(ListIds, mapIds());
}

function mapIds() {
    return function (id) {
        try {
	        id = id.toString();
	        return ObjectId(id);
        } catch(ResponseException) {
            return id;
        }
    };
}

function each(List, iterator, done) {
    if (typeof List !== 'object') {
        List = [];
    } else {
        if (List && !Array.isArray(List)) {
            List = [List];
        }
    }
    if (typeof iterator !== 'function') {
        iterator = function (Item, next) {
            console.log('Iterate: ', Item);
            next();
        };
    }
    if (typeof done !== 'function') {
        done = function (ResponseError, ResponseSuccess) {
            if (ResponseError) {
                return console.log('Iterate Error: ', ResponseError);
            }
            return console.log('Iterate Success: ', ResponseSuccess);
        };
    }

    let NewList = [];
    async.forEachSeries(List, newIterator(NewList, iterator), newDone(NewList, done));
}

function newIterator(NewList, iterator) {
    return function (Item, next) {
        iterator(Item, newNext(NewList, next));
    };
}

function newNext(NewList, next) {
    return function (ResponseError, ResponseSuccess) {
        if (ResponseError) {
            return next(ResponseError);
        }
        NewList.push(ResponseSuccess);
        return next();
    };
}

function newDone(NewList, done) {
    return function (ResponseError) {
        if (ResponseError) {
            if (typeof done === 'function') {
                return done(ResponseError);
            }
        }
        if (typeof done === 'function') {
            return done(null, NewList);
        }
    };
}