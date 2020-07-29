const genericController = require('../generic/generic.controller')
const service = require('./address.service')

const AddressController =  genericController({ service })({

})

module.exports = AddressController
