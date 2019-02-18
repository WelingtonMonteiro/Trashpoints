const mongoose = require('mongoose');
const CommentSchema = require('./collaborator.schema.js');
const CollaboratorModel = mongoose.model('Comment', CommentSchema, 'comments');

module.exports = CollaboratorModel;