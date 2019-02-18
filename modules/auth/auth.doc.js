/**
 * @api {POST} /api/auth/register Registrar usuário e organização
 * @apiGroup Auth
 * @apiversion 1.0.0
 * @apiParamExample {json} Envio
 * {
  "organization": {
    "companyName": "TESTE INDUSTRIA E COMERCIO LTDA",
    "fantasyName": "TESTE NOME FANTASIA",
    "cnpj": "11111111111111",
    "typeOrganization": "group",
    "address": {
      "street": "RUA X Y Z",
      "number": "0011",
      "neighborhood": "BAIRRO",
      "postalCode": "12513170",
      "city": "CIDADE",
      "state": "MG",
      "country": "Brasil",
      "complement": "",
      "coordinates": {
        "latitude": -19.488744,
        "longitude": -44.276507
      }
    },
    "phone": "(11) 1111-1111",
    "shareCapital": "15000000.00"
  },
  "user": {
    "displayName": "teste teste",
    "email": "teste@gmail.com",
    "password": "123456"
  }
}
 * @apiSuccessExample {json} Sucesso
 * HTTP/1.1 200 OK
 {
    "name": "Success",
    "code": "",
    "message": "cadastro efetuado com sucesso",
    "data": {
        "userId": "5aeb91e8f630f33c9c595da1",
        "organizationId": "5aeb91e8f630f33c9c595da2"
    },
    "total": 0,
    "error": []
}
 * @apiErrorExample {json} Erro
 * HTTP/1.1 412 OK
 {
    "name": "Error",
    "code": "412",
    "message": "Ocorreu um erro ao se registrar",
    "data": null,
    "total": 0,
    "error": ['Erro: xyz']
}
 */

/**
 * @api {POST} /api/auth/login Fazer login
 * @apiGroup Auth
 * @apiversion 1.0.0
 * @apiParam {string{30}} email Email do usuário
 * @apiParam {string{15}} password *Senha do usuário
 * @apiParamExample {json} Envio
 * {
 *	"email": "user@gmail.com",
 *  "password": "123456"
 * }
 * @apiSuccessExample {json} Sucesso
 * HTTP/1.1 200 OK
 {
    "name": "Success",
    "code": "",
    "message": "login success.",
    "data": null,
    "total": 0,
    "error": [],
    "access_token": "eyJhbGciOR5cCI6IkpXVCJ9.eyJfaWQiOiI1YWViOTFlOGY2MzBmMzNUyfQ.alfNVk5vaqBQE-cZenOIdb6g3-gIeVLRjjcD9QPswks"
}
 * @apiErrorExample {json} Erro
 * HTTP/1.1 412 OK
 {
    "name": "notFounded",
    "message": "Email ou senha inválidos"
}
 */

/**
 * @api {PUT} /api/auth/changepassword/:id Atualizar senha do usuário
 * @apiGroup Auth
 * @apiversion 1.0.0
 * @apiHeader {String} Authorization Token de acesso de retorno do login
 * @apiHeaderExample {json} Header-Example:
 * { "Authorization": "eyJhbGciOR5cCI6IkpXVCJ9.eyJfaWQiOiI1YWViOTFlOGY2MzBmMzNUyfQ.alfNVk5vaqBQE-cZenOIdb6g3-gIeVLRjjcD9QPswks" }
 *
 * @apiParamExample {json} Envio
 * {
 *      "email":"teste@gmail.com",
 *      "oldPassword":"123456",
 *      "newPassword":"1234567"
 * }
 * @apiSuccessExample {json} Sucesso
 * HTTP/1.1 200 OK
 {
    "name": "Success",
    "code": "",
    "message": "Senha alterada com sucesso.",
    "data": {
        "userId": "5ae9c767adddf41323f10b24be6",
        "organizationId": "5ae9c767ddddaf41323f10b24be7"
    },
    "total": 0,
    "error": []
}
 * @apiErrorExample {json} Erro
 * HTTP/1.1 412 OK
 {
    "name": "error",
    "message": "Email ou senha inválidos"
    }
 */

/**
 * @api {POST} /api/auth/forgotpassword Recuperar senha
 * @apiGroup Auth
 * @apiversion 1.0.0
 * @apiParamExample {json} Envio
 * {
*	"email": "teste@gmail.com"
* }
 * @apiSuccessExample {json} Sucesso
 * HTTP/1.1 200 OK
 * {
 *   name: 'forgotpassword',
 *   message: 'link de recuperação de senha enviando no email'
 * }
 * @apiErrorExample {json} Erro
 * HTTP/1.1 412 OK
 * {
 *   name: 'forgotpassword',
 *   message: 'Field "email" is required'
 * }
 */

/**
 * @api {GET} /api/auth/reset/:token Validar token enviado no email
 * @apiGroup Auth
 * @apiversion 1.0.0
 * * @apiParamExample {json} Envio
 * {
*	"email": "teste@gmail.com"
* }

 * @apiSuccessExample {json} Sucesso
 * HTTP/1.1 200 OK
 {
   "name": 'reset',
   "message": "token válido",
   "data": {
       "email": "teste@gmail.com",
       "_id": "e5d544de11s54d45ed11515e1d5e"
   }
 }
 * @apiErrorExample {json} Erro
 * HTTP/1.1 404 OK
 {
     "name": "Error",
     "message": "Ocorreu um erro"
 }
 */

/**
 * @api {POST} /api/auth/reset/:token Cadastrar nova senha
 * @apiGroup Auth
 * @apiversion 1.0.0
 * * @apiParamExample {json} Envio
 * {
 *    "email": "teste@gmail.com",
 *    "password": "123456"
 * }

 * @apiSuccessExample {json} Sucesso
 * HTTP/1.1 200 OK
 * {
 *   name: 'forgotpassword',
 *   message: 'Sua senha foi alterada com sucesso.'
 * }
 * @apiErrorExample {json} Erro
 * HTTP/1.1 404 OK
 {
     "name": "Error",
     "message": "Ocorreu um erro"
 }
 */

