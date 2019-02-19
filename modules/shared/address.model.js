const mongoose = require('mongoose');
const AddressSchema = require('./address.schema.js');
const options = { versionKey: false };

const AddressModel = mongoose.model('Address', new mongoose.Schema(AddressSchema, options), 'addresses');

module.exports = AddressModel;