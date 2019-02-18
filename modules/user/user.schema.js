let mongoose = require('mongoose');
let Schema = mongoose.Schema;
let ObjectId = Schema.Types.ObjectId;

let UserSchema = new Schema({
    _id: {
        type: String,
        trim: true,
        required: true
    },
    id: {
        type: String,
        trim: true
    },
    onesignalPlayersIds: {
        type: [{
            type: String
        }],
        default: []
    }
}, {
    versionKey: false,
    strict: true
});

module.exports = UserSchema;
