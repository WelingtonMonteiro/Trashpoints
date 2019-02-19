const mongoose = require('mongoose');
const UserSchema = require('./user.schema.js');
const options = { versionKey: false };

const UserModel = mongoose.model('User', new mongoose.Schema(UserSchema, options), 'users');

module.exports = UserModel;