const mongoose = require('mongoose');
const ObjectId = mongoose.Types.ObjectId;
const uuid = require('uuid');

module.exports = {
    removeAccents,
    isEmpty,
    removeEspecialChar,
    isObject,
    isString,
    isChar,
    isNumber,
    isBoolean,
    isDate,
    isArray,
    isStringOrNumber,
    zeroOnLeft: padLeft,
    generateObjectId,
    isValid,
    isPopulate,
    Guid
};

function generateObjectId(){
    return  new ObjectId();
}

function isPopulate(field) {
    "use strict";
    let is = false;
//console.log(Object.keys(campo));
    if (!isEmpty(field) && typeof field === 'object' && field._id) {
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

function onlyNumbers(string) {
    if (!string) return '';
    if ( typeof string !== 'string') string = string.toString();

    return string.replace(/\D/gi,'');
}

function removeAccents(string) {
    if (!string || typeof string !== 'string') return '';

    return string.normalize('NFD').replace(/[\u0300-\u036f]/g, "");
}

function removeEspecialChar(string) {
    if (!string || typeof string !== 'string') return '';

    string = string
        .replace(/[^\w\s]/gi, '');

    return string;
}


function isEmpty(object) {
    "use strict";
    for (var field in object) {
        return false
    }
    return true;
}


function isObject(Object) {
    return Object && typeof Object === 'object';
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

function padLeft(number, tamanho) {
    number = number.replace('null','');

    let newNumber = number + '';

    while (newNumber.length < tamanho) {
        newNumber = '0' + newNumber;
    }
    return newNumber;
}
