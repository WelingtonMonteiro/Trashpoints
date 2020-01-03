const genericService = require('../generic/generic.service')
const repository = require('./address.repository')

const AddressService = genericService({ repository })({

})

module.exports = AddressService
