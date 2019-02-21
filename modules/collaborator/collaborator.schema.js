let mongoose = require('mongoose');
let Schema = mongoose.Schema;
let ObjectId = Schema.Types.ObjectId;
//let addressModel = require('../shared/address.model');
const minSizeName = 5;
const maxSizeName = 60;

let CollaboratorSchema = {   
    name: {
        type: String,
        required: 'Nome é obrigatório',
        minlength: [minSizeName, `Tamanho mínino do nome são ${minSizeName} caracteres`],
        maxlength: [maxSizeName, `Tamanho máximo do nome são ${maxSizeName} caracteres`], 
        trim: true
    },
    phone: {
        type: String,
        validate: {
            validator: function(v) {
                return /^(?:(?:\+|00)?(55)\s?)?(?:\(?([1-9][0-9])\)?\s?)?(?:((?:9\d|[2-9])\d{3})\-?(\d{4}))$/.test(v);
            },
            message: props => `${props.value} não é um telefone válido!`
        },
        required: [true, 'Telefone é obrigatório'],
        trim: true
    },
    photo: {
        type: String,
        default: '',
        trim: true
    },
    dateOfBirth: {
        type: Date,
        required: 'Data de nascimento é obrigatório'
    },
    isAddressEqual: {
        type: Boolean,
        default: false
    },
    addressId: {
        type: ObjectId,
        ref: 'Address',
        required: 'Endereço é obrigatório'
    }
};

module.exports = CollaboratorSchema;