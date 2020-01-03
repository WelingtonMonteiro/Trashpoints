const superagent = require('superagent');

module.exports = {
    getApi: getApi,
    postApi: postApi
};

function getApi(url, done, mls, header) {
        superagent
            .get(url)
            .set('Authorization', header || '')
            .timeout(mls)
            .end(done);

}

function postApi(url, object, done) {
    superagent
        .post(url)
        .send(object)
        .end(done);
}