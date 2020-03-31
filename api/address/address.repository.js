const genericRepository = require('../generic/generic.repository')
const collection = require('./address.schema')

const AddressRepository = genericRepository({ collection })({

})

module.exports = AddressRepository
