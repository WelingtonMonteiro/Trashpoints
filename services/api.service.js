module.exports = {
    success,
    error,
    notFounded,
    notAuthorized,
    forbidden,
    promiseError,
    defaultResponse,
    sanitize,
    getErrorMessage
};

const _ = require('lodash');

function getErrorMessage(err) {
    let message = '';
    let getUniqueErrorMessage = function (err) {
        var output;

        try {
            var fieldName =  err.errmsg.substring(err.errmsg.lastIndexOf('.$') + 2, err.errmsg.lastIndexOf('_1'));
            output =
                 fieldName.charAt(0).toUpperCase() +
                fieldName.slice(1) + ' already exists';

        } catch (ex) {
            output = 'Unique field already exists';
        }

        return output;
    };
    if (err.code) {
        switch (err.code) {
            case 11000:
            case 11001:
                message = getUniqueErrorMessage(err);
                break;
            default:
                message = 'Something went wrong';
        }
    } else {
        for (var errName in err.errors) {
            if (err.errors[errName].message) {
                message = err.errors[errName].message;
            }
        }
    }

    return message;
}

function success(res, response) {
    if (res.sended) return;
    res.sended = true;

    response = response || {};

    const success = {
        skip: response.skip || null,
        limit: response.limit || null,
        total: response.total || 0,
        errorType: response.errorType || null,
        statusCode: response.statusCode || 200,
        message: response.message || '',
        data: response.data || null
    };

    if(response.hasOwnProperty("isExist")){
        success.isExist = response.isExist
    }
    if(response.hasOwnProperty("token") && response.token){
        success.access_token = response.token
    }

    //noinspection JSValidateTypes
    res.status(200).json(success);
}

function error(res, response) {
    if (res.sended) return;
    res.sended = true;

    response = response || {};

    if(typeof response === 'string'){
        response = {message: response};
    }

    const error = {
        skip: response.skip || null,
        limit: response.limit || null,
        total: response.total || 0,
        errorType: response.errorType || null,
        statusCode: response.statusCode || 0,
        message: getErrorMessage(response) || response.message,
        data: response.data || null
    };

    if(response.code && response.code === 11000){
        error.name = 'Regitro existente.';
        error.message = 'Operação cancelada, já existe um registro com essas informações.';
    }

    console.error('>> Socket ResponseError: ');
    console.error(response);


    //noinspection JSValidateTypes
    res.status(400).json(error);
}

function notFounded(res, ResponseError) {
    res.status(404).json(ResponseError);
}

function notAuthorized(res, ResponseError) {
    res.status(401).json(ResponseError);
}

function forbidden(res, ResponseError) {
    res.status(403).json(ResponseError);
}

function promiseError(res) {
    return (ResponseError) => {
        return error(res, ResponseError);
    };
}

function defaultResponse(res) {
    return (ResponseError, ResponseSuccess) => {
        if (ResponseError) {
            return error(res, ResponseError);
        }
        return success(res, ResponseSuccess);
    };
}

function sanitize(req, res, next) {
    try {
        if (!req.body || typeof req.body !== 'object') {
            return next();
        }

        delete req.body._id;

        req.body = correctReqBody(res, req.body);

        next();
    } catch (Exception) {
        console.log(Exception)
    }
}

function correctReqBody(res, ReqBody) {
    if (!ReqBody || typeof ReqBody !== 'object') {
        return ReqBody;
    }
    const isArray = Array.isArray(ReqBody);
    return _.reduce(ReqBody, reduceReqBody(res, isArray), isArray ? [] : {});
}

function reduceReqBody(res, isArray) {
    return (ReqBody, Value, key) => {
        if (/\$/.test(key)) {
            throw forbidden(res, {
                name: 'notAllowedSyntax'
            });
        }

        if (isArray) {
            ReqBody.push(correctReqBody(res, Value));
        } else {
            ReqBody[key] = correctReqBody(res, Value);
        }

        return ReqBody;
    };
}