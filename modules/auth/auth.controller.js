const ApiResponseService = require('../../services/api.response.service');
const SocketResponseService = require('../../services/socketio.response.service');
const ValidatorTokenService = require('../../services/token.service');
const B24Service = require('../../services/bitrix24.service');
const Busboy = require('busboy');


//noinspection SpellCheckingInspection
module.exports = {

    getTokenBitrix,
    authBitrix,

    Upload: {
        onLoadFile,
    },

    Rule: {
        empty,
        logged,
        roles
    },
    Socket: {
        joinConsumer,
        joinStore,
        reconnect,
        disconnect,
        authenticate
    }
};

// --------- SOCKET ----------//
function reconnect(socketId) {
    console.log(`Reconectando ... : ${socketId}\n`);
}

function disconnect(io, socket, data) {

    let online = io.sockets.clients();
    let clientId = global.SOCKETS[socket.id];
    let client = global.CLIENTS[clientId];

    if (clientId) {

        delete global.CLIENTS[clientId];
        delete global.SOCKETS[socket.id];

        socket.isLoggedChat = false;
        socket.isLoggedChat = false;

        console.log(`Cliente: ${client.name} saiu do chat ... \n`);
    }


    socket.disconnect();
}

function joinConsumer(socket, data) {

    if (!global.CLIENTS[data.id]) {
        socket.isLoggedChat = true;

        data.isConsumer = true;
        data.isLoggedChat = true;
        data.socketId = socket.id;

        global.CLIENTS[data.id] = data;
        global.SOCKETS[socket.id] = data.id;

        console.log(`Cliente: ${data.name} entrou ... \n`);
    }
}

function joinStore(socket, data) {

    if (!global.CLIENTS[data.id]) {
        socket.isLoggedChat = true;

        data.isStore = true;
        data.isLoggedChat = true;
        data.socketId = socket.id;

        global.CLIENTS[data.id] = data;
        global.SOCKETS[socket.id] = data.id;

        console.log(`Loja: ${data.name} entrou ...\n`);
    }
}

async function authBitrix(req, res) {
    res.redirect(B24Service.bitrix24.auth.authorization_uri);
}

//get and save token bitrix in memory
async function getTokenBitrix(req, res) {
    try {
        const code = req.query.code;

        const result = await B24Service.bitrix24.auth.getToken(code);

        return res.json(result);
    } catch (err) {

        return res.status(500).json({error: "Authentication Failed", message: err.message});
    }
}

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
