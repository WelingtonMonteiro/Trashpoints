(function () {
    'use strict'

    angular
      .module('home')
      .controller('HomeCtrl', HomeCtrl);

    HomeCtrl.$inject = ['$scope', '$rootScope'];

    /* @ngInject */
    function HomeCtrl ($scope, $rootScope) {
        var vm = this;
        vm.searchFilter = {};
        vm.OneFunctionSample = OneFunctionSample;

        function OneFunctionSample () {
            console.log(vm.searchFilter)
        }
    }
})();
