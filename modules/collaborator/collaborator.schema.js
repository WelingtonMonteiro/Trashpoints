let mongoose = require('mongoose');
let Schema = mongoose.Schema;
let ObjectId = Schema.Types.ObjectId;


let CollaboratorSchema = new Schema({
    from: {
        id:{
            type: String,
            trim: true,
            required: true,
            index: true
        },
        name:{
            type: String,
            trim: true,
            required: true
        },
        uniqueName:{
            type: String,
            trim: true,
            defaul:''
        },
        imageUrl:{
            type: String,
            trim: true,
            defaul:''
        },

        isRead: {
            type: Boolean,
            default: false
        }
    },
    to: {
        id:{
            type: String,
            trim: true,
            required: true,
            index: true
        },
        name:{
            type: String,
            trim: true,
            required: true
        },
        uniqueName:{
            type: String,
            trim: true,
            default:''
        },
        imageUrl:{
            type: String,
            trim: true,
            default:''
        },

        isRead: {
            type: Boolean,
            default: false
        }
    },
    messageId: {
        type: ObjectId,
        required: true
    },
    dateTime: {
        type: Date,
        default: Date.now,
        index: true
    },
    text: {
        type: String,
        default: '',
        required: true
    }

}, {versionKey: false});

module.exports = CollaboratorSchema;
