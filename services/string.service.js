const md5 = require('md5');
const mongoose = require('mongoose');
const generatePassword = require('generate-password');
const ObjectId = mongoose.Types.ObjectId;
const validator = require('validator');
const uuid = require('uuid');

module.exports = {
    isCNPJ,
    onlyNumbers,
    convertFloat,
    removeAccents,
    convertNumber,
    fnFullName,
    firstName,
    isEmpty,
    toUpperFirstWord,
    middleName,
    lastName,
    searchNameHash,
    searchName,
    removeEspecialChar,
    isObject,
    isObjectId,
    isGuid,
    isString,
    isChar,
    isNumber,
    isBoolean,
    isDate,
    isArray,
    isStringOrNumber,
    isKeyValue,
    zeroOnLeft,
    random,
    validateEmail,
    convertDays,
    generateObjectId,
    isValid,
    isPopulate,
    generateRandomPassword,
    Guid
};

function isGuid(string){
    return validator.isUUID(string);
}

function generateRandomPassword(lengthPass){
    let password = '';
    let repeatingCharacters = new RegExp('(.)\\1{2,}', 'g');
    let length = 6;

    // iterate until the we have a valid passphrase.
    // NOTE: Should rarely iterate more than once, but we need this to ensure no repeating characters are present.
    while (password.length < (lengthPass|| length) || repeatingCharacters.test(password)) {
        // build the random password
        password = generatePassword.generate({
            length: Math.floor(Math.random() * ((lengthPass|| length))) + (lengthPass|| length), // randomize length between 20 and 40 characters
            numbers: true,
            symbols: false,
            uppercase: true,
            excludeSimilarCharacters: true,
        });

        // check if we need to remove any repeating characters.
        return password = password.replace(repeatingCharacters, '');
    }
}
function generateObjectId(){
    return  new ObjectId();
}

function isPopulate(campo) {
    "use strict";
    let is = false;
//console.log(Object.keys(campo));
    if (!isEmpty(campo) && typeof campo === 'object' && campo._id) {
        is = true;
    }

    return is;

}

function Guid(){
    return uuid.v4();
}
function isValid(string){
    return  ObjectId.isValid(string);
}


function convertDays(string){
    if( typeof  string === "number"){
        return string;
    }

    if( typeof  string === "string" && string.toUpperCase().replace(/ /gi,"") === "INDETERMINADO"){
        return 0;
    }
    string = string.replace(/ /gi,'');

    if(string.search(/D/i) !== -1){
        if(string.search(/-/i) !== -1){
            string = string.split('-');
            string = onlyNumbers(string[string.length-1]);
            string = convertNumber(string);

            return string;

        } else {
            string = onlyNumbers(string);
            string = convertNumber(string);

            return string;
        }
    } else  if(string.search(/M/i) !== -1){
        if(string.search(/-/i) !== -1){
            string = string.split('-');
            string = onlyNumbers(string[string.length-1]);
            string = convertNumber(string);

            return string * 30;

        }else {
            string = onlyNumbers(string);
            string = convertNumber(string);

            return string * 30;
        }
    } else {
        return 0;
    }
}

function onlyNumbers(string) {
    if (!string) return '';
    if ( typeof string !== 'string') string = string.toString();

    return string.replace(/\D/gi,'');
}

function convertNumber(number) {
    if (typeof number === 'number') return number;

    number = onlyNumbers(number);
    return parseInt(number, 10);
}


function convertFloat(number) {
    if (typeof number === 'number') return number;

    return parseFloat(number);
}

function isCNPJ(cnpj) {

    if(!cnpj) {
        return
    }

    cnpj = cnpj.replace(/[^\d]+/g,'');

    if(cnpj == '') return false;

    if (cnpj.length != 14)
        return false;

    // Elimina CNPJs invalidos conhecidos
    if (cnpj == "00000000000000" ||
        cnpj == "11111111111111" ||
        cnpj == "22222222222222" ||
        cnpj == "33333333333333" ||
        cnpj == "44444444444444" ||
        cnpj == "55555555555555" ||
        cnpj == "66666666666666" ||
        cnpj == "77777777777777" ||
        cnpj == "88888888888888" ||
        cnpj == "99999999999999")
        return false;

    // Valida DVs
    var tamanho = cnpj.length - 2,
        numeros = cnpj.substring(0,tamanho),
        digitos = cnpj.substring(tamanho),
        soma = 0,
        pos = tamanho - 7;

    for (var i = tamanho; i >= 1; i--) {
        soma += numeros.charAt(tamanho - i) * pos--;
        if (pos < 2)
            pos = 9;
    }
    var resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != digitos.charAt(0))
        return false;

    tamanho = tamanho + 1;
    numeros = cnpj.substring(0,tamanho);
    soma = 0;
    pos = tamanho - 7;
    for (var i = tamanho; i >= 1; i--) {
        soma += numeros.charAt(tamanho - i) * pos--;
        if (pos < 2)
            pos = 9;
    }
    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != digitos.charAt(1))
        return false;

    return true;

}

