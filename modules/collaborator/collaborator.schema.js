let mongoose = require('mongoose');
let Schema = mongoose.Schema;
let ObjectId = Schema.Types.ObjectId;
//let addressModel = require('../shared/address.model');

let CollaboratorSchema = {   
    name: {
        type: String,
        required: true,
        minlength: 5,
        maxlength: 60, 
        trim: true
    },
    phone: {
        type: String,
        validate: {
            validator: function(v) {
                return /^(?:(?:\+|00)?(55)\s?)?(?:\(?([1-9][0-9])\)?\s?)?(?:((?:9\d|[2-9])\d{3})\-?(\d{4}))$/.test(v);
            },
            message: props => `${props.value} is not a valid phone number!`
        },
        required: [true, 'User phone number required'],
        trim: true
    },
    photo: {
        type: String,
        default: '',
        trim: true
    },
    dateOfBirth: {
        type: Date,
        required: true
    },
    isAddressEqual: {
        type: Boolean,
        default: false
    },
    addressId: {
        type: ObjectId,
        ref: 'Address',
        required: true
    }
};

module.exports = CollaboratorSchema;