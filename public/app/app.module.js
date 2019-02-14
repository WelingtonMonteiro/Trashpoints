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
            'ngAnimate',
            'toastr',
            'angular-jwt',
            'angular.filter',
            // 'ui.select',
            // 'ngSanitize',

            'app.services',
            'app.login',
            'app.forgot-password',
            'app.register',
            'app.waiting',
            'app.upload.license',
            'app.dashboard',
            'app.drive',
            'app.company',
            'app.topbar',
            'app.userControl',
            'app.diary',
            'app.wizard',

            'app.login.adm',
            'app.topbar.adm',
            'app.dashboard.adm',
            'app.pop.adm'
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
        .directive('ngEnter', function () {
            return function (scope, element, attrs) {
                element.bind("keydown keypress", function (event) {
                    if (event.which === 13) {
                        scope.$apply(function () {
                            scope.$eval(attrs.ngEnter);
                        });
                        event.preventDefault();
                    }
                });
            };
        })
        .constant('__env', env);
})();