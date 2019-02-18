const mongoose = require('mongoose');
const UserSchema = require('./user.schema.js');
const UserModel = mongoose.model('User', UserSchema, 'users');

module.exports = UserModel;