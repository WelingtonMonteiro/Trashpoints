let mongoose = require('mongoose');
let Schema = mongoose.Schema;
let ObjectId = Schema.Types.ObjectId;

const addressSchema = {
    zipCode: {
        type: String,
        required: true,
        validate: {
            validator: function(v) {
                return /^\d{5}-\d{3}|\d{8}$/.test(v);
            },
            message: props => `${props.value} is not a valid zipcode!`
        }, 
        trim: true
    },
    state: {
        type: String,
        required: true,
        minlength: 2,
        trim: true
    },
    city: {
        type: String,
        required: true,
        minlength: 2,
        maxlength: 255, 
        trim: true
    },
    suburb: {
        type: String,
        required: true,
        minlength: 2,
        maxlength: 255, 
        trim: true
    },
    street: {
        type: String,
        required: true,
        minlength: 2,
        trim: true
    },
    number: {
        type: String,
        required: true,
        trim: true
    },
    latitude: {
        type: Number,
        required: false,
        min: -90.0,
        max: 90.0
    },
    longitude: {
        type: Number,
        required: false,
        min: -180.0,
        max: 180.0
    },
    normalizedName: {
        type: String,
        trim: true,
        required: true
    }
};

module.exports = addressSchema;