const mongoose = require('mongoose');
const CollaboratorSchema = require('./collaborator.schema.js');
const options = { versionKey: false };

const CollaboratorModel = mongoose.model('Collaborator', new mongoose.Schema(CollaboratorSchema, options), 'collaborators');

module.exports = CollaboratorModel;