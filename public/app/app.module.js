var env = {};

// Import variables if present (from env.js)
if(window){
    Object.assign(env, window.__env);
}

(function() {
    'use strict';

    angular
        .module('app', [
            'ui.router',

            'app.services',
            'app.login',
            'app.forgot-password',
            'app.register',
        ])
        .config(function(toastrConfig) {
            angular.extend(toastrConfig, {
                escapeHtml: true,
                autoDismiss: false,
                containerId: 'toast-container',
                maxOpened: 0,
                newestOnTop: true,
                positionClass: 'toast-top-full-width',
                preventDuplicates: false,
                preventOpenDuplicates: false,
                target: 'body'
            });
        })
        .constant('__env', env);
})();