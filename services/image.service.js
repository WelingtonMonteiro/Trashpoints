module.exports = {
	getBase64ByURL: getBase64ByURL
};

const superagent = require('superagent');

function getBase64ByURL(url, done) {
	superagent
		.get(url)
		.end(onGetAttachmentBase64(done));
}

function onGetAttachmentBase64(done) {
	return function(ResponseError, ResponseAttachment) {
		if (ResponseError) {
			return done(ResponseError);
		}

		const ImageBase64 = ResponseAttachment.body.toString('base64');

		done(null, ImageBase64);
	};
}