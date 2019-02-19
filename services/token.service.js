const jsonwebtoken = require('jsonwebtoken');
const config = require('../load/load.config');
const RequestApi = require('./request.service');

module.exports = {
    create,
    validate,
    apiValidate
};

function create(User) {
    let token;
    const OptionsJWT = {
        expiresIn: '3d'
    };

    try {
        token = jsonwebtoken.sign(User, config.JWT.secret, OptionsJWT);
    } catch (exception) {
        token = null;
    }

    return token;
}

function validate(token, done) {
    const OptionsJWT = {
        ignoreExpiration: true
    };

    token = token.replace(/^JWT |^Bearer | /gi, '').replace('undefined', '');

    if (!token) {
        return done('"Token" é obrigatório');
    }

    try {
        jsonwebtoken.verify(token, config.JWT.secret, OptionsJWT, onValidateToken);
    } catch (exception) {
        done(exception);
    }

    function onValidateToken(Error, ObjectToken) {
        if (Error) {
            return done('Token de acesso inválido');
        }
        done(false, ObjectToken);
    }
}

function apiValidate(token, done) {

    token = token.replace(/^JWT |^Bearer | /gi, '').replace('undefined', '');

    if (!token) {
        return done('"Token" é obrigatório');
    }

    let uri = `${config.GoCartApi.url}/api/token`;
    let bearer = `${uri}=Bearer ${token}`;

    RequestApi.getApi(`${uri}`, bearer, onReponse);

    function onReponse(err, validationResponse) {
        if (err) {
            return done('Falha ao se conectar com servidor de identificação');
        }
        if (validationResponse.statusCode === 200) {
            let claims = rearrangeClaims(validationResponse.body);

            if(!claims) return done('Token de autenticação inválido ou vazio');

            return done(false, claims);
        }
        return done('Token de autenticação inválido ou vazio');
    }


}

function rearrangeClaims(tokenDecoded) {
    let claims = {};

    tokenDecoded.forEach((item) => {
        if (item.type) {
            if(claims[item.type]){
                let temp = claims[item.type];

                if(Array.isArray(claims[item.type])) {
                    claims[item.type].push(item.value);
                }
                else{
                    claims[item.type] = [temp];
                    claims[item.type].push(item.value);
                }
            }else {
                claims[item.type] = item.value;
            }
        }
    });

     return claims;
}