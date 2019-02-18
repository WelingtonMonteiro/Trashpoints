const superagent = require('superagent');

module.exports = {
    getApi: getApi,
    postApi: postApi
};

function getApi(url, header, done) {
        superagent
            .get(url)
            .set('Authorization', header || '')
            .end(done);

}

function postApi(url, object, done) {
    superagent
        .post(url)
        .send(object)
        .end(done);
}