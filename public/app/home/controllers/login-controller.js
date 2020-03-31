(function () {
    'use strict';

    angular.module('trashpoints').controller('LoginCtrl', LoginCtrl);

    LoginCtrl.$inject = ['$scope', '$rootScope'];

    function LoginCtrl($scope, $rootScope) {
        $rootScope.user = null;
        console.log('LoginCtrl');
    }
})();
(function () {
    'use strict'

    angular
      .module('home')
      .controller('LoginCtrl', LoginCtrl);

    LoginCtrl.$inject = ['$scope', '$rootScope'];

    /* @ngInject */
    function LoginCtrl ($scope, $rootScope) {
        let vm = this;

        vm.searchFilter = {};
        vm.OneFunctionSample = OneFunctionSample;

        function OneFunctionSample () {
            console.log(vm.searchFilter)
        }
    }
})();
