(function () {
    'use strict';

    angular.module('trashpoints').controller('HomeCtrl', HomeCtrl);

    HomeCtrl.$inject = ['$scope', '$rootScope'];

    function HomeCtrl($scope, $rootScope) {
        $rootScope.user = null;
        console.log('HomeCtrl');
    }

})();