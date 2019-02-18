module.exports = {
    get: get,
    post: post
};

const request = require('supertest');
const app = require('../app');

function get(url) {
    return request(app)
        .get(url)
        .set('Accept', 'application/json')
}

function post(url, ToSend) {
    return request(app)
        .post(url)
        .set('Accept', 'application/json')
        .send(ToSend)
}