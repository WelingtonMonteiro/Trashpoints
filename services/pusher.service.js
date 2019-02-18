const Pusher = require('pusher');
const config = require('../load/load.env');
const pusher = new Pusher(config.Pusher);

module.exports = {
    send,
    auth
};

function send(channel, events, data) {
    "use strict";
    if (!channel) {
        channel = "gocart-notification";
    }

    pusher.trigger(channel, events, data);
}

function auth(socketId, channel, presenceData) {
    "use strict";
    return pusher.authenticate(socketId, channel);
}

