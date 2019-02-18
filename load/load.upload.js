module.exports = {
    inMemory: inMemory,
    inDisk: inDisk
};

const multer = require('multer');

function inMemory() {
     return multer({inMemory: true});
}

function inDisk() {
	return multer({dest: 'upload'});
}