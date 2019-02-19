const ApiResponseService = require('../../services/api.response.service');
const ValidatorTokenService = require('../../services/token.service');
const Busboy = require('busboy');


//noinspection SpellCheckingInspection
module.exports = {
    Upload: {
        onLoadFile,
    },

    Rule: {
        empty,
        logged,
        roles
    }
};

function authenticate(socket, data) {
    const token = data.token;

    if (!token) {
        return SocketResponseService.error(socket, socket.id, 'unauthorized', {message: 'Token não enviado'});
    }

    ValidatorTokenService.apiValidate(token, (error, decode) => {
        if (error) {
            return SocketResponseService.error(socket, socket.id, {
                code: 401,
                message: 'Token inválido, por favor refaça o login'
            });
        }

        if (!decode.typeEnv || decode.typeEnv !== process.env.NODE_ENV) {
            return SocketResponseService.error(socket, socket.id, {
                code: 401,
                message: 'Token inválido, por favor refaça o login'
            });
        }

        console.log(`authenticated socket ID "${socket.id}"`);

        socket.authenticated = true;
        socket.decodedToken = decode;

        return SocketResponseService.success(socket, socket.id, 'authorized', {message: 'Usuário autenticado.'});
    });


}


//  -----   RULES  ----
function empty(req, res, next) {
    //noinspection JSUnresolvedVariable
    let token = req.headers.authorization;

    // if (token) {
    //     return ruleLogged(req, res, next);
    // }

    if (req.method === 'POST') {
        if (typeof req.body === 'string') {
            req.body = JSON.parse(req.body);
        }
    }

    req.Token = {
        _id: null
    };

    next();
}

function onLoadFile(req, res, next) {
    let Body = {};


    let busboy = new Busboy({headers: req.headers});

    busboy.on('finish', function (rerer, rere) {

        for (let item in req.files) {

            Body = {
                enconding: req.files[item].encoding,
                mimetype: req.files[item].mimetype,
                data: req.files[item].data,
                name: req.files[item].name,
                size: req.files[item].size
            };
        }

        req.File = Body;


        next();

    });
    req.pipe(busboy);

}

function logged(req, res, next) {
    //noinspection JSUnresolvedVariable
    let token = req.params.token || req.headers.authorization;

    if (req.method === 'POST' || req.method === 'PUT') {
        if (typeof req.body === 'string') {
            req.body = JSON.parse(req.body);
        }
        if (typeof req.body.fields === 'string') {
            req.body = JSON.parse(req.body.fields);
        }
    }

    if (!token) {
        return ApiResponseService.notAuthorized(res, {
            name: 'tokenRequired',
            message: 'Campo "token" é obrigatório'
        });
    }

    ValidatorTokenService.apiValidate(token, onValidateTokenInLogged);

    function onValidateTokenInLogged(error, TokenObject) {
        if (error) {
            return ApiResponseService.notAuthorized(res, {
                code: 401,
                name: 'invalidToken',
                message: 'Token inválido, por favor refaça o login'
            });
        }


        if (!TokenObject.typeEnv || TokenObject.typeEnv !== process.env.NODE_ENV) {
            return ApiResponseService.notAuthorized(res, {
                code: 401,
                name: 'invalidToken',
                message: 'Token inválido, por favor refaça o login'
            });
        }

        req.Token = TokenObject;

        next();
    }
}

function roles(roles) {
    return function (req, res, next) {

        logged(req, res, onValidToken);

        function onValidToken() {

            // let isPermit = roles.join(',').indexOf(TokenObject.roles.join(',') !== -1);
            let isPermit = false;
            let Token = req.Token;

            roles.forEach(function (item) {
                Token.roles.forEach(function (item2) {
                    if (item2 === item) {
                        isPermit = true;
                    }
                })
            });

            if (!isPermit) {
                return ApiResponseService.notAuthorized(res, {
                    name: 'permissionRequired',
                    message: 'Desculpe, você não tem permissão para acessar essa funcionalidade.'
                });
            }

            req.Token = Token;

            next();
        }
    };
}
