const mongoose = require('mongoose')
const ObjectId = mongoose.Types.ObjectId
const uuid = require('uuid')

module.exports = class StringService {
  static onlyNumbers(string) {
    if (!string) return ''
    if (typeof string !== 'string') string = string.toString()

    return string.replace(/\D/gi, '')
  }

  static removeAccents(string) {
    if (!string || typeof string !== 'string') return ''

    return string.normalize('NFD').replace(/[\u0300-\u036f]/g, "")
  }

  static removeEspecialChar(string) {
    if (!string || typeof string !== 'string') return ''

    string = string
      .replace(/[^\w\s]/gi, '')

    return string
  }

  static isEmpty(object) {
    "use strict"
    for (let field in object) {
      return false
    }
    return true
  }

  static isObject(Object) {
    return Object && typeof Object === 'object'
  }

  static isString(string) {
    return string && typeof string === 'string'
  }

  static isChar(string) {
    return /^[A-Z]$/i.test(string)
  }

  static isNumber(number) {
    return number === 0 || (number && typeof number === 'number')
  }

  static generateObjectId() {
    return new ObjectId()
  }

  static isValid(string) {
    return ObjectId.isValid(string)
  }

  static isPopulate(field) {
    "use strict"
    let is = false
//console.log(Object.keys(campo))
    if (!isEmpty(field) && typeof field === 'object' && field._id) {
      is = true
    }
    return is
  }

  static Guid() {
    return uuid.v4()
  }

  static isStringOrNumber(stringOrNumber) {
    if (!stringOrNumber) return false

    stringOrNumber = stringOrNumber.toString()

    return /^[0-9]*$/.test(stringOrNumber)
  }

  static isBoolean(boolean) {
    return typeof boolean === 'boolean'
  }

  static isDate(date) {
    return date && (typeof date === 'string' || date instanceof Date)
  }

  static isArray(array) {
    return array && Array.isArray(array)
  }

  static zeroOnLeft(number, tamanho) {
    number = number.replace('null', '')

    let newNumber = number + ''

    while (newNumber.length < tamanho) {
      newNumber = '0' + newNumber
    }
    return newNumber
  }
}
