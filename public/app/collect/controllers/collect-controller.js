(function () {
  'use strict'

  angular
    .module('collect')
    .controller('CollectCtrl', CollectCtrl);

  CollectCtrl.$inject = ['$scope', '$rootScope'];

  /* @ngInject */
  function CollectCtrl ($scope, $rootScope) {
    let vm = this;
    vm.OneFunctionSample = OneFunctionSample;

    function OneFunctionSample () {
      console.log('log ...')
    }
  }
})();
