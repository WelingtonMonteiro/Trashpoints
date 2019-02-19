'use strict';
const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const ObjectId = Schema.Types.ObjectId;

const UserSchema = {
    email: {
        type: String,
        required: true,
        minlength: 5,
        maxlength: 180, 
        trim: true,
        unique: true
    },
    password: {
        type: String,
        required: true,       
        trim: true
    },
    emailVerified: {
        type: Boolean,
        default: false
    },
    enabled: {
        type: Boolean,
        default: true
    }, 
    resetPasswordToken: {
        type: String,
        trim: true,
        default: ''
    }, 
    expiredToken: {
        type: Date,
        default: null
    },
};

module.exports = UserSchema;
