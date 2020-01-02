(function () {
    'use strict';

    angular.module('trashpoints').controller('LoginCtrl', LoginCtrl);

    LoginCtrl.$inject = ['$scope', '$rootScope'];

    function LoginCtrl($scope, $rootScope) {
        $rootScope.user = null;
        console.log('LoginCtrl');
    }
})();