function removeAccents(string) {
    if (!string || typeof string !== 'string') return '';

    string = string
        .replace(/[ÁÀÂÃ]/g, 'A')
        .replace(/[ÉÈÊ]/g, 'E')
        .replace(/[ÍÌÎ]/g, 'I')
        .replace(/[ÓÒÔÕ]/g, 'O')
        .replace(/[ÚÙÛ]/g, 'U')
        .replace(/[Ç]/g, 'C')
        .replace(/[Ñ]/g, 'N')

        .replace(/[áàâã]/g, 'a')
        .replace(/[éèê]/g, 'e')
        .replace(/[íìî]/g, 'i')
        .replace(/[óòôõ]/g, 'o')
        .replace(/[úùû]/g, 'u')
        .replace(/[ç]/g, 'c')
        .replace(/[ñ]/g, 'n');

    return string;
}

function removeEspecialChar(string) {
    if (!string || typeof string !== 'string') return '';

    string = string
        .replace(/[^\w\s]/gi, '');

    return string;
}

function fnFullName(string) {
    return string.replace(/\S*/g,
        function (word) {
            const wordUpper = word.toUpperCase();
            const wordLower = word.toLowerCase();
            if (wordLower === 'des' || wordLower === 'de' || wordLower === 'do' ||
                wordLower === 'da' || wordLower === 'dos' || wordLower === 'das' ||
                wordLower === 'e' || wordLower === 'della' || wordLower === 'del') {
                return wordLower;
            }
            if (wordUpper === 'I' || wordUpper === 'II' || wordUpper === 'III' || wordUpper === 'IV' || wordUpper === 'VI' || wordUpper === 'VII' ||
                wordUpper === 'VIII' || wordUpper === 'IX' || wordUpper === 'X' || wordUpper === 'XI' || wordUpper === 'XII' || wordUpper === 'XIII' ||
                wordUpper === 'XIV' || wordUpper === 'XV' || wordUpper === 'XVI' || wordUpper === 'XVII' || wordUpper === 'XVIII' ||
                wordUpper === 'XIX' || wordUpper === 'XXI' || wordUpper === 'XXII' || wordUpper === 'XXIII' || wordUpper === 'XXIV' || wordUpper === 'XXV') {
                return wordUpper;
            }
            word = word.charAt(0).toUpperCase() + word.substr(1).toLowerCase();
            return word;
        }
    );
}

function toUpperFirstWord(string) {
    return string.charAt(0).toUpperCase()+ string.substr(1).toLowerCase();
}


function isEmpty(object) {
    "use strict";
    for (var field in object) {
        return false
    }
    return true;
}

function firstName(fullName) {
    return fullName.trim().split(' ')[0];
}

function middleName(fullName) {
    const arrayName = fullName.trim().split(' '),
        lengthName = arrayName.length - 1;
    let middleName = '';

    for (let i = 1; i < lengthName; i++) {
        middleName = middleName + ' ' + arrayName[i];
    }

    middleName = middleName.trim();

    return middleName;
}

function searchNameHash(name) {
    const fullName = name.toLowerCase();
    return md5(removeEspecialChar(removeAccents(fullName).replace(/ /gi,'').toLowerCase()));
}

function searchName(name) {
    const fullName = name.toLowerCase();
    return removeEspecialChar(removeAccents(fullName).replace(/ /gi,'').toLowerCase());
}

function lastName(fullName) {
    const arrayName = fullName.trim().split(' ');
    return arrayName[arrayName.length - 1];
}

function isObject(Object) {
    return Object && typeof Object === 'object';
}

function isObjectId(objectId) {
    if (!objectId) return false;

    return isValid(objectId);

    // const objectIdString = objectId.toString();
    //
    // return /^[0-9a-fA-F]{24}$/.tests(objectIdString);
}

function isString(string) {
    return string && typeof string === 'string';
}

function isChar(string) {
    return /^[A-Z]$/i.test(string);
}

function isNumber(number) {
    return number === 0 || (number && typeof number === 'number');
}

function isStringOrNumber(stringOrNumber) {
    if (!stringOrNumber) return false;

    stringOrNumber = stringOrNumber.toString();

    return /^[0-9]*$/.test(stringOrNumber);
}

function isBoolean(boolean) {
    return typeof boolean === 'boolean';
}

function isDate(date) {
    return date && (typeof date === 'string' || date instanceof Date);
}

function isArray(array) {
    return array && Array.isArray(array);
}

function isKeyValue(KeyValue) {
    if (!isObject(KeyValue)) return false;
    //noinspection JSUnresolvedVariable
    return isNumber(KeyValue.Key) && isString(KeyValue.Value);
}

function zeroOnLeft(number, tamanho) {
    number = number.replace('null','');

    let newNumber = number + '';

    while (newNumber.length < tamanho) {
        newNumber = '0' + newNumber;
    }
    return newNumber;
}

function random(length, chars) {
    let mask = '';
    if (chars.indexOf('a') > -1) mask += 'abcdefghijklmnopqrstuvwxyz';
    if (chars.indexOf('A') > -1) mask += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (chars.indexOf('i') > -1) mask += 'abcdefghjkmnpqrstuvwxyz';
    if (chars.indexOf('I') > -1) mask += 'ABCDEFGHJKMNPQRSTUVWXYZ';
    if (chars.indexOf('#') > -1) mask += '0123456789';
    if (chars.indexOf('!') > -1) mask += '~`!@#$%^&*()_+-={}[]:";\'<>?,./|\\';
    let result = '';
    for (let i = length; i > 0; --i) result += mask[Math.floor(Math.random() * mask.length)];
    return result;
}

function validateEmail(email) {
    let patternEmail = /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/;
    return patternEmail.test(email)
}